#!/usr/bin/env bash

docker run \
    --mount type=bind,src=`pwd -P`/INPUTS,dst=/INPUTS \
	--mount type=bind,src=`pwd -P`/OUTPUTS,dst=/OUTPUTS \
	--mount type=bind,src=`pwd -P`/..,dst=/wkdir \
    psychopy-iis:test \
	/wkdir/fmri-ert-rift/src/convert-psydat.py \
	--psydat_file /INPUTS/ert1.psydat \
	--out_file /OUTPUTS/ert1.csv
