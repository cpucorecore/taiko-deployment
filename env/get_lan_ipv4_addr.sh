#!/bin/bash

uname=`uname`

function get_ipv4_addr_mac() {
  ifconfig en0 | grep "inet " | awk '{print $2}'
}

function get_ipv4_addr_linux() {
  ip route get 1.2.3.4 | grep via | awk '{print $7}'
}

if [ ${uname} = "Darwin" ]; then
  get_ipv4_addr_mac
elif [ ${uname} = "Linux" ]; then
  get_ipv4_addr_linux
fi