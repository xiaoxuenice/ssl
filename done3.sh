#!/bin/sh
#cat a.txt |grep Domain|awk -F "[']" '{print $2}'
#cat a.txt |grep "TXT value"|awk -F "[']" '{print $2}'
cd /root/.acme.sh
rm -rf /shangchuan/*
for i in `ls |grep \*`;do cp ${i}/${i}.cer ${i}/${i}.key /shangchuan ;done
cd /shangchuan
tar zcf yuming.tar.gz *
scp yuming.tar.gz 192.168.1.12:/newzhengshu
