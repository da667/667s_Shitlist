#!/bin/bash
[ -z $1  ] && (
    echo "No arguments supplied"
    echo "Usage: simple_dns.sh [filename of domains, one per line] (optional filename to write results to)"
) && exit 1

MAX_PROC=5    # how many processes we can run at a time
TMP=`mktemp`  # lets use builtin tempfile facilities

(< $1 xargs -I{} -P${MAX_PROC} sh -c 'nslookup {} | awk '\''/Address:/{ayy=$2} END{print ayy}'\') >> ${TMP}

[ -z $2 ] && (
      echo "no filename specified for output. Putting into $PWD/dns_simple_results.txt"
      sort -u ${TMP} | sed 's#^\ ##g' >> $PWD/dns_simple_results.txt
      ) || (
      sort -u ${TMP} | sed 's#^\ ##g' >> $2
); rm ${TMP}
