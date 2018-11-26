#ifndef BUILD_HPP
#define BUILD_HPP

#include <vector>
#include <iostream>

using bridge_set = std::vector<std::vector<int>>;
using city_matrix = std::vector<std::vector<int>>;
using connection_matrix = std::vector<std::vector<int>>;

struct Bridge{
  int w, e, toll;
  Bridge(int w, int e, int toll) : w(w), e(e), toll(toll) {}
  void print(){ std::cout<<w<<" "<<e<<" "<<toll<<std::endl;}
};

using bridges = std::vector<Bridge>;
using const_bridges = std::vector<const Bridge>;

int build(int w, int e, const bridge_set & bridge_set);

#endif
