#!/bin/bash
FILES=test/cda/*
for f in $FILES
do
        echo "-----------------------------------------------------------------------------------------------------"
        echo ${f}
		python3 label_image.py ${f}
        echo "-----------------------------------------------------------------------------------------------------"

done
