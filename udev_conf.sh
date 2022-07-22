#!/bin/bash

set -o errexit

grpname=${USER}

# Create udev rule
UdevFile="/etc/udev/rules.d/30-xsens.rules"

echo "Writing the udev rules file...";

# Xsens IMU
echo "SUBSYSTEM==\"tty\", ATTRS{idVendor}==\"2639\", GROUP=\"$grpname\", SYMLINK+=\"sensors/imu\"" 1>>$UdevFile

echo "Restarting udev daemon..."

/etc/init.d/udev restart
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Configuration complete."
echo "A reboot may be required on some systems for changes to take effect."
exit 0
