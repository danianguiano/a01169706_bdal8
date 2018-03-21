--Daniela Rebeca Anguiano Ojeda a01169706

delimiter //
drop procedure if exists _film_cursor;
create procedure _film_cursor()
BEGIN
  declare ids int;
  declare done INT default false;
  declare cursor1 cursor for select film_id from film;
  declare continue handler for not found 
  set done = true;

  open cursor1;
  read_loop: LOOP
    fetch cursor1 into ids;
    if done then
      LEAVE read_loop;
    end if;
			update film set title = concat(getCategory(ids), '_', title)
      where film_id = ids;
	end LOOP;
  close cursor1;
END//
delimiter ;
