#!/bin/bash

docker stop bess

docker run --name bess -itd --rm --cap-add NET_ADMIN \
--cpuset-cpus=12-13 \
--device=/dev/vfio/48 --device=/dev/vfio/vfio \
--ulimit memlock=-1 -v /dev/hugepages:/dev/hugepages \
-v $(pwd):/conf \
krsna1729/bess-router

docker exec bess bash -c "
ip link add foo type veth peer name foo-vdev;
ip link set foo up;
ip link set foo-vdev up;
ip addr add 198.18.0.1/30 dev foo;
ip addr add 198.19.0.1/30 dev foo;
ip route;
"
