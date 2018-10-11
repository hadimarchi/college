#ifndef CONTIGSUM_HPP
#define CONTIGSUM_HPP
#include <algorithm>
using std::max;
#include <numeric>
using std::accumulate;

struct ABCD{
  int max_contig_sum, max_with_first, max_with_last, full_sum;
  ABCD(int A, int B, int C, int D):
  max_contig_sum(A), max_with_first(B), max_with_last(C), full_sum(D) {}
};

template<typename RAIter>
ABCD recurseCallContigSum(RAIter first, RAIter last);

template<typename RAIter>
int contigSum(RAIter first, RAIter last);




template<typename RAIter>
int contigSum(RAIter first, RAIter last){
  int max_contig_sum;
  if (last == first){return 0;}
  if (last-first == 1){return *first;}
  ABCD first_half = recurseCallContigSum(first, max(first + (last-first)/2, last-1));
  ABCD second_half = recurseCallContigSum(max(last, first + (last-first)/2+1), last);
  max_contig_sum = max(first_half.max_contig_sum,
                       max(second_half.max_contig_sum,
                           first_half.max_with_last+second_half.max_with_first));

  return max_contig_sum;
}

template<typename RAIter>
ABCD recurseCallContigSum(RAIter first, RAIter last){
  int max_contig_sum, max_with_first, max_with_last, full_sum;
  if (first == last){return ABCD(*first, *first, *first, *first);}
  if (last - first == 1){return ABCD(max(*first, max(*first+*last, *last)),
                                     max(*first, *first+*last),
                                     max(*last, *first+*last),
                                     *first+*last);}

  ABCD first_half = recurseCallContigSum(first, max(first + (last-first)/2, last-1));
  ABCD second_half = recurseCallContigSum(max(last, first + (last-first)/2+1), last);

  max_with_last = max(second_half.max_with_last, first_half.max_with_last + second_half.full_sum);
  max_with_first = max(first_half.max_with_first, first_half.full_sum + second_half.max_with_first);
  max_contig_sum = max(first_half.max_contig_sum,
                       max(second_half.max_contig_sum,
                           first_half.max_with_last+second_half.max_with_first));
  full_sum = first_half.full_sum + second_half.full_sum;


  return ABCD(max_contig_sum, max_with_first, max_with_last, full_sum);}
#endif
