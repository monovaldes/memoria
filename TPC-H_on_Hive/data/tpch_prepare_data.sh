$HADOOP_HOME/bin/hadoop fs -mkdir /tpch/ 

$HADOOP_HOME/bin/hadoop fs -mkdir /tpch/customer
$HADOOP_HOME/bin/hadoop fs -mkdir /tpch/lineitem
$HADOOP_HOME/bin/hadoop fs -mkdir /tpch/nation
$HADOOP_HOME/bin/hadoop fs -mkdir /tpch/orders
$HADOOP_HOME/bin/hadoop fs -mkdir /tpch/part
$HADOOP_HOME/bin/hadoop fs -mkdir /tpch/partsupp
$HADOOP_HOME/bin/hadoop fs -mkdir /tpch/region
$HADOOP_HOME/bin/hadoop fs -mkdir /tpch/supplier

$HADOOP_HOME/bin/hadoop fs -copyFromLocal customer.tbl /tpch/customer/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal lineitem.tbl /tpch/lineitem/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal nation.tbl /tpch/nation/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal orders.tbl /tpch/orders/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal part.tbl /tpch/part/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal partsupp.tbl /tpch/partsupp/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal region.tbl /tpch/region/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal supplier.tbl /tpch/supplier/
