#!/bin/bash

docker stop bess

docker run --name bess -itd --rm --cap-add NET_ADMIN \
--device=/dev/vfio/48 --device=/dev/vfio/vfio \
--ulimit memlock=-1 -v /dev/hugepages:/dev/hugepages \
-v $(pwd):/conf \
ngick8stesting/ngic-bessd-ctl:pkgs bessd -f

docker exec bess bash -c "
ip link add foo type veth peer name foo-vdev;
ip link set foo up;
ip link set foo-vdev up;
ip addr add 198.18.0.1/30 dev foo;
ip route;
"
