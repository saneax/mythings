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
${NOVA} --insecure list --all-tenants --minimal | awk '{print $2}' > ${ftdump}
#${KEYSTONE} --insecure tenant-list > ${ftdump}

#debug
logger `head ${ftdump}`

#get tenantlist wise vm
ftwise="${tdir}/vm.dump"
touch ${ftwise}
for i in `cat ${ftdump}`
do
        echo "${tenant_name} => ${i}" >> ${ftwise}
        ${NOVA} --insecure show --minimal 97a10d47-0fbe-492d-8c4e-d8d6b72c2fc5 | cut -d '|' -f 2,3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'  >> ${ftwise}
done

#debug
logger `head ${ftwise}`

cp ${ftwise} ~reliance/VMDETAILS_ARCH/vm.dump_`date +%H%M_%d%b%g`
chown reliance:root ~reliance/VMDETAILS_ARCH/*

#Remove the tempdir
rm -rf ${tdir}

