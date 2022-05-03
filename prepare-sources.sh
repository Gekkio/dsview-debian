#!/usr/bin/env bash
set -euo pipefail

GIT_REPO=${1}

REV=$(git -C "${GIT_REPO}" rev-parse --short HEAD)
COMMIT_DATE=$(git -C "${GIT_REPO}" log -1 --format=%cd --date=format:%Y%m%d)

LIBSIGROK="libsigrok4dsl_0.2.0+git${COMMIT_DATE}.${REV}"
echo "${LIBSIGROK}"
git -C "${GIT_REPO}" archive --format tar HEAD libsigrok4DSL | xz > "${LIBSIGROK}".orig.tar.xz

mkdir -p libsigrok4dsl
tar -C libsigrok4dsl -xJf "${LIBSIGROK}".orig.tar.xz --strip-components=1
