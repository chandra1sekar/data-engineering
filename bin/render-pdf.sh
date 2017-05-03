#!/bin/bash

set -o errexit -o nounset -o pipefail

usage() {
	echo "Usage: $0 <input> <output>
    takes html to pdf"
}
(( $# != 2 )) && usage && exit 1
section=$1

timestamp=`date +%Y-%m-%d-%H%M`

render_pdf() {
  local input=$1
  local output=$1
  cd ~/talks/decktape
}

echo "starting run for $output at $timestamp"

render_pdf $from $to

echo "done"

