#!/bin/bash

# SERVER=root@eomy.navi.cc
#SRVDIR=/srv/ftp

TARGET=mm352-00

SERVER=baden@het.navi.cc
SRVDIR=~/www/files/$TARGET/lang/ru/amr/

#TARGET=mm350-00

# ssh -p 28192 $SERVER 'mkdir -p $SRVDIR/$TARGET'
# scp -P 28192 ./*.amr $SERVER:$SRVDIR/$TARGET
# scp ./AMR/*.amr ./amrlist.dat $SERVER:$SRVDIR/$TARGET
scp ./AMR/*.amr ./amr.dat $SERVER:$SRVDIR
#scp ./amrlist.dat $SERVER:$SRVDIR/$TARGET
