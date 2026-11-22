#!/bin/bash
# Install (or reinstall) the WeChat bridge systemd service.
# The canonical unit lives in the home directory (persistent across VM
# replacements); /etc/systemd/system does not persist, so this script
# re-installs it whenever it is missing. Safe to run repeatedly.
set -e
UNIT_SRC="/home/hatch/wechat-bridge/wechat-bridge.service"
UNIT_DST="/etc/systemd/system/wechat-bridge.service"

cp "$UNIT_SRC" "$UNIT_DST"
systemctl daemon-reload
systemctl enable wechat-bridge.service
systemctl restart wechat-bridge.service
sleep 3
systemctl is-active wechat-bridge.service
