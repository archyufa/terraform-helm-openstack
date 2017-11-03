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
#  - 'curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine'
#  - 'chmod +x /tmp/docker-machine'
#  - 'sudo cp /tmp/docker-machine /usr/local/bin/docker-machine'
  - 'sudo curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose'
  - 'sudo chmod +x /usr/local/bin/docker-compose'
