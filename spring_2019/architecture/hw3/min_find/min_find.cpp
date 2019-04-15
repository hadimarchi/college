#include "min_find.h"
#include <mpi.h>

#include <algorithm>
using std::distance;
using std::generate;
using std::min_element;
#include <assert.h>
#include <iostream>
using std::cout;
using std::endl;
#include <random>
using std::random_device;
using std::mt19937;
using std::uniform_int_distribution;
#include <vector>
using std::vector;
using std::begin;
using std::end;


vector<int> generate_rand_int_vector(const int vec_size, const int upper_bound){
    random_device rnd_dev;
    mt19937 mersenne_rnd_engine{rnd_dev()};
    uniform_int_distribution<int> range {0, upper_bound};

    auto gen_func = [&range, &mersenne_rnd_engine](){
                        return range(mersenne_rnd_engine);
                      };

    vector<int> rand_vec(vec_size);
    generate(begin(rand_vec), end(rand_vec), gen_func);

    return rand_vec;
}

int get_begin_from_rank(const int rank, const int vec_size, const int process_size){
  return (rank*vec_size)/process_size;
}

int get_end_from_rank(const int rank, const int vec_size, const int process_size){
  return ((rank+1)*vec_size)/process_size;
}
int mpi_min_find(int argc, char* argv[]){
  int rank, process_size;
  int rank_vec_range_begin, rank_vec_range_end;
  int mpi_global_min, sequential_global_min=99999, local_min = 99999;
  const int vec_size = 8000000;
  const int vec_value_upper_bound = 99999;
  vector<int> rand_int_vector(vec_size);

  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &process_size);
  if (rank == 0){
    rand_int_vector = generate_rand_int_vector(
                              vec_size,
                              vec_value_upper_bound);
    sequential_global_min = *(min_element(begin(rand_int_vector), end(rand_int_vector)));
  }
  MPI_Bcast(&(rand_int_vector[0]), vec_size, MPI_INT, 0, MPI_COMM_WORLD);

  rank_vec_range_begin = get_begin_from_rank(rank, vec_size, process_size);
  rank_vec_range_end = get_end_from_rank(rank, vec_size, process_size);
  local_min = *(min_element(
                            &(rand_int_vector[rank_vec_range_begin]),
                            &(rand_int_vector[rank_vec_range_end])
                           ));
                           
  MPI_Reduce(&local_min, &mpi_global_min, 1, MPI_INT, MPI_MIN, 0, MPI_COMM_WORLD);

  if (rank == 0){
    cout<<"Mpi method produced a global min of "<<mpi_global_min<<endl;
    cout<<"Sequential search method produced a global min of "<<sequential_global_min<<endl;

    assert(mpi_global_min == sequential_global_min);

  }
  MPI_Finalize();
  return 0;
}


int main(int argc, char* argv[]){
  return mpi_min_find(argc, argv);
}
