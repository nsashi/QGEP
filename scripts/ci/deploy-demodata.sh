#!/bin/bash

# Exit on error
set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../..

if test "$TRAVIS_SECURE_ENV_VARS" = "true" -a "$TRAVIS_BRANCH" = "travis";
then
  echo "updating demodata";

  pushd ${DIR}
  cd data
  git checkout demodata
  pg_dump -n "qgep" -Fc qgep > qgep_demodata.dump
  git add -A
  git commit -m "Automatic update from https://github.com/qgep/QGEP/commit/${TRAVIS_COMMIT}"
  git push
  popd
fi