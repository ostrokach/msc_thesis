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


copy_datapkg_figures elaspic_training_set data_statistics \
    training_set_overlap_data_df_core training_set_overlap_data_df_interface

copy_datapkg_figures elaspic_training_set machine_learning \
    gridsearch_core gridsearch_interface \
    feature_elimination_core feature_elimination_interface

copy_datapkg_figures elaspic_training_set validation \
    crossvalidation_performance_core crossvalidation_performance_interface \
    validation_performance_core validation_performance_interface \
    test_performance_core test_performance_interface
