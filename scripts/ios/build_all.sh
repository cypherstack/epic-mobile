#!/bin/bash

if rustup toolchain list | grep -q "1.81"; then
  rustup default 1.81
else
  echo "Rust version 1.81 is not installed. Please install it using 'rustup install 1.81'." >&2
  exit 1
fi

(cd ../../crypto_plugins/flutter_libepiccash/scripts/ios && ./build_all.sh )  &

wait
echo "Done building"
