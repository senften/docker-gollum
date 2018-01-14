#!/bin/bash                                                                
                                                                                   
echo "Update wiki."                                        
          
cd /root/wikidata
git pull >>/var/log/wikigit.log 2>&1
git push >>/var/log/wikigit.log 2>&1
