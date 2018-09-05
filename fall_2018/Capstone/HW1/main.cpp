#include "algorithm.hpp"
using srt::do_quicksort;
using un_int = srt::un_int;
#include <vector>
using std::vector;
#include <iostream>
using std::cout;
using std::endl;

int main(){
  vector<int> to_sort = {11, 4, 18, 5, 2};
  srt::do_quicksort(to_sort);
  vector<int> empty_arr = {};
  srt::do_quicksort(empty_arr);
  vector<int> singleton = {1};
  srt::do_quicksort(singleton);

  vector<int> right_min = {13, 25, 5,1};
  srt::do_quicksort(right_min);

  vector<int> pair = {2, 1};
  srt::do_quicksort(pair);
  vector<int> odd = {1,3,2};
  srt::do_quicksort(odd);

  vector<int> big = {22, 14, 3, 18, 4, 57, 13, 102, 0, 44};
  srt::do_quicksort(big);

  vector<int> left_max = {100, 2, 1, 5};
  srt::do_quicksort(left_max);
  return 0;
}
