-- 1
delimiter //
create trigger after_insert_update after insert on pedido_producto for each row
begin 
	update ingresostock_producto set cantidad = cantidad+new.cantidad;
end//

-- 2 
delimiter //
create trigger before_delete_ingresostock before delete on ingresostock for each row
begin 
	delete from ingresostock_producto;
end//

-- 3
delimiter //
create trigger after_insert_pedido after insert on pedido for each row
begin 
	select sum(cantidad*precioUnitario) into monto from pedido_producto join pedido on Pedido_idPedido=idPedido group by Cliente_codCliente;
	if exist(select idPedido from pedido where year(old.fecha) > (year(current_date())-2) group by  ) then
		if(monto<50000) then 
			update cliente set categoria="bronce";
        end if;
        if(monto > 50000 and monto <= 100000 ) then 
			update cliente set categoria="bronce";
		else
			update cliente set categoria="oro";
        end if;
        end if;
end//


