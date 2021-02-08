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
echo -e "\033[31;1m =========！！！如果有error重新添加txt 再执行上面这条命令！！！========    \033[0m"
read
echo -e "\033[31;1m 4,申请成功,制作配置文件中....:    \033[0m"
for i in `ls /root/.acme.sh|grep \*`;do cp /root/.acme.sh/${i}/${i}.cer /root/.acme.sh/${i}/${i}.key . ;done
sleep 1 
if [ ! -d /shangchuan ];then mkdir /shangchuan/ ;fi
rm -rf /shangchuan/*
sleep 1
Chkey(){
for i in `ls |grep key`;do c=`echo $i|awk -F'[_.]' '{print $2"."$3}'` && mv $i ${c}.key ;done
}
Chcer(){
for i in `ls |grep cer`;do c=`echo $i|awk -F'[_.]' '{print $2"."$3}'` && mv $i ${c}.cer ;done
}
Chall(){
for i in `ls|grep cer|awk -F'.' '{print $1"."$2}'`;do cp /usr/local/nginx/kis/jd.com.conf ${i}.conf && sed -i "s/jd\.com/$i/g" ${i}.conf;done
}
Mv(){
mv  *cer *key *conf /shangchuan
}
Chkey
sleep 1 
Chcer
sleep 1 
Chall
sleep 1 
Mv
echo -e "\033[31;1m 5, 完成！！ 查看  /shangchuan/  \033[0m"
