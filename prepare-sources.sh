#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2022 Joonas Javanainen <joonas.javanainen@gmail.com>
#
# SPDX-License-Identifier: CC0-1.0

set -euo pipefail

GIT_REPO=${1}

REV=$(git -C "${GIT_REPO}" rev-parse --short HEAD)
COMMIT_DATE=$(git -C "${GIT_REPO}" log -1 --format=%cd --date=format:%Y%m%d)

DSVIEW="dsview_1.3.1+git${COMMIT_DATE}.${REV}"
echo "${DSVIEW}"
git -C "${GIT_REPO}" archive --format tar HEAD | xz > "${DSVIEW}".orig.tar.xz

mkdir -p dsview
tar -C dsview -xJf "${DSVIEW}".orig.tar.xz
