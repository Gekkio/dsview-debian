#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2022 Joonas Javanainen <joonas.javanainen@gmail.com>
#
# SPDX-License-Identifier: CC0-1.0

set -euo pipefail

GIT_REPO=${1}

REV=$(git -C "${GIT_REPO}" rev-parse --short HEAD)
COMMIT_DATE=$(git -C "${GIT_REPO}" log -1 --format=%cd --date=format:%Y%m%d)

LIBSIGROK="libsigrok4dsl_0.2.0+git${COMMIT_DATE}.${REV}"
echo "${LIBSIGROK}"
git -C "${GIT_REPO}" archive --format tar HEAD libsigrok4DSL | xz > "${LIBSIGROK}".orig.tar.xz

mkdir -p libsigrok4dsl
tar -C libsigrok4dsl -xJf "${LIBSIGROK}".orig.tar.xz --strip-components=1

LIBSIGROKDECODE="libsigrokdecode4dsl_0.6.0+git${COMMIT_DATE}.${REV}"
echo "${LIBSIGROKDECODE}"
git -C "${GIT_REPO}" archive --format tar HEAD libsigrokdecode4DSL | xz > "${LIBSIGROKDECODE}".orig.tar.xz

mkdir -p libsigrokdecode4dsl
tar -C libsigrokdecode4dsl -xJf "${LIBSIGROKDECODE}".orig.tar.xz --strip-components=1

DSVIEW="dsview_1.1.2+git${COMMIT_DATE}.${REV}"
echo "${DSVIEW}"
git -C "${GIT_REPO}" archive --format tar --prefix "DSView-${REV}/" HEAD DSView "NEWS*" "ug*.pdf" | xz > "${DSVIEW}".orig.tar.xz

mkdir -p dsview
tar -C dsview -xJf "${DSVIEW}".orig.tar.xz --strip-components=1
