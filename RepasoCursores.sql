delimiter //
create procedure actualiceStock() 
begin
declare var1,var2 int;
declare cursorP cursor for select sum(cantidad),Producto_codProducto from  ingresostock_producto where week(fecha)=week(current_date()) group by Producto_codProducto ;
declare continue handler for not found set hayFilas=0;
open cursorP;
bucle:loop
			fetch CursorP into var1,var2;
            if(hayFilas=0) then
				leave bucle;
            end if;
            update producto set stock=stock+var1 where Producto_codProducto=var2;
			end loop;
            close cursorP;

end//
delimiter ;


delimiter //
create procedure reducirFracasos ()
begin 
declare var1,var2 int;
declare cursorF cursor for select sum(cantidad),producto_codProducto from producto join pedido on Pedido_idPedido=idPedido where week(fecha)=week(current_date()) group by producto_codProducto;
declare continue handler for not found set hayFilas=0;
open cursorF;
bucle : loop
			fetch cursorF into var1,var2;
            if(hayFilas=0) then
				leave bucle;
            end if;
            if(var1<=100)then
            update  pedido_producto set precioUnitario=precioUnitario*0.9 where producto_codProducto=var2;
            end if;
			end loop;
            close cursorF;
end//
delimiter ;


#3
delimiter //
create procedure aumentoPreciosProve() begin
declare maxPrecio int;
declare hayFilas int;
declare id int;
 
declare cursorPrice cursor for select max(precio), Producto_codProducto from producto_proveedor group by Producto_codProducto;
declare continue handler for not found set hayFilas = 0;
    open cursorPrice;
    bucle: loop
fetch cursorPrice into maxPrecio,id;
if hayFilas =0 then
    leave bucle;
end if;
	update producto set precio=maxPrecio*1.1 where id=codProducto;
end loop bucle;
close cursorPrice;
 
end //
delimiter ;


#4- Suponiendo que agregamos una columna llamada “nivel” en la tabla de proveedores, se
# pide realizar un procedimiento que calcule la cantidad de ingresos por proveedor en los
# últimos 2 meses y actualice el nivel del proveedor. Los niveles son “Bronce” hasta 50
# ingresos inclusive, “Plata” de 50 a 100 ingresos inclusive y “Oro” más de 100.

delimiter //
create procedure nivelProve() begin
declare hayFilas,cantp,id int;
declare cursorNp cursor for select count(idProveedor),idProveedor from proveedor  join ingresostock on Proveedor_idProveedor=idProveedor where month(fecha) > (month(current_date)-2) and year(fecha)=year(current_date) group by idProveedor;
declare continue handler for not found set hayFilas = 0;
open cursorNp;
bucle : loop
			fetch cursorNp into cantp,id;
            if hayFilas =0 then
				leave bucle;
			end if;
            if cantp<=50 then 
				update proveedor set nivel="Bronce" where id=idProveedor;
            end if;
            if cantp <= 100 and cantp >50 then
				update proveedor set nivel="Plata" where id=idProveedor;
            else
				update proveedor set nivel="Oro" where id=idProveedor;
            end if;
end loop bucle;
close cursorNp;	
end //
delimiter ;



# 5-   Realice un procedimiento que actualice el precio unitario de los productos que están en
#      pedidos pendientes de pago, al precio actual del producto.

delimiter //
create procedure actuPrecios() begin
declare hayFilas,precioAct,idp int;
declare cursorAp cursor for select precio,Producto_codProducto from pedido_producto join producto on codProducto=Producto_codProducto join pedido on Pedido_idPedido=idPedido join estado on Estado_idEstado=idEstado where estado.nombre="pendiente"; 
declare continue handler for not found set hayFilas = 0;
open cursorAp;
bucle : loop
			fetch cursorAp into precioAct,idp;
			if hayFilas =0 then
				leave bucle;
			end if;
            update pedido_producto set precioUnitario=precioAct where idp=Producto_codProducto;
            end loop bucle;
            close cursorAp;
end //
delimiter ;

