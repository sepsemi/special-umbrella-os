#!/usr/bin/env bash

set -oue pipefail
rpm-ostree install selinux-policy-devel

cd ./selinux/google_chrome/
make -f /usr/share/selinux/devel/Makefile googlechrome.pp

semodule -v -i googlechrome.pp
echo 'Restoring permissions:'
restorecon -FRv /usr/lib/opt/google/chrome/chrome


chcon -t googlechrome_exec_t /usr/lib/opt/google/chrome/chrome
