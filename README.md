# jenkins-customized
jenkins installation customized

Edit jenkins-runner.sh edit the last 2 lines:
```shell
# update those two lines to make jenkins to work with customized
# installation location
echo $JAVA_HOME/bin/java $javaArgs -jar "$war" $args
exec $JAVA_HOME/bin/java $javaArgs -jar "$war" $args
```
