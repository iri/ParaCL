#!/bin/bash

function set_up() {
  ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
  EX="$ROOT_DIR/pcl"
  TEST="$ROOT_DIR/tests"
}

function test_if_then01() {
  assert_same "4" "$($EX $TEST/if_then01.pcl)"
}

function test_if_then02() {
  assert_same "120" "$($EX $TEST/if_then02.pcl)"
}

