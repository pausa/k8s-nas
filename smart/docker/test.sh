#!/bin/bash
for dev in `ls -d1 /scanning/*`
do
	echo "Starting long tests on `basename $dev`"
	smartctl --test=long -d sat $dev
	echo "Done"
done
