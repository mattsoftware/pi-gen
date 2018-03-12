#!/bin/bash -e

install -m 644 files/msw_provision.service ${ROOTFS_DIR}/etc/systemd/system/msw_provision.service
install -m 644 files/msw_provisioned.service ${ROOTFS_DIR}/etc/systemd/system/msw_provisioned.service

on_chroot << EOF
systemctl enable msw_provision
systemctl enable msw_provisioned
EOF

