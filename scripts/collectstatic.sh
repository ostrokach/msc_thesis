#!/bin/bash

set -ev

DATAPKG_DIR="$HOME/datapkg"

while true; do
    read -p "Remove the './static' folder? " yn
    case $yn in
        [Yy]* ) rm -r ./static; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done


copy_datapkg_figures () {
    mkdir -p "static/$1/$2"
    for filename in ${@:3} ; do
        cp "$DATAPKG_DIR/$1/notebooks/$2/$filename."{png,pdf} "static/$1/$2/"
    done
}


rsync -av --include '*/' --include '*.pdf' --exclude '*' ./figures/ ./static/


copy_datapkg_figures elaspic_training_set core_data_statistics \
    training_set_overlap_final initial_performance

copy_datapkg_figures elaspic_training_set core_machine_learning \
    gridsearch feature_elimination final_performance


copy_datapkg_figures elaspic_training_set interface_data_statistics \
    training_set_overlap_final initial_performance

copy_datapkg_figures elaspic_training_set interface_machine_learning \
    gridsearch feature_elimination final_performance
