SHELL=/bin/bah
PATH=/sbin/bin:/usr/sbin:/usr/bin

#!/bin/bash

service nginx status > output.txt

if grep -q "running" output.txt; then
echo "The nginx service is running"
else
service nginx start
echo "The nginx service was stopped, errored, or inactive. The service has been started." | mail -s "The nginx service was stopped." ##@##.org
fi
