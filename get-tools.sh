#!/usr/bin/env bash

set -euf -o pipefail

HERE="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"
echo ${HERE}
mkdir -p ${HERE}/tools

if ! which samtools; then
    rm -rf ${HERE}/tools/samtools-1.20
    (cd tools/ && curl -L https://github.com/samtools/samtools/releases/download/1.20/samtools-1.20.tar.bz2 | tar -x)
    pushd ${HERE}/tools/samtools-1.20
    ./configure --prefix=${HERE}/tools
    make
    make install
    popd
fi

if ! which pblat; then
    rm -rf ${HERE}/tools/pblat
    (cd tools/ && git clone git@github.com:icebert/pblat.git)
    pushd ${HERE}/tools/pblat
    make
    ln -s "$(realpath ./pblat)" ${HERE}/tools/bin/pblat
    popd
fi

