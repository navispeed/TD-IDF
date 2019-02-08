#!/usr/bin/env bash

hdfs dfs -rm -r -f /word-count
rm -rf data/output

mvn package -f build/

hadoop fs -mkdir /word-count /word-count/results
hadoop fs -copyFromLocal data/input /word-count/input
hadoop jar build/wordcount/target/wordcount-1.0-SNAPSHOT.jar eu.navispeed.hadoop.tfidf.wordcount.WordCountDriver /word-count/input/ /word-count/output
#hadoop jar build/WordCount/target/WordCount-1.0-SNAPSHOT-jar-with-dependencies.jar eu.navispeed.wordcount.WordCountDriver /word-count/input/ /word-count/output
hadoop fs -copyToLocal /word-count/output/ data/
