#!/usr/bin/env bash

set -oue pipefail
rpm-ostree install selinux-policy-devel

make -f /usr/share/selinux/devel/Makefile ./selinux/google_chrome/googlechrome.pp
semodule -v -i ./selinux/google_chrome/googlechrome.pp

restorecon -FRv /lib/opt/google/chrome/