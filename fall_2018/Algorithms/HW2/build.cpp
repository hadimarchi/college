#include "build.hpp"
#include <iostream>
using std::cout;
using std::endl;
#include <algorithm>
using std::max;

bridges bridge_vecs_to_structs(const bridge_set & bridges_vec){
  bridges bridge_structs = {};
  for (auto bridge:bridges_vec){
    Bridge struct_bridge = Bridge(bridge[0], bridge[1], bridge[2]);
    bridge_structs.push_back(struct_bridge);
  }
  return bridge_structs;
}

bool bridges_interfere(const Bridge & first_bridge, const Bridge & second_bridge){
  return !((first_bridge.e < second_bridge.e && first_bridge.w < second_bridge.w) ||
           (first_bridge.e > second_bridge.e && first_bridge.w > second_bridge.w));
}

bridge_set generate_bridge_sets(int n, const bridges & possible_bridges){
  bridge_set possible_bridge_sets = {{}};
  if (n==0){ return possible_bridge_sets;}
  auto subsets = generate_bridge_sets(n-1, possible_bridges);
  possible_bridge_sets = subsets;
  bool bad_bridge=false;
  unsigned int last_index;
  for(auto v:subsets){
    v.push_back(n-1);
    if(v.size() >= 2){
      last_index = v.size()-1;
      for (auto i=0; i<v.size();++i){
        if (i!=last_index){
          if (bridges_interfere(possible_bridges[v[i]],
                                possible_bridges[v[last_index]])){
              bad_bridge=true;break;}
        }
      }
    }
    if (!bad_bridge) possible_bridge_sets.push_back(v);
    bad_bridge=false;
  }
  return possible_bridge_sets;
}

int build(int w, int e, const bridge_set & possible_bridges){
  auto bridge_structs = bridge_vecs_to_structs(possible_bridges);
  auto possible_bridge_sets = generate_bridge_sets(possible_bridges.size(), bridge_structs);
  auto toll = 0;
  auto max_toll = 0;
  for (const auto & set:possible_bridge_sets){
    for (auto i=0; i<set.size(); ++i){
      toll+=(bridge_structs[set[i]]).toll;
      }
    max_toll = max(max_toll, toll);
    toll = 0;
    }
  return max_toll;
}
