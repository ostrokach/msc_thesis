#!/bin/bash

set -ev

DATAPKG_DIR="$HOME/datapkg"

copy_datapkg_figures () {
    mkdir -p "figures/$1/$2"
    for filename in ${@:3} ; do
        cp "$DATAPKG_DIR/$1/notebooks/$2/$filename."{png,pdf} "figures/$1/$2/"
    done
}


while true; do
    read -p "Remove the './figures' folder? " yn
    case $yn in
        [Yy]* ) rm -r ./figures; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


copy_datapkg_figures elaspic_training_set core_data_statistics \
    training_set_overlap_final foldx_correlation_final provean_correlation_final
