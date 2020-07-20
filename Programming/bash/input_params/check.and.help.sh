#!/bin/bash

CnH_G_PWD=`pwd`

cnb_f_usage()
{
        echo "usage:"
        echo "    $0 <PARAM_A> <PARAM_B>"
        echo ""
        echo "The $0 commands are:"
        echo "    PARAM_A - First  Param"
        echo "    PARAM_B - Second Param"
}


if [ "$#" -ne 2 ]; then
    cnb_f_usage
    exit 1
fi

PA=$1
PB=$2

echo "First: ${PA}, Second: ${PB}"

