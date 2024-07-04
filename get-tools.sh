#!/usr/bin/env bash

set -euf -o pipefail

HERE="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"
echo ${HERE}
mkdir -p ${HERE}/tools

if ! which samtools; then
    echo "building samtools"
    rm -rf ${HERE}/tools/samtools-1.20
    (cd tools/ && curl -L https://github.com/samtools/samtools/releases/download/1.20/samtools-1.20.tar.bz2 | tar -xj)
    pushd ${HERE}/tools/samtools-1.20
    ./configure --prefix=${HERE}/tools
    make
    make install
    popd
fi

if ! which bgzip; then
    echo "building htslib"
    rm -rf ${HERE}/tools/htslib-1.20
    (cd tools/ && curl -L https://github.com/samtools/htslib/releases/download/1.20/htslib-1.20.tar.bz2 | tar -xj)
    pushd ${HERE}/tools/htslib-1.20
    ./configure --prefix=${HERE}/tools
    make
    make install
    popd
fi

if ! which pblat; then
    echo "building pblat"
    rm -rf ${HERE}/tools/pblat
    (cd tools/ && git clone git@github.com:icebert/pblat.git)
    pushd ${HERE}/tools/pblat
    make
    ln -s "$(realpath ./pblat)" ${HERE}/tools/bin/pblat
    popd
fi

for tool in liftUp faSplit axtChain chainMergeSort chainSplit chainNet netChainSubset; do
    echo "getting ${tool}"
    if ! which ${tool}; then
        curl -L https://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/${tool} -o ${HERE}/tools/bin/${tool}
	chmod a+x ${HERE}/tools/bin/${tool}
    fi
done

poetry install
poetry run pyoverchain -h
