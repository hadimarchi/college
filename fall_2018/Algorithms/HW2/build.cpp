#include "build.hpp"
#include <iostream>
using std::cout;
using std::endl;
#include <algorithm>
using std::max;

bridge_set generate_bridges(int n){
  if (n==0){ return {{}};}
  auto subsets = generate_bridges(n-1);
  auto possible_bridge_sets = subsets;
  for(auto v:subsets){
    v.push_back(n-1);
  possible_bridge_sets.push_back(v);
  }
  return possible_bridge_sets;
}

bool bridges_cross(const bridge & first_bridge, const bridge & second_bridge){
  if (first_bridge[0] < second_bridge[0]){
    if (first_bridge[1] > second_bridge[1]){
      return true;
    }
  }
  return false;
}

bool bridges_share_city(const bridge & first_bridge, const bridge & second_bridge){
  if (first_bridge[0] == second_bridge[0]){
    return true;
  }
  else if (first_bridge[1] == second_bridge[1]){
    return true;
  }
  return false;
}
int build(int w, int e, const bridges & bridges){
  auto possible_bridge_sets = generate_bridges(bridges.size());
  auto toll = 0;
  auto max_toll = 0;
  for (auto set:possible_bridge_sets){
    for (auto i=0; i<set.size(); ++i){
      for (auto j=0; j<set.size(); ++j){
        if (i!=j){
          if (bridges_cross(bridges[set[i]], bridges[set[j]])){
              toll = -1;
              break;}
          if(bridges_share_city(bridges[set[i]], bridges[set[j]])){
            toll = -1;
            break;}
          }
        }
      if (toll==-1){break;}
      toll+=bridges[set[i]][2];
      }
    max_toll = max(max_toll, toll);
    toll = 0;
    }
  return max_toll;
}
