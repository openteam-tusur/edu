#!/bin/bash

FILEDIR=$1

cd ${FILEDIR}
zip -r ../${FILEDIR}.odt .
