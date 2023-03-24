/*EJERCICIO 1*/

create table partidos_empatados(
id_Equipo_casa  number(2),
id_Equipo_fuera number(2),
fecha timestamp,
constraint partidos_empatados_pk primary key (id_Equipo_casa,id_Equipo_fuera)
);

/*EJERCICIO 2*/

declare
cursor c_partidos_e is
select ID_EQUIPO_CASA, ID_EQUIPO_FUERA, FECHA  from PARTIDOS
  where GOLES_CASA = GOLES_FUERA;
v1 c_partidos_e%ROWTYPE;
begin
    open c_partidos_e;
    loop
        fetch c_partidos_e into v1;
        exit when c_partidos_e%notfound;
        insert into partidos_empatados (id_Equipo_casa, id_Equipo_fuera, fecha) VALUES (v1.ID_EQUIPO_CASA,v1.ID_EQUIPO_FUERA,v1.FECHA);
        end loop;
    close c_partidos_e;
end;

/*EJERCICIO 3*/
declare
cursor c_tablas  is
select TABLE_NAME , TABLESPACE_NAME from user_tables  where TABLESPACE_NAME like 'USUARIOS';
v1 c_tablas%rowtype;
begin
    open c_tablas;
    loop
        fetch c_tablas into v1;
        exit when  c_tablas%notfound;
       execute immediate 'drop table v1.table_name cascade constraints';
    end loop;
    close c_tablas;
end;

select * from user_tables;
--comentario
