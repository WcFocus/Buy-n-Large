from django.http import JsonResponse, HttpResponse
from django.db import connection

def get_employee_permissions(request, user_id):
    """
    Obtiene los permisos de un usuario sobre una entidad específica.
    """
    try:
        user_id = int(user_id)  # Asegurar que sea un entero
        entity_id = 1  # Define el ID de la entidad para la cual deseas obtener los permisos (ajusta según tu caso)

        with connection.cursor() as cursor:
            # Llamar al procedimiento almacenado que creamos
            cursor.execute("EXEC GetUserPermissionsOnEntity @user_id = %s, @entitycatalog_id = %s", [user_id, entity_id])
            results = cursor.fetchall()
        
        # Convertir resultados a formato JSON
        permissions = []
        for row in results:
            permissions.append({
                'PermissionName': row[0],
                'can_create': bool(row[1]),
                'can_read': bool(row[2]),
                'can_update': bool(row[3]),
                'can_delete': bool(row[4]),
                'can_import': bool(row[5]),
                'can_export': bool(row[6]),
            })
        
        return JsonResponse(permissions, safe=False)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

def get_payment_permissions(request, user_id):
    """
    Obtiene los pagos permitidos para un usuario específico.
    """
    try:
        user_id = int(user_id)
        with connection.cursor() as cursor:
            cursor.execute("EXEC GetPaymentPermissions @user_id = %s", [user_id])
            results = cursor.fetchall()
        
        payments = []
        for row in results:
            payments.append({
                'id': row[0],
                'amount': row[1],
                'date': row[2],
                # Agrega más campos si es necesario
            })
        
        return JsonResponse(payments, safe=False)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

def home(request):
    """
    Página de inicio que redirige a la documentación de Swagger.
    """
    return HttpResponse("¡Bienvenido a la API de Buy n Large! Visita <a href='/swagger/'>Swagger</a> para ver la documentación.")