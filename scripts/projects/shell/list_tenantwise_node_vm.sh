#!/bin/bash -x

source /root/openrc
tdir=`mktemp -d`
lockfile -r 0 ${tdir}/bash.lock || exit 1

KEYSTONE=`which keystone`;
NOVA=`which nova`

if [ -z ${KEYSTONE} ] && [ -z ${NOVA} ]
then
  echo "Could not find nova or keystone client"
  exit 2
fi

#Get all Tenant List
ftdump="${tdir}/tenant-list.dump"
${KEYSTONE} --insecure tenant-list > ${ftdump}

#debug
logger `head ${ftdump}`

#get tenantlist wise vm
ftwise="${tdir}/tenantwise-vm.dump"
touch ${ftwise}
for i in `cat ${ftdump}  | grep -v '+--' | grep -v 'id' |cut -d '|' -f 2`
do
  tenant_name=`cat ${ftdump} | grep -v '+--' | grep -v 'id' |grep ${i} | cut -d '|' -f 3`
  texists=`cat ${ftdump} | grep -v '+--' | grep -v 'id' | grep ${i} | cut -d '|' -f 4`
  echo ${texists} | grep "True"
  if [ $? -eq 0 ]
  then
    echo "${tenant_name} => ${i}" >> ${ftwise}
    ${NOVA} --insecure list --all-tenants --tenant ${i} --fields OS-EXT-SRV-ATTR:hypervisor_hostname,OS-EXT-SRV-ATTR:host,hostId,id,name,status,networks >> ${ftwise}
  fi
done

#debug
logger `head ${ftwise}`

cp ${ftwise} ~reliance/VMDETAILS_ARCH/tenantwise-vm.dump_`date +%H%M_%d%b%g`
chown reliance:root ~reliance/VMDETAILS_ARCH/*

#Remove the tempdir
rm -rf ${tdir}

