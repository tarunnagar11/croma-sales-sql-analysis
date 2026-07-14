create database croma;

use croma;

show tables;

desc product_inventory;
desc manufacturers;

select * from product_inventory;
select * from manufacturers;

-- 1.	Select the names of all the products in the inventory.
select product_name from product_inventory;	

-- 2.	Select the names and the prices of all the products in the inventory.
select product_name,product_price from product_inventory;	

-- 3.	Use an Alias "Name" and print all the product names
select product_name name from product_inventory;	

-- 4.	Select the name of the products with a price less than or equal to 8000 Indian Rupees.
select product_name,product_price from product_inventory where product_price <= 8000;	

-- 5.	Select all the products with a price between 2000 and 10000 Indian Rupees.
select * from product_inventory where product_price between 2000 and 10000;

-- 6.	List the details of all such products whose manufacturer_code is 6.
select * from product_inventory where manufacturer_code = 6;

-- 7.	List the details of all such products whose manufacturer_code is 6 as well as their price is greater than 5000.
select * from product_inventory where manufacturer_code = 6 and product_price > 5000;

-- 8.	List the details of all such products other than whose manufacturer_code is 6.
select * from product_inventory where manufacturer_code != 6;

-- or 
select * from product_inventory where manufacturer_code <> 6;

-- or 
select * from product_inventory where manufacturer_code not in ('6');

-- 9.	Select the name of the products whose name starts with 'M'.
select product_name from product_inventory where product_name like 'm%';

-- 10.	List the name of products whose name starts with "M" and ends with "D".
select product_name from product_inventory where product_name like 'm%d';

-- 11.	List the name of products which starts from "M" ends with "D" but also has ONLY 9 characters in between.
select product_name from product_inventory where product_name like 'm_________d';

-- 12.	Concatenate name of the product with its price in a single column.
select concat(product_name,'-',product_price) as name_price from product_inventory; 

-- 13.	Select the name and price in dollars (i.e. the price must be divided by 80.)
select product_name , product_price/80 from product_inventory ;

-- 14.	Compute the average price of all the products in Indian Rupees.
select avg(product_price) from product_inventory;

-- 15.	Compute the average price of all products with manufacturer code equal to 3.
select avg(product_price) from product_inventory where manufacturer_code = 3;

-- 16.	What is the total cost of products where manufacturer_code is 2?
select sum(product_price) from product_inventory where manufacturer_code = 2;

-- 17.	Compute the number of products with a price greater than or equal to 5000.
select count(*) from product_inventory where product_price >= 5000;

-- 18.	Select the name and price of all products with a price larger than or equal to 5000 Indian Rupees 
-- 	    and sort them by price (in descending order),
--      and then by their name (in ascending order).
select product_name , product_price from product_inventory where product_price >= 5000
order by product_price desc,product_name;


-- 19.	Select all the data from the inventory, including all the data for each product's manufacturer.
select p.*,m.* from product_inventory p
left join 
manufacturers m on m.manufacturer_code = p.manufacturer_code;

-- 20.	Select the product name, price, and manufacturer name of all the products.
select p.product_name,p.product_price,m.manufacturer_name from product_inventory p
inner  join 
manufacturers m on m.manufacturer_code = p.manufacturer_code;

-- 21.	Select the average price of each manufacturer's products, showing only the manufacturer's code.
select manufacturer_Code,avg(product_price) from product_inventory group by manufacturer_Code;

-- 22.	Select the average price of each manufacturer's products, showing the manufacturer's name.
select m.manufacturer_name,avg(p.product_price) from product_inventory p
inner join manufacturers m on m.manufacturer_code = p.manufacturer_code
group by m.manufacturer_name ;

-- 23.	Select the names of manufacturer whose products have an average price greater than or equal to 5000 Indian Rupees.
select m.manufacturer_name,avg(p.product_price)  from product_inventory p
inner join manufacturers m on m.manufacturer_code = p.manufacturer_code
group by m.manufacturer_name
having avg(p.product_price)  >= 5000 ;

-- 24.	Select the name and price of the cheapest product.
select product_name , product_price from product_inventory order by product_price limit 1;

-- 25.	Select the name of each manufacturer along with the name and price of its most expensive product. 
select manufacturer_name, 
		product_name,
		product_price
	from (
			select p.product_name, 
           p.product_price, 
           m.manufacturer_name,
           row_number() over(partition by m.manufacturer_name order by p.product_price desc) as rn 
			from product_inventory p
	inner join manufacturers m on m.manufacturer_code = p.manufacturer_code) as t
where rn =1;

-- 26.	Add a new product: Speaker with a price 1000 INR and manufacturer code 10.
insert into product_inventory(product_name, product_price, manufacturer_code) values('speaker',1000,10);

	-- extra
update product_inventory set product_code = 21 where product_name = 'speaker';

select * from product_inventory;

-- 27.	Update the name of the product "Speakers" to "Wired Speakers". 
update product_inventory set product_name = 'Wired Speakers' where product_name = 'Speaker';

-- 28.	Apply a 10% discount to all products. 
select product_name, (product_price - (product_price * 10)/100) from product_inventory;

-- 29.	Apply a 10% discount to all products with a price greater than or equal to 5000 Indian Rupees.
select product_name, (product_price - (product_price * 10)/100) from product_inventory where product_price >= 5000;

-- 30.	List the name of the products along with their manufacturer name and price and arrange them as per their price.
select p.product_name,p.product_price,m.manufacturer_name from product_inventory p
inner  join 
manufacturers m on m.manufacturer_code = p.manufacturer_code
order by p.product_price;
