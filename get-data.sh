#!/usr/bin/env bash

set -euf -o pipefail

HERE="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"
echo ${HERE}
mkdir -p ${HERE}/data

# curl -L https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.fa.gz -o ${HERE}/data/hg19.fa.gz
curl -L https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz -o ${HERE}/data/hg38.fa.gz

ls -l ${HERE}/data/
