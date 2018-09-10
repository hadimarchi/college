#define CATCH_CONFIG_MAIN
#include "catch.hpp"
#include "algorithm.hpp"
using srt::quicksort;
using srt::do_quicksort;
using srt::print_vector;
using srt::un_int;

#include <vector>
using std::vector;
#include <memory>
using std::make_unique;
#include <algorithm>
using std::is_sorted;
#include <stdlib.h>
// rand();

vector<int> generate_random_list_of_integers(){
  vector<int> randomly_generated = {};
  for(un_int i=0; i<100; ++i){
    randomly_generated.push_back((rand() % 200));
  }
  return randomly_generated;
}
TEST_CASE("Trivial lists are sorted"){
  vector<int> empty = {};
  vector<int> singleton = {1};
  do_quicksort(empty);
  do_quicksort(singleton);
  REQUIRE(is_sorted(empty.begin(), empty.end()));
  REQUIRE(is_sorted(singleton.begin(), singleton.end()));
}

TEST_CASE("Small lists are sorted"){
  vector<int> pair = {2, 1};
  vector<int> odd = {1,3,2};

  do_quicksort(pair);
  do_quicksort(odd);

  REQUIRE(is_sorted(pair.begin(), pair.end()));
  REQUIRE(is_sorted(odd.begin(), odd.end()));
}

TEST_CASE("Inconvenient lists are sorted"){
  vector<int> right_min = {13, 25, 5,1};
  vector<int> left_max = {100, 2, 1, 5};

  do_quicksort(right_min);
  do_quicksort(left_max);

  REQUIRE(is_sorted(right_min.begin(), right_min.end()));
  REQUIRE(is_sorted(left_max.begin(), left_max.end()));
}

TEST_CASE("Larger lists are sorted"){
  vector<int> big = {22, 14, 3, 18, 4, 57, 13, 102, 0, 44};
  vector<int> bigger = {132, 196, 38, 141, 121, 1, 152, 86, 184, 165, 156, 104,
                        74, 88, 139, 194, 109, 64, 197, 56, 198, 186, 20, 100,
                        171, 150, 142, 143, 31, 162, 80, 55, 126, 24, 23, 2,
                        147, 65, 136, 40, 93, 82, 78, 29, 116, 119, 155, 48,
                        182, 102, 69, 27, 188, 138, 43, 130, 45, 34, 90, 71,
                        122, 30, 115, 7, 163, 108, 96, 129, 81, 25, 173, 178};

  do_quicksort(big);
  do_quicksort(bigger);

  REQUIRE(is_sorted(big.begin(), big.end()));
  REQUIRE(is_sorted(bigger.begin(), bigger.end()));

}

TEST_CASE("Lists with negative integers are sorted"){
  vector<int> negatives = {-5, -11, -1, -2};
  vector<int> mixed = {11, -49, 2, -2};

  do_quicksort(negatives);
  do_quicksort(mixed);

  REQUIRE(is_sorted(negatives.begin(), negatives.end()));
  REQUIRE(is_sorted(mixed.begin(), mixed.end()));
}

TEST_CASE("Character list is sorted"){
  vector<char> string = {'y', 't', 'a', 'f', 'r'};
  do_quicksort(string);
  REQUIRE(is_sorted(string.begin(), string.end()));
}

TEST_CASE("Sorted list is still sorted"){
  vector<int> sorted = {1, 2, 3, 4, 5, 6};
  do_quicksort(sorted);
  REQUIRE(is_sorted(sorted.begin(), sorted.end()));
}
TEST_CASE("Random list is sorted"){
  auto randomly_generated = generate_random_list_of_integers();

  do_quicksort(randomly_generated);
  REQUIRE(is_sorted(randomly_generated.begin(), randomly_generated.end()));

}
