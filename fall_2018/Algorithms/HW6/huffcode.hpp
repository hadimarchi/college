// huffcode.hpp
// Glenn G. Chappell
// 29 Nov 2015
//
// For CS 411/611 Fall 2015
// Assignment 6, Exercise A
// Header for class HuffCode
//
// Modified 11/22/17
// Chris Hartman
// For CS 411 Fall 2017

#ifndef FILE_HUFFCODE_H_INCLUDED
#define FILE_HUFFCODE_H_INCLUDED

#include <memory>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

struct node{
  char key = '*';
  int weight = 0;
  std::shared_ptr<node> left=NULL;
  std::shared_ptr<node> right=NULL;
  node(){};
  node(std::pair<char, int> char_weight):key(char_weight.first), weight(char_weight.second){};
  void set_key_weight(char k, int w){
    key = k;
    weight = w;
  }
};

using node_ptr = std::shared_ptr<node>;
class HuffCode {

public:
  HuffCode() = default;
  ~HuffCode() = default;

  HuffCode(HuffCode &) = default;
  HuffCode & operator=(const HuffCode &) = default;
public:
  void setWeights(const std::unordered_map<char, int> & theweights);
  std::string encode(const std::string & text) const;
  std::string decode(const std::string & codestr) const;


private:
  void initNodeHeap(const std::unordered_map<char, int> &);
  void generateTree();
  void generateCode();

private:
  node_ptr get_and_pop_node();
  void create_and_insert_internal_node(node_ptr left, node_ptr right);
  void traverse_left(node_ptr node, std::string code);
  void traverse_right(node_ptr node, std::string code);
  void traverse(node_ptr node, std::string code);


private:
  std::vector<node_ptr> node_heap;
  std::unordered_map<char, std::string> huff_code;
  std::unordered_map<std::string, char> reverse_code;
  };


#endif
