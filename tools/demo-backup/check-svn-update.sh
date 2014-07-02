#!/bin/sh

# check trunk for updates

cd /home/ofbizDemo/trunk
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/

svn st -u | grep '*'

if [ $? = 0 ]; then
    svn up
    ./ant stop
    ./ant clean-all
    ./ant load-demo
    ./ant svninfo
    #./ant start  > console.log
    ./ant start-batch
fi

# check branch for updates

cd /home/ofbizDemo/branch13.7
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64/

svn st -u | grep '*'

if [ $? = 0 ]; then
    svn up
    ./ant stop -Dportoffset=10000 
    ./ant clean-all
    ./ant load-demo
    ./ant svninfo
    #./ant start -Dportoffset=10000 > console.log
    ./ant start-batch -Dportoffset=10000
fi

cd /home/ofbizDemo/branch12.4

svn st -u | grep '*'

if [ $? = 0 ]; then
    svn up
    tools/stopofbiz.sh
    sleep 10
    tools/stopofbiz.sh
    sleep 10
    tools/stopofbiz.sh
    sleep 10
    ./ant clean-all
    ./ant load-demo
    ./ant svninfo
    sleep 10
    tools/startofbiz.sh
fi
