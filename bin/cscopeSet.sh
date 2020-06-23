#!/bin/bash
find . -iname "*.cc" -o -iname "*.h" > cscope.files
cscope -b
CSCOPE_DB=cscope.out
export CSCOPE_DB
