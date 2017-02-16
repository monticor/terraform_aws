#!/usr/bin/env bash
hostname $1
cp /etc/hosts /etc/hosts.bak
echo "127.0.0.1 $1" >> /etc/hosts
echo "$1" > /etc/hostname


