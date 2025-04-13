#!/bin/bash


FILES="hello how are you doing"
echo "$FILES" 

FILES=${FILES/how}
echo $FILES
