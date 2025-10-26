#!/usr/bin/env bash

set -oue pipefail

QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(\d+\.\d+\.\d+)' | sed 's/kernel-//')"

temp_conf_file="$(mktemp '/etc/dracut.conf.d/zzz-loglevels-XXXXXXXXXX.conf')"
cat >"${temp_conf_file}" <<'EOF'
stdloglvl=4
sysloglvl=0
kmsgloglvl=0
fileloglvl=0
EOF

/usr/bin/dracut \
    --kver "${QUALIFIED_KERNEL}" \
    --force \
    --add 'ostree' \
    --no-hostonly \
    --reproducible \
    "/lib/modules/${QUALIFIED_KERNEL}/initramfs.img"

rm -- "${temp_conf_file}"

chmod 0600 "/lib/modules/${QUALIFIED_KERNEL}/initramfs.img"
