select trunc(a.faplicacion) FECHA_APLICACION, 
c.itipo_negocio COD_ITEM_PRODUCTO,
d.xdescripcion canal,d.ctabla SUBCANAL,
(case when a.cdiseno in (341,342,345) then c.ctipoplan else '' end) COD_PLAN_PRODUCTO,
count(distinct(a.qmovil)) CLIENTES_RECARGANDO,
a.cmercado COD_MERCADO,
sum(case when t.inaturaleza='C' then a.bmonto else a.bmonto*-1 end) RECARGA_BS,
min (a.bmonto) Monto_Minimo,
max (a.bmonto) Monto_Maximo,
b.cbanco BANCO,
'' RANGO_RECARGA_BS,
decode(ceil((to_char(sysdate-4,'yyyymm')-to_char(f.factivacion,'yyyymm'))/6),0,0, --mes actual
       1,ceil((to_char(sysdate-4,'mm')-to_char(f.factivacion,'mm'))/3),3) RANGO_ACTIVACION,
count(a.ctransaccion) CANTIDAD_RECARGAS
from tdominios d,thist_ajuste_c a,tdatoxrecarga_c b,TAJUSTE T,tcliente_07 f, tdiseno c --validar tabla mes correspondiente
where (d.cdominio IN ('BORECARGA') or (d.cdominio='BOTRANFER' and d.ctabla <>'Transferencia Pos a Pre'))
and d.qvalor=a.cajuste and d.qvalor=t.cajuste and a.ctransaccion=b.ctransaccion(+)
and a.cdiseno=c.cdiseno and a.qmovil=f.qmovil(+)
and trunc(a.faplicacion)>= '01/07/2023' AND trunc(a.faplicacion)<='31/07/2023'
group by trunc(a.faplicacion),c.itipo_negocio,d.xdescripcion,d.ctabla,(case when a.cdiseno in (341,342,345) then c.ctipoplan else '' end),
a.cmercado,b.cbanco,decode(ceil((to_char(sysdate-4,'yyyymm')-to_char(f.factivacion,'yyyymm'))/6),0,0, --mes actual
       1,ceil((to_char(sysdate-4,'mm')-to_char(f.factivacion,'mm'))/3),3)


