#cloud-config
apt:
  sources:
    docker.list:
      source: 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
      keyid: 5811 8E89 F3A9 1289 7C07 0ADB F762 2157 2C52 609D
      keyserver: 'hkp://p80.pool.sks-keyservers.net:80'
packages:
  - docker-engine
  - python-simplejson
runcmd:
  - usermod -aG docker cca-user
  - systemctl start docker
  - systemctl enable docker
