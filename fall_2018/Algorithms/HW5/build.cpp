#include "build.hpp"
#include <algorithm>
using std::max;
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

int max_toll(int w, int e, city_matrix & cities, connection_matrix & connections){
  if (cities[w][e] != NULL_BRIDGE) return cities[w][e];

  auto current_toll = connections[w][e];
  int true_max_toll = current_toll;

  switch (w){
    case 0:
      switch(e){
        case 0:
          break;
        default:
          true_max_toll = max(current_toll,
                              max_toll(w, e-1, cities, connections));
          break;
        }
      break;
    default:
      switch(e){
        case 0:
          true_max_toll = max(current_toll,
                              max_toll(w-1, e, cities, connections));
          break;
        default:
          true_max_toll = max({current_toll + max_toll(w-1, e-1, cities, connections),
                               max_toll(w-1, e, cities, connections),
                               max_toll(w, e-1, cities, connections)});
          break;
        }
    }
  cities[w][e] = true_max_toll;
  return true_max_toll;
}


int build(int w, int e, const bridge_set & possible_bridges){
  auto bridge_structs = bridge_vecs_to_structs(possible_bridges);

  city_matrix cities (w, vector<int>(e, NULL_BRIDGE));
  connection_matrix connections (w, vector<int>(e, 0));
  for (auto & bridge:bridge_structs){
    connections[bridge.w][bridge.e] = max(connections[bridge.w][bridge.e],
                                          bridge.toll);
  }

  return max_toll(w-1, e-1, cities, connections);
}
