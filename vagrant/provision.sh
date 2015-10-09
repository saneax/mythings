#!/bin/bash
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update
apt-get install -y git gem ruby puppet
gem install librarian-puppet-simple
git clone https://github.com/saneax/ospuppet /tmp/ospuppet
cd /tmp/ospuppet/puppet
librarian-puppet install
cd
mv /tmp/ospuppet/puppet /etc/
cp /etc/puppet/hiera.yaml /etc/
puppet apply --debug --verbose  --modulepath /etc/puppet/modules /etc/puppet/manifests/site.pp

