#cloud-config

fs_setup:

 - label: docker-srg
   filesystem: ‘xfs'
   device: '/dev/xvdb'
   partition: 'auto'

 - label:  nfsprov
   filesystem: ’xfs'
   device: '/dev/xvdc'
   partition: 'auto'

mounts:
 - [ xvdb, /var/lib/docker, "auto", "defaults", "0", "0" ]
 - [ xvdc, /var/lib/nfs-provisioner, "auto", "defaults", "0", "0" ]
