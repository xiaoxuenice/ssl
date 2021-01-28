#!/bin/sh
#同目录下 把域名写在yuming.txt里面 例如jd.com
echo -e "\033[31;1m 1,申请中...    \033[0m"
rm -rf /root/.acme.sh/\*.*
rm -rf a.txt
for i in `cat yuming.txt`;do  /root/.acme.sh/acme.sh --issue  -d "*.${i}" -d ${i}  --dns  --yes-I-know-dns-manual-mode-enough-go-ahead-please >> a.txt ;done
if [ `cat a.txt |grep Domain|awk -F "[']" '{print $2}' |wc -l` -eq `cat a.txt |grep "TXT value"|awk -F "[']" '{print $2}'|wc -l` ] ;then echo -e "\033[31;1m 2,申请有效    \033[0m";else echo "error";fi
cat a.txt |grep Domain|awk -F "[']" '{print $2}'
cat a.txt |grep "TXT value"|awk -F "[']" '{print $2}'
echo -e "\033[31;1m 3,在域名解析里面添加 txt 解析,完成之后回车:    \033[0m"
read
for i in `cat yuming.txt`;do  /root/.acme.sh/acme.sh --issue  -d "*.${i}" -d ${i}  --dns  --yes-I-know-dns-manual-mode-enough-go-ahead-please --renew ;done
echo -e "\033[31;1m 4,申请成功，打包中....:    \033[0m"
cd /root/.acme.sh
if [ ! -d /shangchuan ];then mkdir /shangchuan;fi
rm -rf /shangchuan/*
for i in `ls |grep \*`;do cp ${i}/${i}.cer ${i}/${i}.key /shangchuan ;done
cd /shangchuan
tar zcf yuming.tar.gz *
echo -e "\033[31;1m 5, 完成！！ 查看/shangchuan/yuming.tar.gz   \033[0m"
