#!/bin/bash

echo "Num of Params: $#"
echo "Input Params: $@"

echo "First Param: $1"

if [ "$1" == "--test" ]; then
   echo "The first param is a test" ;
else
   echo "The first param is NOT a test" ;
fi


