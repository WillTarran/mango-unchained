#!/usr/bin/env bash

set -euf -o pipefail

HERE="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"
echo ${HERE}
mkdir -p ${HERE}/data

for chr in {1..22} X Y; do printf "chr%s\tchr%s\n" $chr $chr; done > ${HERE}/data/chr_map.tsv

for build in hg19 hg38; do
    if [[ ! -f ${HERE}/data/${build}.fa.gz ]]; then
        echo "getting ${build} reference"
        curl -L https://hgdownload.soe.ucsc.edu/goldenPath/${build}/bigZips/${build}.fa.gz \
		| gzip -d \
		| bgzip \
		> ${HERE}/data/${build}.fa.gz
    fi
    if [[ ! -f ${HERE}/data/${build}.fa.gz.fai ]]; then
        echo "indexing ${build} reference"
        samtools faidx ${HERE}/data/${build}.fa.gz
    fi
done

ls -l ${HERE}/data/
