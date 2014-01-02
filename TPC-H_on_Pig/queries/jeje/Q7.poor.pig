 SET default_parallel $reducers;

supplier = load '$input/supplier' USING PigStorage('|') as (s_suppkey:long, s_name:chararray, s_address:chararray, s_nationkey:int, s_phone:chararray, s_acctbal:double, s_comment:chararray);

lineitem = load '$input/lineitem' USING PigStorage('|') as (l_orderkey:long, l_partkey:long, l_suppkey:long, l_linenumber:long, l_quantity:double, l_extendedprice:double, l_discount:double, l_tax:double, l_returnflag:chararray, l_linestatus:chararray, l_shipdate:chararray, l_commitdate:chararray, l_receiptdate:chararray,l_shippingstruct:chararray, l_shipmode:chararray, l_comment:chararray);

orders = load '$input/orders' USING PigStorage('|') as (o_orderkey:long, o_custkey:long, o_orderstatus:chararray, o_totalprice:double, o_orderdate:chararray, o_orderpriority:chararray, o_clerk:chararray, o_shippriority:long, o_comment:chararray);

customer = load '$input/customer' USING PigStorage('|') as (c_custkey:long,c_name:chararray, c_address:chararray, c_nationkey:int, c_phone:chararray, c_acctbal:double, c_mktsegment:chararray, c_comment:chararray);


nation = load '$input/nation' USING PigStorage('|') as (n_nationkey:int, n_name:chararray, n_regionkey:int, n_comment:chararray);

filtered_lineitem = filter lineitem by l_shipdate >= '1995-01-01' and l_shipdate <= '1996-12-31';

lineitem_supplier = join supplier by s_suppkey, filtered_lineitem by l_suppkey;
lineitem_supplier_order = join orders by o_orderkey, lineitem_supplier by l_orderkey;
lineitem_supplier_order_customer = join customer by c_custkey, lineitem_supplier_order by o_custkey;
lineitem_supplier_order_customer_nation1 = join nation by n_nationkey, lineitem_supplier_order_customer by s_nationkey;
lineitem_supplier_order_customer_nation1_nation2 = join nation by n_nationkey, lineitem_supplier_order_customer_nation1 by c_nationkey;

filtered_lineitem_supplier_order_customer_nation1_nation2 = filter lineitem_supplier_order_customer_nation1_nation2 by ($1=='FRANCE' and lineitem_supplier_order_customer_nation1::nation::n_name=='GERMANY') or ($1=='GERMANY' and lineitem_supplier_order_customer_nation1::nation::n_name=='FRANCE');

shipping = foreach filtered_lineitem_supplier_order_customer_nation1_nation2 GENERATE lineitem_supplier_order_customer_nation1::nation::n_name as supp_nation, nation::n_name as cust_nation, SUBSTRING(l_shipdate, 0, 4) as l_year, l_extendedprice * (1 - l_discount) as volume;

grouped_shipping = group shipping by (supp_nation, cust_nation, l_year);
aggregated_shipping = foreach grouped_shipping GENERATE FLATTEN(group), SUM($1.volume) as revenue;

ordered_shipping = order aggregated_shipping by group::supp_nation, group::cust_nation, group::l_year;
store ordered_shipping into '$output/Q7poor_out' USING PigStorage('|');
