# Openstack orchestration via puppet
#### by Sanjay Upadhyay (@saneax)


---

## Objectives

   * To install a working openstack via puppet
   * To make changes upstream (your own forked repo) and test it
   * benifits and why use a CM for development environment


---

## Why puppet and not ansible, salt & chef?

   * There is a lot of work already done on puppet
   * Openstack infra folks use it
   * puppet openstack is moving into big tent
   * puppet is a powerfull CM system with wider acceptance


---

## Pre Requisite to orchestrating puppet for openstack

   * install vagrant
   * install virtualbox
   * install the vagrant hostmanager plugin
   ```bash
   vagrant plugin install vagrant-hostmanager
   ```
   * install r10k

---

## Orchestrating openstack via puppet (step 1)

  * Clone https://github.com/puppetlabs/puppetlabs-openstack


---

## Orchestrating openstack via puppet (step 2)

  * popupate modules via R10K


---


