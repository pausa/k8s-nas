#!/bin/bash
for yaml in `find . -maxdepth 2 -name '*.yaml'`
do microk8s.kubectl apply -f $yaml
done
