#!/bin/bash

install() {
  local qmgrName=$1
  local qmgrPort=$2
  local mqExplorerGroup=$3
  local mqClientGroup=$4
  local testQueue=$5

  echo "mqm             hard    nofile          10240" >> /etc/security/limits.conf
  echo "mqm             soft    nofile          10240" >> /etc/security/limits.conf
  echo "mqm             hard    nproc           30720" >> /etc/security/limits.conf
  echo "mqm             soft    nproc           30720" >> /etc/security/limits.conf

  su - mqm -c "mkdir -p /home/mqm/qmgrs/data"
  su - mqm -c "mkdir -p /home/mqm/qmgrs/log"
  chown -R mqm:mqm /home/mqm/qmgrs

  su - mqm -c "crtmqm -p ${qmgrPort} -u SYSTEM.DEAD.LETTER.QUEUE -md /home/mqm/qmgrs/data -ld /home/mqm/qmgrs/log ${qmgrName}"
  su - mqm -c "strmqm ${qmgrName}"
  su - mqm -c "setmqaut -m ${qmgrName} -t qmgr -g ${mqExplorerGroup} +connect +inq +dsp +chg"
  su - mqm -c ". /opt/mqm/samp/bin/amqauthg.sh ${qmgrName} ${mqExplorerGroup}"
  su - mqm -c "runmqsc ${qmgrName} < /home/mqm/mq-setup.mqsc"

  # MQ Client specific configuration
  su - mqm -c "setmqaut -m ${qmgrName} -t qmgr -g ${mqClientGroup} +connect +inq +dsp +chg"
  su - mqm -c "setmqaut -m ${qmgrName} -n ${testQueue} -t q -g ${mqExplorerGroup} +put +dsp +clr +chg +dlt"
  su - mqm -c "setmqaut -m ${qmgrName} -n ${testQueue} -t q -g ${mqClientGroup} +get +inq"
  su - mqm -c "setmqaut -m ${qmgrName} -n ${testQueue}.BOQ -t q -g ${mqClientGroup} +put +passall "
}

install $1 $2 $3 $4 $5