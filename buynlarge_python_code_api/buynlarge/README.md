
# Librerias usadas
drf-yasg para documentacion de la api
reportlab para permitir descargar pdf de reporte de nomina
django 
djangorestframework   
djangorestframework-simplejwt    autenticador no implementada logica
mssql-django  conexion sql server


# Buy-n-Large
Se creo api vista, con django rest,  donde se implemento el llamado
de procedimientos almacenados, 

@api_view(['GET'])
# def get_employee_permissions
llamado por api de procedimiento almacenado que devuelva a que permisos tiene el usuario sobre una entidad, donde le entre como parámetros un usuario y una entidad

# download_payroll_report

Reporte de domina por empleado entregandole como parametro id de usuario, nos entrega PDF para descarga
