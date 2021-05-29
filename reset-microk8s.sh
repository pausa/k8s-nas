#!/bin/bash
## this script resets microk8s, to quickly recover from
#  problems

function as_root {
  # installing
  snap remove microk8s --purge
  snap install microk8s --classic

  # enabling plugins
  microk8s.enable storage dns registry ingress

  # putting custom conf in apiserver
  echo '# Custom Configuration' >> /var/snap/microk8s/current/args/kube-apiserver
  echo '--service-node-port-range=50-60000' >> /var/snap/microk8s/current/args/kube-apiserver
  echo '--enable-admission-plugins=PodSecurityPolicy' >> /var/snap/microk8s/current/args/kube-apiserver
  echo '--allow-privileged=true' >> /var/snap/microk8s/current/args/kube-apiserver

  microk8s.stop && microk8s.start
}

sudo bash -c "$(declare -f as_root); as_root"
./apply-all.sh
