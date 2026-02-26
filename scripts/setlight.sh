#!/bin/sh

if [ $# -eq 0 ]
then
    echo "No argument: brightness from 0% to 100% (ex: setlight 50%)"
    exit 1
fi

brightnessctl set $1
