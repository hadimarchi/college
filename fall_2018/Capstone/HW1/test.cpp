#include "catch.hpp"
#include "algorithm.hpp"
using srt::quicksort;
using srt::swap_at_vec_ptr;
using srt::vec_ptr;
using srt::un_int;

#include <vector>
using std::vector;
#include <memory>
using std::make_unique;
#include <algorithm>
using std::is_sorted;

void test_trivial_lists(){
  vector<int> empty = {};
  vector<int> singleton = {1};
}
