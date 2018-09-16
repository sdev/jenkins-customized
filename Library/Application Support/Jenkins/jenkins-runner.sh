#!/bin/bash
#
# Startup script used by Jenkins launchd job.
# Mac OS X launchd process calls this script to customize
# the java process command line used to run Jenkins.
# 
# Customizable parameters are found in
# /Library/Preferences/org.jenkins-ci.plist
#
# You can manipulate it using the "defaults" utility.
# See "man defaults" for details.

defaults="defaults read /Library/Preferences/org.jenkins-ci"
# sdev: Add this line to work with customized java installaiton location
export JAVA_HOME="/Users/sdev/.sdkman/candidates/java/current"
war=`$defaults war` || war="/Applications/Jenkins/jenkins.war"

javaArgs="-Dfile.encoding=UTF-8"

minPermGen=`$defaults minPermGen` && javaArgs="$javaArgs -XX:PermSize=${minPermGen}"
permGen=`$defaults permGen` && javaArgs="$javaArgs -XX:MaxPermSize=${permGen}"

minHeapSize=`$defaults minHeapSize` && javaArgs="$javaArgs -Xms${minHeapSize}"
heapSize=`$defaults heapSize` && javaArgs="$javaArgs -Xmx${heapSize}"

tmpdir=`$defaults tmpdir` && javaArgs="$javaArgs -Djava.io.tmpdir=${tmpdir}"

home=`$defaults JENKINS_HOME` && export JENKINS_HOME="$home"

add_to_args() {
    val=`$defaults $1` && args="$args --${1}=${val}"
}

args=""
add_to_args prefix
add_to_args httpPort
add_to_args httpListenAddress
add_to_args httpsPort
add_to_args httpsListenAddress
add_to_args httpsKeyStore
add_to_args httpsKeyStorePassword

echo "JENKINS_HOME=$JENKINS_HOME"
echo "Jenkins command line for execution:"

# update those two lines to make jenkins to work with customized
# installation location
echo $JAVA_HOME/bin/java $javaArgs -jar "$war" $args
exec $JAVA_HOME/bin/java $javaArgs -jar "$war" $args
