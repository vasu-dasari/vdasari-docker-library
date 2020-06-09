#!/bin/bash
#
# Copyright (C) 2015 GNS3 Technologies Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

export PATH=$PATH:/usr/share/openvswitch/scripts/

ovs-ctl --ovs-usermode=yes start

x=0
until [ $x = "4" ]; do
    ovs-vsctl --may-exist add-br br$x -- set Bridge br$x datapath_type="netdev" fail-mode=secure
    x=$((x+1))
done

if [ $MANAGEMENT_INTERFACE -eq 1 ]; then
    x=1
else
    x=0
fi

until [ $x = "8" ]; do
    ovs-vsctl --may-exist add-port br0 eth$x
    x=$((x+1))
done

x=0
until [ $x = "4" ]; do
    ip link set dev br$x up
    x=$((x+1))
done

/bin/bash -i
