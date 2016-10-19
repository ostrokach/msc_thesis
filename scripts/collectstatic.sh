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


rsync -av --include '*/' --include '*.pdf' --include '*.png' --exclude '*' ./figures/ ./static/


copy_datapkg_figures elaspic_training_set data_statistics \
    training_set_overlap_data_df_tt_core training_set_overlap_data_df_tt_interface

copy_datapkg_figures elaspic_training_set machine_learning \
    gridsearch_core gridsearch_interface \
    feature_elimination_core feature_elimination_interface

copy_datapkg_figures elaspic_training_set validation \
    crossvalidation_performance_core crossvalidation_performance_interface \
    validation_performance_core validation_performance_interface \
    test_performance_core test_performance_interface

copy_datapkg_figures elaspic_training_set validation_cancer \
    roc_curve_full roc_curve_bygene_full \
    roc_curve_high_confidence roc_curve_bygene_high_confidence \
    score_distribution_full score_distribution_high_confidence

copy_datapkg_figures elaspic_training_set elaspic_statistics \
    protein_statistics \
    domain_statistics \
    missing_template \
    missing_provean \
    missing_model_protein \
    missing_model_domain \
    structural_coverage_hist \
    missing_model_protein_pair_novarsplice
