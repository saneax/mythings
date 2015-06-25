#!/bin/bash

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
ftemp="${tdir}/t.dump"
touch ${ftemp}
touch ${ftwise}
for i in `cat ${ftdump}`
do
        #echo "${tenant_name} => ${i}" >> ${ftwise}
        #echo -n "${i}," >> ${ftwise}
        ${NOVA} --insecure show --minimal ${i} > ${ftemp}
        host=`cat ${ftemp} |  egrep 'OS-EXT-SRV-ATTR:host' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
        sstatus=`cat ${ftemp} |  egrep '\sstatus\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
        name=`cat ${ftemp} |  egrep '\sname\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
        updated=`cat ${ftemp} |  egrep '\supdated\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
        key=`cat ${ftemp} |  egrep '\skey_name\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
        tenant=`cat ${ftemp} |  egrep '\stenant_id\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
        ip=`cat ${ftemp} |  egrep 'network\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g' | tr '\n' ',' | sed 's/,$//'`
        echo "${i},${host},${updated},${sstatus},${name},${key},${tenant},${ip}" | tee -a ${ftwise}
done

#debug
scp -i keys/cloudoperations.pem ${ftwise} ubuntu@10.135.83.118:/opt/vminventory/script/data_files/vm.dump 2>&1 | logger -p error
ssh -i keys/cloudoperations.pem -l ubuntu 10.135.83.118 'ls -l /opt/vminventory/script/data_files/vm.dump' 2>&1 | logger -p error

#Remove the tempdir
rm -rf ${tdir}

