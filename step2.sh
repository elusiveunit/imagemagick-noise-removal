#!/usr/bin/env bash

base_name=${1:-"img"}
extension=${2:-"jpg"}

if [[ $base_name =~ (.+)\.([a-z]+)$ ]]; then
  base_name="${BASH_REMATCH[1]}"
  extension="${BASH_REMATCH[2]}"
fi

cmd="convert '${base_name}.${extension}' -fft \( -clone 0 '${base_name}_spectrum_mask.png' -compose multiply -composite \) -swap 0 +delete -ift '${base_name}_filtered.png'"
echo "Running step 2: ${cmd}"
eval $cmd
echo "Done! The result is saved as '${base_name}_filtered.png'"
