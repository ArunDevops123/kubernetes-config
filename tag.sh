#!/bin/sh

####################################
######### Changing root user #######

if [ "$(whoami)" != "root" ]
then
    sudo su -s "$0"
    exit
fi

#############################################
########### Condition Checking ##############
node_count=$(cat count.txt | awk '{ print $3 }')
a=0
b=1
until [ $a -ge $node_count ] && [ $b -eq 0 ]
do
    echo $a

b=$(kubectl get no | awk '{ print $2 }' | grep "NotReady" | wc -l)
    sleep 1

count=$(kubectl get no | wc -l)
a="$((count - 1))"
echo "$a"

done

echo "Passed"

####################################################
################## Tag Attachment ##################

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
            kubectl label node $name group5=$val --overwrite
            i=$(($i+1))
        done
    else
        echo "Value is Not match"
    fi

done
