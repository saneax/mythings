FROM ubuntu:latest
MAINTAINER Sanjay Upadhyay <saneax@gmail.com>


RUN apt-get update && \
  apt-get install -y wget && \
  wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb && \
  dpkg -i puppetlabs-release-trusty.deb && \
  apt-get update && \
  apt-get install -y puppet

COPY /puppet/hiera.yaml /etc/hiera.yaml
COPY /puppet /etc/puppet/


RUN  ls -l /etc/puppet && \
  ls -l /etc/puppet/manifests && \
  puppet apply --debug --verbose --modulepath /etc/puppet/modules /etc/puppet/manifests/site.pp

WORKDIR /home/sanjayu

CMD ["bash"]
