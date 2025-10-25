#!/usr/bin/env bash

set -oue pipefail
rpm-ostree install selinux-policy-devel

cd ./selinux/google_chrome/
make -f /usr/share/selinux/devel/Makefile googlechrome.pp
semodule -v -i ./selinux/google_chrome/googlechrome.pp

restorecon -FRv /lib/opt/google/chrome/
