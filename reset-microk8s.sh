#!/bin/bash
## this script resets microk8s, to quickly recover from
#  problems

function as_root {
  # installing
  snap remove microk8s
  snap install microk8s --classic

  # enabling plugins
  microk8s.enable storage dns registry

  # putting custom conf in apiserver
  echo '# Custom Configuration' >> /var/snap/microk8s/current/args/kube-apiserver
  echo '--service-node-port-range=100-60000' >> /var/snap/microk8s/current/args/kube-apiserver
  systemctl restart snap.microk8s.daemon-apiserver
}

sudo as_root
./apply-all.sh
