# Openstack orchestration via puppet
#### by Sanjay Upadhyay (@saneax)


---

### Who am I?

- 15 years of devops experience
- last 8 years in CM
- Have been managing large Hadoop clusters
- Now, at RJIL devops for the openstack cloud infra


    contact
    mail     => saneax@gmail.com
    twitter  => @saneax
    blog     => saneax.github.io


---

## Objectives

   * To install a working openstack via puppet
   * To make changes upstream (your own forked repo) and test it
   * benefits and why use a CM for development environment


---

## Why puppet and not ansible, salt & chef?

   * There is a lot of work already done on puppet
   * Openstack infra folks use it
   * puppet openstack is moving into big tent
   * puppet is a powerful CM system with wider acceptance
   * Wider industry acceptance around openstack ie. mirantis, redhat, cisco, enovance etc.


---

## Pre Requisite to orchestrating puppet for openstack

   * install vagrant
   * install virtualbox
   * install the vagrant hostmanager plugin
   ```bash
   vagrant plugin install vagrant-hostmanager
   ```
   * install r10k/puppet-librarian


Note: a little puppet and ruby knowledge will help

---

## What is puppetlabs openstack module?

   * puppetlabs-openstack allows for the rapid deployment of an installation of OpenStack Juno.
   * The puppetlabs-openstack module is built on the 'Roles and Profiles' pattern.
   * The puppetlabs-openstack module is used to deploy a multi-node, all-in-one, or swift-only installation of OpenStack Juno.
   * Every node in a deployment is assigned a single role.  Every role is composed of some number of profiles, which ideally should be independent of one another, allowing for composition  of new roles.

Note: Previous icehouse/havana versions are broken atm.

---

##Versioning

This module has been given version 4 to track the puppet-openstack modules. The versioning for the
puppet-openstack modules are as follows:

```
Puppet Module :: OpenStack Version :: OpenStack Codename
2.0.0         -> 2013.1.0          -> Grizzly
3.0.0         -> 2013.2.0          -> Havana
4.0.0         -> 2014.1.0          -> Icehouse
5.0.0         -> 2014.2.0          -> Juno
```

---

## What are the [Roles](https://github.com/puppetlabs/puppetlabs-openstack/tree/master/manifests/role) ?

1. [allinone](https://github.com/puppetlabs/puppetlabs-openstack/blob/master/manifests/role/allinone.pp)
2. [compute](https://github.com/puppetlabs/puppetlabs-openstack/blob/master/manifests/role/compute.pp)
3. [controller](https://github.com/puppetlabs/puppetlabs-openstack/blob/master/manifests/role/controller.pp)
4. [network](https://github.com/puppetlabs/puppetlabs-openstack/blob/master/manifests/role/network.pp)
5. [storage](https://github.com/puppetlabs/puppetlabs-openstack/blob/master/manifests/role/storage.pp)
6. [tempest](https://github.com/puppetlabs/puppetlabs-openstack/blob/master/manifests/role/tempest.pp)



---

#### [multinode setup](https://github.com/puppetlabs/puppetlabs-openstack/tree/master/examples/multinode)

For the multi-node, up to six types of nodes are created for the deployment:

 * A controller node that hosts databases, message queues and caches, and most api services.
 * A storage node that hosts volumes, image storage, and the image storage api.
 * A network node that performs L2 routing, L3 routing, and DHCP services.
 * A compute node to run guest operating systems.
 * Optional object storage nodes to host an object/blob store.
 * An optional Tempest node to test your deployment.

---

##all in one node setup

- The all-in-one deployment sets up all of the services except for Swift,
including the Tempest testing.

- Note: This module have been tested with Puppet 3.5 and Puppet Enterprise. This module depends upon Hiera.
- Note: the swift module depends on PuppetDB

##Limitations

* High availability and SSL-enabled endpoints are not provided by this module.


---

## step 1 (populate the puppet modules and there dependencies)

```bash
cd ./puppetlab-openstack/examples/allinone
./00_download_modules.sh
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/keystone
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/swift
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/glance
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/cinder
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/neutron
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/nova
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/heat
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/ceilometer
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/horizon
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/openstacklib
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/tempest
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/vswitch
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/apache
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/epel
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/inifile
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/mysql
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/stdlib
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/rsync
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/xinetd
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/concat
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/memcached
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/ssh
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/qpid
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/sysctl
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/rabbitmq
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/staging
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/vcsrepo
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/firewall
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/apt
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/mongodb
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/ntp
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/postgresql
[R10K::Action::Puppetfile::Install - INFO] Updating module /home/sanjayu/workspace/puppetlabs-openstack/examples/allinone/modules/puppetdb
```

---

## Steps

1. vagrant up ([we have already the correct Vagrant file for virtualbox](https://github.com/saneax/puppetlabs-openstack/tree/vbox_changes))
```bash
vagrant up
```
2. Vagrant provision
```bash
vagrant provision
```
3. Install puppet master (this will install puppet inside the vagrant images)
```bash
./10_setup_master.sh
```
4. setup the puppetmaster
```bash
./11_setup_openstack.sh
```

---

## Steps (continued)


5. Enable puppet agent
```bash
vagrant ssh puppet -c 'sudo puppet agent --enable'
vagrant ssh allinone -c 'sudo puppet agent --enable'
```
6. create puppet certs and approve them (caution)
```bash
./20_setup_node.sh
```

If this fails, check if you have correct /etc/host entries.
```bash
vagrant ssh allinone -c 'cat /etc/hosts'
127.0.0.1       localhost

127.0.0.1       allinone        allinone
192.168.11.3    puppet             <------
Connection to 127.0.0.1 closed.
```

---

## Steps (continued)

6. deploy the openstack
```bash
./30_deploy.sh
```

 - The above might fail, if any of the steps prior to this had errors
 - In case of not being able to get it up, feel free to contact me at saneax@gmail.com

---

## Q & A

---
