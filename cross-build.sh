#!/bin/bash
set -u

if [ ! -z "${BUILD_LOCAL:-}" ]; then
    make $@
else
    vagrant status --machine-readable | grep state,running > /dev/null
    if [ $? -ne 0 ]; then
        vagrant up
    fi

    # workaround for a wierd quirk when using $@ on vagrant ssh directly
    ARGS=$@
    vagrant ssh -c "cd /linkerd2-proxy && LINKERD_ARCH=${LINKERD_ARCH:-} CARGO_RELEASE=${CARGO_RELEASE:-} CARGO_VERBOSE=${CARGO_VERBOSE:-} make ${ARGS}"
fi