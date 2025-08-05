#!/bin/bash

set -e

if rustup toolchain list | grep -q "1.81"; then
  rustup default 1.81
else
  echo "Rust version 1.81 is not installed. Please install it using 'rustup install 1.81'." >&2
  exit 1
fi

mkdir -p build
. ./config.sh
./install_ndk.sh

(cd ../../crypto_plugins/flutter_libepiccash/scripts/android && ./install_ndk.sh && ./build_all.sh )  &

wait
echo "Done building"
