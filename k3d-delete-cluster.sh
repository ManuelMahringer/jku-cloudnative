#!/bin/bash
k3d cluster delete jku-dev

# remove kube conf from OpenLens
rm -f /mnt/c/Users/manue/.kube/config
