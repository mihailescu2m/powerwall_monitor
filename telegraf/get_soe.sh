#!/bin/bash
curl -k --cookie $(cat /tmp/cookies/pw.txt | tail -n 2 | cut -d $'\t' -f 6,7 | sed -e 's/\t/=/g' | tr '\n' ';') 'https://powerwall/api/system_status/soe'
