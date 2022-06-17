#!/bin/bash
ipaddress=\`route -n | grep tunl0 | awk -F' ' '{print \$1, \$2}'\`
ipaddress=\`echo \$ipaddress | tr \"\n\" \" \"\`
iparray=(\$ipaddress);
for ((index=0; index<\${#iparray[@]}; index=\${index}+2)); do
  ping -c 3 \${iparray[\${index}]}
done
