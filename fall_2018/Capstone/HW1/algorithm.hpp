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

namespace srt{
  using un_int = unsigned int;

  template <typename T>
  using vec_ptr = std::unique_ptr<std::vector<T>>;

  template <typename T>
  void print_vector(std::vector<T> const& vec_to_print);

  template <typename T>
  void swap_at_vec_ptr(vec_ptr<T> & vec, un_int first_index, un_int second_index);

  template <typename T>
  void quicksort(vec_ptr<T> &target_vec, un_int lower_index, un_int upper_index);

  template <typename T>
  un_int partition(vec_ptr<T> &target_vec, un_int lower_index, un_int upper_index);

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
void srt::swap_at_vec_ptr(vec_ptr<T> & vec, un_int first_index, un_int second_index){
  auto temp = (*vec)[first_index];
  (*vec)[first_index] = (*vec)[second_index];
  (*vec)[second_index] = temp;
}

template <typename T>
void srt::quicksort(vec_ptr<T> &target_vec, un_int lower_index, un_int upper_index){
  if (lower_index < upper_index){
    auto split_index = partition(target_vec, lower_index, upper_index);
    quicksort(target_vec, lower_index, std::max(split_index, un_int(1))-1);
    quicksort(target_vec, split_index+1, upper_index);
  }
}

template <typename T>
srt::un_int srt::partition(vec_ptr<T> &target_vec, un_int lower_index, un_int upper_index){
  auto pivot = (*target_vec)[upper_index];
  auto split_index = lower_index - 1;
  for (auto i = lower_index; i<upper_index; i++){
    if ((*target_vec)[i] < pivot){
      split_index+=1;
      swap_at_vec_ptr(target_vec, split_index, i);
      }
  }
  split_index = split_index + 1;//std::min(split_index + 1, upper_index);
  if ((*target_vec)[upper_index] < (*target_vec)[split_index]){
    swap_at_vec_ptr(target_vec, split_index, upper_index);}

  return split_index;
}



template <typename T>
void srt::do_quicksort(std::vector<T> &vec_to_sort){
  vec_ptr<T> vec_ptr = std::make_unique<std::vector<T>>(vec_to_sort);
  srt::quicksort(vec_ptr, un_int(0), std::max(un_int((*vec_ptr).size()), un_int(1))-1);
  print_vector(*vec_ptr);

}
#endif
