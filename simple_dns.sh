#!/bin/bash
if [ -z $1  ];then
    echo "No arguments supplied"
    echo "Usage: simple_dns.sh [filename of domains, one per line] (optional filename to write results to)"
    exit 1
fi

if [ -e $PWD/tmp_results_dns ]; then
	rm -rf $PWD/tmp_results_dns
fi

for i in `cat $1`;do
	nslookup $i | grep Address | tail -1 | cut -d":" -f2 >> $PWD/tmp_results_dns
done
if [ -z $2 ];then
	echo "no filename specified for output. Putting into $PWD/dns_simple_results.txt"
	cat tmp_results_dns | sort -u | sed 's#^\ ##g' >> $PWD/dns_simple_results.txt
	rm -rf $PWD/tmp_results_dns
else
	cat tmp_results_dns | sort -u | sed 's#^\ ##g' >> $2.txt
	rm -rf $PWD/tmp_results_dns
fi
exit 0
