#!/usr/bin/env bash
# Silences pushd and popd

pushd () {
  command pushd "$@" > /dev/null || exit 1
}

popd () {
  command popd "$@" > /dev/null || exit 1
}
