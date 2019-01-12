#!/bin/bash
BESSCTL="/opt/bess/bessctl/bessctl"
# IFNAME is veth created in setup.sh
docker exec -e IFNAME=foo bess $BESSCTL daemon reset -- run file /conf/router.bess
docker exec bess $BESSCTL show pipeline | tee pipeline.txt
