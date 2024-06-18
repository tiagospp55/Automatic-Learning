#!/bin/bash

############################################################
##                                                        ##
##      OS X Start Script for RapidMiner (Batch)          ##
##                                                        ##
############################################################

# remove _JAVA_OPTIONS environment variable for this run
# it could contain stuff that break Studio launching so we ignore it completely
unset _JAVA_OPTIONS

# look up location of this script and of the bundled JRE
BASE_DIR=$(cd "$(dirname "$0")"/../..; pwd)
JAVA_HOME=$(cd "$BASE_DIR/../Helpers/jre_11.jre/Contents/Home"; pwd)
RM_HOME=$(cd "$BASE_DIR/../Resources/RapidMiner-Studio"; pwd)

# compute JVM options
RM_CLASSPATH="${RM_HOME}"/lib/*
JVM_OPTIONS=$("$JAVA_HOME/bin/java" "-Djava.awt.headless=true" -cp "$RM_CLASSPATH" com.rapidminer.launcher.JVMOptionBuilder "$@")

# remove empty and Apple PSN parameters
while [ $# -gt 0 ] && [ -z "$1" ] || [[ $1 == -psn* ]]; do
    shift
done

# launch RapidMiner Studio
eval \"$JAVA_HOME\"/bin/java $JVM_OPTIONS -cp \"${RM_CLASSPATH}\" com.rapidminer.launcher.CommandLineLauncher "$@"

# no need for return value check for potential restart in batch processing
