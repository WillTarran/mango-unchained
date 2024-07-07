#!/usr/bin/env bash

cd data
poetry run pyoverchain \
	-n 4 \
	-p 4 \
	hg19.fa.gz \
	hg38.fa.gz \
	chr_map.tsv

poetry run pyoverchain \
	-n 4 \
	-p 4 \
	hg38.fa.gz \
	hg19.fa.gz \
	chr_map.tsv
