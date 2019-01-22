#!/bin/bash

idx="0"
vfioID="80"
pfName="ens785f0"

docker stop bess

# Emulating device plugin stage
docker run --name bess -itd --rm --cap-add NET_ADMIN \
--device=/dev/vfio/$vfioID --device=/dev/vfio/vfio \
--ulimit memlock=-1 -v /dev/hugepages:/dev/hugepages \
-v $(pwd):/conf \
krsna1729/bess-router bessd -f

# Emulating "veth" CNI
mac=$(ip link show dev $pfName | awk -v idx="$idx" '$1=="vf" && $2==idx {print $4}' | tr -d ',')
docker exec -e mac=$mac bess bash -c "
ip link add foo type veth peer name foo-vdev;
ip link set foo addr $mac up;
ip link set foo-vdev up;
"

# Emulating ipam
docker exec bess bash -c "
ip addr add 198.18.0.1/30 dev foo;
ip addr add 198.19.0.1/30 dev foo;
"

# Final output
docker exec bess bash -c "
ip link show foo
ip route;
"
