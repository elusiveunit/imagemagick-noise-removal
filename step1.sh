#!/usr/bin/env bash

base_name=${1:-"img"}
extension=${2:-"jpg"}

if [[ $base_name =~ (.+)\.([a-z]+)$ ]]; then
  base_name="${BASH_REMATCH[1]}"
  extension="${BASH_REMATCH[2]}"
fi

cmd="convert '${base_name}.${extension}' -fft +delete -auto-level -evaluate log 100000 '${base_name}_spectrum.png'"
echo "Running step 1: ${cmd}"
eval $cmd
echo "Done! Now create a black and white mask from '${base_name}_spectrum.png' and save it as '${base_name}_spectrum_mask.png', then run step 2."