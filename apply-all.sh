#!/bin/bash
for yaml in `find . -maxdepth 2 -name '*.yaml'`
do kubectl apply -f $yaml
done
