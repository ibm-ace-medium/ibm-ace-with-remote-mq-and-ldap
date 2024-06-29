#!/bin/bash

usage="mq-setup-with-ldap.sh [qmgrName] [mqExplorerGroup] [mqClientGroup] [testQueue]
ex: ./mq-setup-with-ldap.sh Qmgr01 mqadmins mqclients IN
"

install() {
  local qmgrName=$1
  local mqExplorerGroup=$2
  local mqClientGroup=$3
  local testQueue=$4

  su - mqm -c "runmqsc ${qmgrName} < /home/mqm/mq-setup-with-ldap.mqsc"
  su - mqm -c "setmqaut -m ${qmgrName} -t qmgr -g ${mqExplorerGroup} +connect +inq +dsp +chg"
  su - mqm -c ". /opt/mqm/samp/bin/amqauthg.sh ${qmgrName} ${mqExplorerGroup}"

  # MQ Client specific configuration
  su - mqm -c "setmqaut -m ${qmgrName} -t qmgr -g ${mqClientGroup} +connect +inq +dsp +chg"
  su - mqm -c "setmqaut -m ${qmgrName} -n ${testQueue} -t q -g ${mqExplorerGroup} +put +dsp +clr +chg +dlt"
  su - mqm -c "setmqaut -m ${qmgrName} -n ${testQueue} -t q -g ${mqClientGroup} +get +inq"
  su - mqm -c "setmqaut -m ${qmgrName} -n ${testQueue}.BOQ -t q -g ${mqClientGroup} +put +passall"
}

#install $1 $2 $3 $4
install QMgr01 mqadmins mqclients IN