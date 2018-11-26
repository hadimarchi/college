#ifndef BUILD_HPP
#define BUILD_HPP

#include <vector>
#include <iostream>

using bridge_set = std::vector<std::vector<int>>;

struct Bridge{
  int w, e, toll;
  Bridge(int w, int e, int toll) : w(w), e(e), toll(toll) {}
};
using bridges = std::vector<Bridge>;

int build(int w, int e, const bridge_set & bridge_set);

#endif
