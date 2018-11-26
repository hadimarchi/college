#include "build.hpp"
#include <iostream>
using std::cout;
using std::endl;
#include <algorithm>
using std::max;
using std::sort;
#include <vector>
using std::vector;
const int NULL_BRIDGE = -1;

bridges bridge_vecs_to_structs(const bridge_set & bridges_vec){
  bridges bridge_structs = {};
  for (auto bridge:bridges_vec){
    Bridge struct_bridge = Bridge(bridge[0], bridge[1], bridge[2]);
    bridge_structs.push_back(struct_bridge);
  }
  return bridge_structs;
}

bool compare_bridges(const Bridge & first_bridge, const Bridge & second_bridge){
  return first_bridge.w == second_bridge.w ?
          first_bridge.e<second_bridge.e : first_bridge.w<second_bridge.w;
}

int max_toll(int w, int e, city_matrix & cities, connection_matrix & connections){
  if (cities[w][e] != NULL_BRIDGE) return cities[w][e];

  int result;
  auto current_toll = connections[w][e];

  switch (w){
    case 0:
      switch(e){
        case 0:
          result = current_toll;
          break;
        default:
          result = max(current_toll, max_toll(w, e-1, cities, connections));
          break;
        }
      break;
    default:
      switch(e){
        case 0:
          result = max(current_toll, max_toll(w-1, e, cities, connections));
          break;
        default:
          result = max({current_toll + max_toll(w-1, e-1, cities, connections),
                       max_toll(w-1, e, cities, connections),
                       max_toll(w, e-1, cities, connections)});
          break;
        }
    }
  cities[w][e] = result;
  return result;
}


int build(int w, int e, const bridge_set & possible_bridges){
  auto bridge_structs = bridge_vecs_to_structs(possible_bridges);
  
  city_matrix cities (w, vector<int>(e, NULL_BRIDGE));
  connection_matrix connections (w, vector<int>(e, 0));
  for (const auto &bridge:bridge_structs){
    connections[bridge.w][bridge.e] = max(
      connections[bridge.w][bridge.e],
      bridge.toll);
  }

  return max_toll(w-1, e-1, cities, connections);
}
