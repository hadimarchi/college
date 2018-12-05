// huffcode.cpp  UNFINISHED
// Glenn G. Chappell
// 29 Nov 2015
//
// For CS 411/611 Fall 2015
// Assignment 6, Exercise A
// Source for class HuffCode
//
// Modified 11/22/17
// Chris Hartman
// For CS 411 Fall 2017

#include "huffcode.hpp"
#include <algorithm>
using std::sort;
#include <iostream>
using std::cout;
using std::endl;
#include <memory>
using std::make_shared;
#include <string>
using std::string;
#include <unordered_map>
using std::unordered_map;
#include <utility>
using std::pair;
#include <vector>
using std::vector;


bool pair_second_comp(const node_ptr one, const node_ptr two){
  return one->weight > two->weight;
}

void HuffCode::initNodeHeap(const unordered_map<char, int> & weights){
  vector<node> nodes(weights.begin(), weights.end());
  for (auto i = 0; i<nodes.size(); ++i){
    node_heap.push_back(make_shared<node>(nodes[i]));
  }
}

node_ptr HuffCode::get_and_pop_node(){
  auto node = node_heap.back();
  node_heap.pop_back();
  return node;
}

void HuffCode::create_and_insert_internal_node(node_ptr left, node_ptr right){
  auto internal_node = make_shared<node>();
  internal_node->left = left;
  internal_node->right = right;
  internal_node->weight = left->weight + right->weight;
  node_heap.push_back(internal_node);
}

void HuffCode::generateTree(){
  sort(node_heap.begin(), node_heap.end(), pair_second_comp);
  while(node_heap.size()>1){
    auto first_node = get_and_pop_node();
    auto second_node = get_and_pop_node();
    create_and_insert_internal_node(first_node, second_node);
    sort(node_heap.begin(), node_heap.end(), pair_second_comp);
  }
}

void HuffCode::traverse_left(node_ptr node, string code){
  code.push_back('0');
  traverse(node, code);
}

void HuffCode::traverse_right(node_ptr node, string code){
  code.push_back('1');
  traverse(node, code);
}

void HuffCode::traverse(node_ptr node, string code){
  if (node->key != '*'){
    if (code == ""){code="0";}
    huff_code[node->key] = code;
    reverse_code[code] = node->key;
  }
  if (node->left!=NULL){traverse_left(node->left, code);}
  if (node->right!=NULL){traverse_right(node->right, code);}
}
void HuffCode::generateCode(){
    string code = "";
    traverse(node_heap.front(), code);
}

void HuffCode::setWeights(const unordered_map<char, int> & weights){
    initNodeHeap(weights);
    if (node_heap.size()){
      generateTree();
      generateCode();
  }
}


string HuffCode::encode(const string & text) const
{
    string encoded;
    string code;
    for(const char c:text){
      code = huff_code.find(c)->second;
      encoded.append(code);
    }
    return encoded;
}


string HuffCode::decode(const string & codestr) const
{
    string decoded;
    string partial_code;
    auto code = reverse_code.end();

    for (const char c:codestr){
      partial_code.push_back(c);
      code = reverse_code.find(partial_code);
      if (code != reverse_code.end()){
        decoded.push_back(code->second);
        partial_code.clear();
      }
    }
    return decoded;
}
