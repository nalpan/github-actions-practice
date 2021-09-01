#!/bin/sh -l

echo "Hello $1"
date --set "2021-07-01"
time=$(date)
echo "::set-output name=time::$time"
