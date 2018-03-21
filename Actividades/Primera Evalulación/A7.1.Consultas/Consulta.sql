select Orders.customerNumber, ProductLines.textDescription
from Orders  join OrderDetails on OrderDetails.orderNumber = Orders.orderNumber 
join Products on Products.productCode = OrderDetails.productCode join ProductLines on Products.productLine = ProductLines.productLine
where Orders.customerNumber = 112