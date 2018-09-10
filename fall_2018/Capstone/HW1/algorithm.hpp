#ifndef ALGORITHM_HPP
#define ALGORITHM_HPP
#include <iostream>
// std::cout;
// std::endl;
#include <vector>
// std::vector
#include <memory>
// std::unique_ptr
// std::make_unique;
#include <utility>
//std::utility;

namespace srt{
  using un_int = unsigned int;

  template <typename T>
  void print_vector(std::vector<T> const& vec_to_print);

  template <typename T>
  void quicksort(std::vector<T> &target_vec, un_int lower_index, un_int upper_index);

  template <typename T>
  un_int partition(std::vector<T> &target_vec, un_int lower_index, un_int upper_index);

  template <typename T>
  void do_quicksort(std::vector<T> &vec_to_sort);
}

template <typename T>
void srt::print_vector(std::vector<T> const& vec_to_print){
  for (auto i=vec_to_print.begin(); i != vec_to_print.end(); ++i){
    std::cout<<*i;
    std::cout<<" ";
  }
  std::cout<<std::endl;
}

template <typename T>
void srt::quicksort(std::vector<T> &target_vec, un_int lower_index, un_int upper_index){
  if (lower_index < upper_index){
    auto split_index = partition(target_vec, lower_index, upper_index);
    quicksort(target_vec, lower_index, std::max(split_index, un_int(1))-1);
    quicksort(target_vec, split_index+1, upper_index);
  }
}

template <typename T>
srt::un_int srt::partition(std::vector<T> &target_vec, un_int lower_index, un_int upper_index){
  auto pivot = target_vec[upper_index];
  auto split_index = lower_index - 1;
  for (auto i = lower_index; i<upper_index; i++){
    if (target_vec[i] < pivot){
      split_index+=1;
      std::swap(target_vec[split_index], target_vec[i]);
      }
  }
  split_index = split_index + 1;
  if (target_vec[upper_index] < target_vec[split_index]){
    std::swap(target_vec[split_index], target_vec[upper_index]);}

  return split_index;
}



template <typename T>
void srt::do_quicksort(std::vector<T> &vec_to_sort){
  srt::quicksort(vec_to_sort, un_int(0), std::max(un_int(vec_to_sort.size()), un_int(1))-1);

}
#endif
