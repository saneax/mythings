---

# Welcome to Sahara

- Sahara project aims to provide users with simple means to provision a Hadoop cluster at OpenStack
-
-
- <right> by sanjay upadhyay
- @saneax


---

### Architecture

![alt text][drawing]
[drawing]: pictures/openstack-interop.png "Sahara Architecture"

---

## Objectives of todays session

  1. understand the project sahara
  2. deploy hadoop on openstack
  3. run a small map reduce on the hadoop, which is on openstack

---

## Prerequisite

  1. At least 16G of a system for the demo to work
  2. Vagrant/Virtualbox/jdk/hadoop all available on laptop
  (usb sticks with the s/w will be available at the workshop)


---

## What is hadoop?

- It is a framework
- Written in Java
- For (large datasets)
  - Distributed storage, known as HDFS
  - Distributed processing known as yarn/MR
- Built for commodity hardware.
- Framework takes care of hardware failure

---

## What is Openstack

- It is an IAAS framework
- has a modular architecture with compute, storage, networking, imaging etc modeules
- Written in python

---

## What is AWS EMR?

- AWS EMR stands for Amazon web services - Elastic Map reduce
- Its Hadoop services and ecosystem above AWS
- AWS had 'Elastic Map Reduce' from early 2012

![alt text][awsemr]

[awsemr]: pictures/emr-services-diagram.png "AWS EMR Architecture"

---

## What is Sahara and Why?

- Amazon's EMR offering has a large no. of users 


---

## steps to get sahara working

---


