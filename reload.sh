#!/bin/bash
docker exec bess /opt/bessctl/bessctl/bessctl daemon reset
docker exec bess /opt/bessctl/bessctl/bessctl run file /conf/router.bess
docker exec bess /opt/bessctl/bessctl/bessctl show pipeline | tee pipeline.txt
