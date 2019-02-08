#!/usr/bin/env bash

hdfs dfs -rm -r -f /word-per-doc
rm -rf data/output

mvn package -f build/WordPerDoc

hadoop fs -mkdir /word-per-doc /word-per-doc/results
hadoop fs -cp /word-count/results/ /word-per-doc/input
hadoop jar build/WordPerDoc/target/WordPerDoc-1.0-SNAPSHOT.jar eu.navispeed.wordperdoc.WordPerDocDriver /word-per-doc/input/ /word-per-doc/output
hadoop fs -copyToLocal /word-per-doc/output/ data/
