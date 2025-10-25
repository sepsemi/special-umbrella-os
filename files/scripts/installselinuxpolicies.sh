#!/usr/bin/env bash

set -oue pipefail
rpm-ostree install selinux-policy-devel

setenforce 0

cd ./selinux/google_chrome/
make -f /usr/share/selinux/devel/Makefile googlechrome.pp

semodule -v -i googlechrome.pp
echo 'Restoring permissions:'
restorecon -FRv /opt/
restorecon -FRv /usr/

setenforce 1
#chcon -t googlechrome_exec_t /usr/lib/opt/google/chrome/chrome
