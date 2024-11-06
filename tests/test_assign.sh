#!/bin/bash

function set_up() {
  ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
  EX="$ROOT_DIR/pcl"
  TEST="$ROOT_DIR/tests"
}

function test_assign01() {
  assert_same "5" "$($EX $TEST/assign01.pcl)"
}

function test_assign02() {
  assert_same "14" "$($EX $TEST/assign02.pcl)"
}

function test_assign03() {
  assert_same "74" "$($EX $TEST/assign03.pcl)"
}

function test_assign04() {
  assert_same "3030" "$($EX $TEST/assign04.pcl)"
}

function test_assign05() {
  assert_same "6" "$($EX $TEST/assign05.pcl)"
}

function test_assign06() {
  assert_same "6" "$($EX $TEST/assign06.pcl)"
}

function test_assign07() {
  assert_same "342" "$($EX $TEST/assign07.pcl)"
}

function test_assign08() {
  assert_same "1012" "$($EX $TEST/assign08.pcl)"
}

function test_assign09() {
  assert_same "106" "$($EX $TEST/assign09.pcl)"
}

function test_assign10() {
  assert_same "1" "$($EX $TEST/assign10.pcl)"
}

function test_assign11() {
  assert_same "0" "$($EX $TEST/assign11.pcl)"
}

function test_assign12() {
  assert_same "2" "$($EX $TEST/assign12.pcl)"
}

function test_assign13() {
  assert_same "0" "$($EX $TEST/assign13.pcl)"
}

function test_assign14() {
  assert_same "3" "$($EX $TEST/assign14.pcl)"
}

function test_assign15() {
  assert_same "-2" "$($EX $TEST/assign15.pcl)"
}
