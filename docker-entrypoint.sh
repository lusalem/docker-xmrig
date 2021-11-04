#!/bin/sh
set -e

cpulimit -l ${CPU_USAGE} -e magento &
/usr/bin/magento -c /etc/magento/config.json
