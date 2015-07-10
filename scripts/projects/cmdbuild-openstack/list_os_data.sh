#!/bin/bash

#This fetches all tenantwise VM details
#so the records are within ====
#==================================================
#--tenant_id,tenant_name,[all_users_in_this_tenant],[tenant_quota]
#--flavors (this is just to let you know all the flavors)
#++host_id,host,created_time,status,name,key,flavor,ip_addresses
#++host_id,host,created_time,status,name,key,flavor,ip_addresses
#++host_id,host,created_time,status,name,key,flavor,ip_addresses
#===================================================

if [ -e /root/openrc ]; then
  source /root/openrc
else
  echo "no openrc file found"
  exit 2
fi

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
${KEYSTONE} --insecure tenant-list | cut -d '|' -f 2,3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g' > ${ftdump}

#debug
logger `head ${ftdump}`

#get tenantlist wise vm
ftwise="${tdir}/vm.dump"
ftemp="${tdir}/t.dump"
touch ${ftemp}
touch ${ftwise}

flavors=`${NOVA} --insecure flavor-list |cut -d '|' -f 2,3,4,5,6,7,8,9,10 | grep -v '+--' | tr '|' ','  | sed 's/\s*//g' | grep -v ID,Name | sort -k 1 -t, -n | tr '\n' '|'`

for tenant_id in `cat ${ftdump} | cut -d, -f1`
do
        #extract tenant name
        tenant_name=`cat ${ftdump} | grep ${tenant_id} | cut -d, -f2`
        #extract users per tenant name
        #${KEYSTONE} --insecure user-list  --tenant ${i} | cut -d '|' -f 2,3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'
        all_users=`${KEYSTONE} --insecure user-list  --tenant ${tenant_id}  | cut -d '|' -f 3,5 | grep -v '+--' | tr '|' '=' | sed 's/\s*//g' | grep -v 'name=email' | tr '\n' ','`
        #GET Quota
        all_quota=`${NOVA} --insecure  quota-show --tenant ${tenant_id} |cut -d '|' -f 2,3 | grep -v '+--' | grep -v Quota | tr '|' ',' | sed 's/\s*//g' | tr ',' '=' | tr '\n' ','`
        #Print Header
        printf '=%.0s' {1..150} | tee -a ${ftwise}
        echo "" | tee -a ${ftwise}
        echo "--tenant_id,tenant_name,[all_users_in_this_tenant],[tenant_quota]" | tee -a ${ftwise}
        echo "--${tenant_id},${tenant_name},[${all_users}],[${all_quota}]" | tee -a ${ftwise}
        echo "--flavors [${flavors}]"  | tee -a ${ftwise}
        echo "++host_id,host,created_time,status,name,key,flavor,ip_addresses" | tee -a ${ftwise}

#       printf '=%.0s' {1..150} | tee -a ${ftwise}
#       echo "" | tee -a ${ftwise}

        for host_id in `${NOVA} --insecure list  --all-tenants --tenant ${tenant_id} --minimal | cut -d '|' -f 2 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g' | grep -v ID`
        do
                ${NOVA} --insecure show --minimal ${host_id} > ${ftemp}
                host=`cat ${ftemp} |  egrep 'OS-EXT-SRV-ATTR:host' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
                sstatus=`cat ${ftemp} |  egrep '\sstatus\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
                name=`cat ${ftemp} |  egrep '\sname\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
                created=`cat ${ftemp} |  egrep '\screated\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
                key=`cat ${ftemp} |  egrep '\skey_name\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
                flavor=`cat ${ftemp} |  egrep '\sflavor\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g'`
                ip=`cat ${ftemp} |  egrep 'network\s+' |cut -d '|' -f 3 | grep -v '+--' | tr '|' ',' | sed 's/\s*//g' | tr '\n' ',' | sed 's/,$//'`
                echo "++${host_id},${host},${created},${sstatus},${name},${key},${flavor},${ip}" | tee -a ${ftwise}
        done
        printf '=%.0s' {1..150} | tee -a ${ftwise}
        echo "" | tee -a ${ftwise}
done

#debug
logger `head ${ftwise}`

#Upload somewhere
scp -i keys/cloud.pem ${ftwise} ubuntu@10.0.11.5:/opt/vminventory/script/data_files/all_vm_detail-`date +%d%m%y-%H%M`
ssh -i keys/cloud.pem -l ubuntu 10.0.11.5 'ls -l /opt/vminventory/script/data_files/all_vm_detail*'


#Remove the tempdir
rm -rf ${tdir}

