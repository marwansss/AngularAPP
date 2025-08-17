#!/bin/bash
EXPECTED="hello, test!"
OUTPUT=$(node -e "console.log(require('./app')('test'))")

if [ "$OUTPUT" == "$EXPECTED" ]; then
  echo "test passed"
  exit 0
else
  echo "test failed"
  exit 1
fi