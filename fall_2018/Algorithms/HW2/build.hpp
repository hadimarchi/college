#ifndef BUILD_HPP
#define BUILD_HPP
#include <vector>
#include <iostream>

using bridge = std::vector<int>;
using bridges = std::vector<bridge>;
using bridge_set = std::vector<std::vector<int>>;

int build(int w, int e, const bridges & bridge_set);

template <typename T>
void print_vector(std::vector<T> const& vec_to_print){
  for (auto i=vec_to_print.begin(); i != vec_to_print.end(); ++i){
    std::cout<<*i;
    std::cout<<" ";
  }
  std::cout<<std::endl;
}
#endif
