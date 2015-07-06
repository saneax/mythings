DEBUG=1
if [ $DEBUG -gt 0 ]
then
        exec 3>&1 4>&2
        trap 'exec 2>&4 1>&3' 0 1 2 3
        exec 1>>/tmp/zext_smtp_log.out 2>&1
        set -x
fi
# Default parameters
FROM='zabbix'
MSMTP_ACCOUNT='zabbix'

# Parameters (as passed by Zabbix):
#  $1 : Recipient
#  $2 : Subject
#  $3 : Message
recipient=$1
subject=$2
message=$3

date=`date --rfc-2822`

# Replace linefeeds (LF) with CRLF and send message
#sed 's/$/\r/' <<EOF | /usr/bin/msmtp --account $MSMTP_ACCOUNT $recipient

cat <<EOF | /usr/bin/msmtp --account $MSMTP_ACCOUNT $recipient
From: <$FROM>
To: <$recipient>
Subject: $subject
Date: $date
$message

Disclaimer: Auto Generated Zabbix Alert, contact cloud.devops@ril.com for any problems.

EOF
#We need /etc/msmtprc for the default account
#account zabbix
#tls off
#tls_starttls off
#tls_certcheck off
#host 10.137.2.24
#port 25
#auth off
#from cloud.devops@ril.com
#logfile /var/log/msmtp.log

