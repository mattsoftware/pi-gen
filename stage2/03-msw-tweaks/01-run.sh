#!/bin/bash -e

install -m 644 files/journald.conf ${ROOTFS_DIR}/etc/systemd/journald.conf
install -m 644 files/msw_provision.service ${ROOTFS_DIR}/etc/systemd/system/msw_provision.service
install -m 644 files/msw_provisioned.service ${ROOTFS_DIR}/etc/systemd/system/msw_provisioned.service
install -m 644 files/ssmsetup.service ${ROOTFS_DIR}/etc/systemd/system/ssmsetup.service
install -m 644 files/editor.sh ${ROOTFS_DIR}/etc/profile.d/editor.sh

on_chroot << EOF
curl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_arm/amazon-ssm-agent.deb -o /root/amazon-ssm-agent.deb
dpkg -i /root/amazon-ssm-agent.deb
systemctl disable amazon-ssm-agent
systemctl enable msw_provision
systemctl enable msw_provisioned
systemctl enable ssmsetup
EOF

