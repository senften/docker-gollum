#!/bin/bash                                                                
                                                                                   
echo "Starting gollum."                                        
echo $@
# Start sync cronjob
cron

# sync to get started
/root/gitpullpush.sh
# Start gollum
/usr/local/bundle/bin/gollum /root/wikidata $@
