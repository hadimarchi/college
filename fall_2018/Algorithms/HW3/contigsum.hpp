#ifndef CONTIGSUM_HPP
#define CONTIGSUM_HPP

#include <algorithm>
using std::max;
using std::min;

struct ABCD{
  int max_contig_sum, max_with_first, max_with_last, full_sum;
  ABCD(int A, int B, int C, int D):
  max_contig_sum(A), max_with_first(B), max_with_last(C), full_sum(D) {}
};

int maxWithLast(const ABCD & first_half, const ABCD & second_half);
int maxWithFirst(const ABCD & first_half, const ABCD & second_half);
int maxContigSum(const ABCD & first_half, const ABCD & second_half);
int fullSum(const ABCD & first_half, const ABCD & second_half);
ABCD createWholeABCD(const ABCD & first_half, const ABCD & second_half);

template<typename RAIter>
int contigSum(RAIter first, RAIter last);

template<typename RAIter>
ABCD recurseCallContigSum(RAIter first, RAIter last);


template<typename RAIter>
int contigSum(RAIter first, RAIter last){
  auto iter_range = last - first;
  if (iter_range==0){return 0;}

  auto whole_ABCD = recurseCallContigSum(first, last-1);

  return max(0, whole_ABCD.max_contig_sum);
}

template<typename RAIter>
ABCD recurseCallContigSum(RAIter first, RAIter last){
  auto iter_range = last-first;
  if (iter_range==0){return ABCD(*first, *first, *first, *first);}
  if (iter_range == 1){return ABCD(max({*first, *first+*last, *last}),
                                   max(*first, *first+*last),
                                   max(*last, *first+*last),
                                   *first+*last);}

  ABCD first_half = recurseCallContigSum(first, min(first + (iter_range)/2, last-1));
  ABCD second_half = recurseCallContigSum(min(last, first + (iter_range)/2+1), last);


  return createWholeABCD(first_half, second_half);
}

int maxWithLast(const ABCD & first_half, const ABCD & second_half){
  return max({0,
              second_half.max_with_last,
              first_half.max_with_last + second_half.full_sum});
}

int maxWithFirst(const ABCD & first_half, const ABCD & second_half){
  return max({0,
              first_half.max_with_first,
              first_half.full_sum + second_half.max_with_first});
}

int maxContigSum(const ABCD & first_half, const ABCD & second_half){
  return max({first_half.max_contig_sum,
              second_half.max_contig_sum,
              first_half.max_with_last + second_half.max_with_first});
}
int fullSum(const ABCD & first_half, const ABCD & second_half){
  return first_half.full_sum + second_half.full_sum;
}

ABCD createWholeABCD(const ABCD & first_half, const ABCD & second_half){
  auto max_contig_sum = maxContigSum(first_half, second_half);
  auto max_with_first = maxWithFirst(first_half, second_half);
  auto max_with_last = maxWithLast(first_half, second_half);
  auto full_sum = fullSum(first_half, second_half);

  return ABCD(max_contig_sum, max_with_first, max_with_last, full_sum);
}
#endif
