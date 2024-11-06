#!/bin/bash

function set_up() {
  ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
  EX="$ROOT_DIR/pcl"
  TEST="$ROOT_DIR/tests"
}

function test_if_fun01() {
  assert_same "-5" "$($EX $TEST/fun01.pcl)"
}

function test_if_fun02() {
  assert_same "-5" "$($EX $TEST/fun02.pcl)"
}

