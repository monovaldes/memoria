#!/bin/bash
$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs stop namenode
./send_com.sh slaves "source /etc/profile;$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs stop datanode"
./send_com.sh hadoop11 "source /etc/profile;$HADOOP_PREFIX/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR stop resourcemanager"
./send_com.sh slaves "source /etc/profile;$HADOOP_PREFIX/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR stop nodemanager"
./send_com.sh hadoop11 "source /etc/profile;$HADOOP_PREFIX/sbin/yarn-daemon.sh stop proxyserver --config $HADOOP_CONF_DIR"
./send_com.sh hadoop11 "source /etc/profile;$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh stop historyserver --config $HADOOP_CONF_DIR"
