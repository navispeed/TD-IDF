#!/usr/bin/env bash

mvn package -f build/WordCount

hdfs dfs -rm -r -f /input
hadoop fs -copyFromLocal data/input /input
hadoop jar build/WordCount/target/WordCount-1.0-SNAPSHOT.jar eu.navispeed.wordcount.WordCountDriver /input/callwild /results
hadoop fs -copyToLocal /results/ data/output/
