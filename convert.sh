#!/bin/bash -xe

# get the files present at the target revision
TARGET_REV=tip
SOURCE_REPO=~/workspace/invest-natcap.invest-3
pushd $SOURCE_REPO
hg up -C $TARGET_REV
hg purge --all invest_natcap

popd

# create the natcap.invest folder
NEWREPO=natcap.invest
rm -rf $NEWREPO

mkdir $NEWREPO
pushd $NEWREPO
mkdir natcap
cp -r $SOURCE_REPO/invest_natcap natcap/invest
pwd

# exclude certain subdirs
INVEST_DIR=natcap/invest
rm -r $INVEST_DIR/iui/jsonschema
rm -r $INVEST_DIR/iui
rm -r $INVEST_DIR/dbfpy
rm -r $INVEST_DIR/ntfp
rm $INVEST_DIR/postprocessing.py
rm $INVEST_DIR/pytable_tracer_cython.pyx
rm $INVEST_DIR/build_utils.py

# TODO use sed to replace invest_natcap.dbfpy with dbfpy

popd

cp requirements.txt $NEWREPO
cp tox.ini $NEWREPO
cp namespace_init.py $NEWREPO/natcap/__init__.py
wget https://bitbucket.org/richpsharp/pygeoprocessing/raw/tip/versioning.py $NEWREPO/versioning.py

#pushd $NEWREPO
#hg init
#hg flow init
