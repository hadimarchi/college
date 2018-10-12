#ifndef INVERSIONS_HPP
#define INVERSIONS_HPP

#include <algorithm>
using std::copy;
using std::max;
#include <cstddef>
using std::size_t;
#include <iterator>
using std::distance;
using std::advance;
#include <type_traits>
using std::remove_reference;
#include <vector>
using std::vector;


template <typename RAIter>
void stableMerge(RAIter first, RAIter middle, RAIter last, size_t & inversion_count)
{
    using Value = typename remove_reference<decltype(*first)>::type;
    vector<Value> buffer(distance(first, last));
                                // Buffer for temporary copy of data
    RAIter in1 = first;         // Read location in 1st half
    RAIter in2 = middle;        // Read location in 2nd half
    auto out = buffer.begin();  // Write location in buffer
    while (in1 != middle && in2 != last)
    {
        if (*in2 < *in1){
          inversion_count +=(middle-in1);
          *out++ = *in2++;
          }
        else
          *out++ = *in1++;
    }

    copy(in1, middle, out);
    copy(in2, last, out);

    copy(buffer.begin(), buffer.end(), first);
}

template <typename RAIter>
void mergeSort(RAIter first, RAIter last, size_t & inversion_count)
{
    size_t size = distance(first, last);

    if (size <= 1)
        return;

    RAIter middle = first;
    advance(middle, size/2);

    mergeSort(first, middle, inversion_count);
    mergeSort(middle, last, inversion_count);

    stableMerge(first, middle, last, inversion_count);
}

template<typename RAIter>
size_t inversions(RAIter first, RAIter last){
  size_t inversion_count = 0;
  mergeSort(first, last, inversion_count);
  return inversion_count;
}

#endif
