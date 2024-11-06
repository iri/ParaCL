#!/bin/bash

function set_up() {
  ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
  EX="$ROOT_DIR/pcl"
  TEST="$ROOT_DIR/tests"
}

function test_while01() {
  assert_same "15" "$($EX $TEST/while01.pcl)"
}

