--Daniela Anguiano A011690706
--Index2

create index idx1 on orderdetails (orderLineNumber);
create index idx2 on orderdetails (quantityOrdered, orderLineNumber);
create index idx3 on orderdetails (orderLineNumber, quantityOrdered)

explain format = json
select * from orderdetails force index (idx3)
where orderLineNumber = 1 and quantityOrdered > 50;

explain format = json
select productCode from orderdetails force index (idx3)
where orderLineNumber = 1 and quantityOrdered > 50;

explain format = json
select orderLineNumber, count(*) from orderdetails force index (idx3)
where orderLineNumber = 1 and quantityOrdered > 50;