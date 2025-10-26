#!/usr/bin/env bash

set -euo pipefail

systemctl preset-all --preset-mode=enable-only
systemctl --global preset-all --preset-mode=enable-only
