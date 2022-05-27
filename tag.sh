#!/bin/bash
if [ "$(whoami)" != "root" ]
then
    sudo su -s "$0"
    exit
fi

variable='database microservice mnm npn'

for val in $variable
do
    data_count=$(kubectl get no | awk '{ print $1 }' | grep '.*-'$val'-.*' | wc -l)
    if [ $data_count -ge 1 ]
    then
        i=1
        while [ $i -le $data_count ]
        do
            echo $i
            name=$(kubectl get no | awk '{ print $1 }' | grep $val | awk 'FNR=='$i' {print}')
            echo "$name"
            kubectl label node $name group4=$val --overwrite
            i=$(($i+1))
        done
    else
        echo "Value is Not match"
    fi

done
