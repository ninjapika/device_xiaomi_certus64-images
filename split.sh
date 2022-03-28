#!/bin/bash

# Copyright (C) 2021 Arvind Mukund <armu30@gmail.com>
# Copyright (C) 2022 Daniele Gigantino <d.gigantino@icloud.com>
# Copyright (C) 2022 Ninja Garuda <developerdevkrishn@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PARTS_PREFIX="parts"
VENDOR_PATH="vendor.img"
COMPRESSION_SUFFIX="xz"

# Cleanup first
rm -rf ./parts/*

function compress {
	echo "[i] Compressing $1 -> $1.xz"
	xz --threads=0 "$1"
}

compress "$VENDOR_PATH"
echo "[i] Splitting into images..."
split -b 49M --numeric-suffixes "${VENDOR_PATH}.${COMPRESSION_SUFFIX}" "${PARTS_PREFIX}/${VENDOR_PATH}." 

# Cleanup vendor.xz
rm "${VENDOR_PATH}.${COMPRESSION_SUFFIX}"

echo "[i] Spillting completed."
