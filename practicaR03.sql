/*EJERCICIO 1*/

create  or replace function  es_jefe(v_es_jefe  number) return number
is
  v_jefe number := 0;
begin
  select count(*) into v_jefe
  from empleados
  where cod_jefe = v_es_jefe;
  if v_jefe > 0 then
    return 1;
  else
    return 0;
  end if;
end;

select es_jefe(7)  from  dual;

/*EJERCICIO  2*/

select nombre, apellido1, apellido2,
       case  es_jefe(COD_EMP)
           when 1 then  'si' else 'no'
           end  as es_jefe  from empleados
order by 2,3,1;



/*EJERCICIO 3*/

create or replace procedure informe_empleados is
cursor c_informe_empleados
    is
select nombre, APELLIDO1, APELLIDO2,  to_char(FECHA_INICIO,'DD/MM/YYYY') as fecha_inicio, NOMBRE_DEP, to_char(SALARIO) as salario, TITULO_PUESTO
from EMPLEADOS e
    join CONTRATOS C2 using(cod_emp)
    join DEPARTAMENTOS D using (cod_dep)
    join PUESTOS P using(COD_PUESTO)
order by 2,3,1;
    begin
        for r_informe_empleados in c_informe_empleados loop
            DBMS_OUTPUT.PUT_LINE(
                'Empleado: '||r_informe_empleados.NOMBRE||' '||r_informe_empleados.APELLIDO1||' '||r_informe_empleados.APELLIDO2||
                '. Contratos: '||r_informe_empleados.FECHA_INICIO||'  '|| r_informe_empleados.NOMBRE_DEP||' '||r_informe_empleados.salario||' '||
                r_informe_empleados.TITULO_PUESTO
                );
            end loop;
    end;

    begin informe_empleados; end;