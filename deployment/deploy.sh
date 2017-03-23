#!/bin/bash

# fail fast if we aren't on the desired branch or if this is a pull request
if  [[ "${TRAVIS_BRANCH}" != "$(cat VERSION)" && ("${TRAVIS_PULL_REQUEST}" != "false" || "${TRAVIS_BRANCH}" != "master") ]]; then
    echo "We only publish on successful builds of master."
    exit 0
fi
