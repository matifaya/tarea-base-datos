delimiter //
create trigger after_insert_customers after insert on customers for each row
begin 
	insert into customers_audit values (null,"insert",current_user(),current_date(),new.customerNumber);
end//

drop trigger after_insert_customers ;


-- b
delimiter //
create trigger before_update_customers before update on customers for each row
begin
	insert into customers_audit values (null,"insert",current_user(),current_date(),old.customerNumber);
end// 

update customers set customerNumber=4 WHERE customerNumber=103;

-- c

delimiter // 
create trigger before_delete_customers before delete on customers for each row
begin 
	insert into customers_audit values (null,"insert",current_user(),current_date(),old.customerNumber);
end//

-- 2

delimiter //
create trigger before_delete_employees before delete on employees for each row
begin 
	insert into employees_audit values (null,"delete",current_user(),current_date(),old.employeeNumber,old.email); 
end//

-- b

delimiter //
create trigger after_update_employees after update on employees for each row 
begin 
	insert into employees_audit values (null,"update",current_user(),current_date(),old.employeeNumber,old.email); 
end//  

-- c 
delimiter //
create trigger after_insert_employees after insert on employees for each row
begin 
	insert into employees_audit values(null,"insert",current_user(),current_date(),new.employeeNumber,new.email);
end// 

-- 3

delimiter //
create trigger before_delete_prduct
begin

end//
