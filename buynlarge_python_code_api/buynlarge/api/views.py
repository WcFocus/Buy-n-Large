from django.http import JsonResponse, HttpResponse
from django.db import connection
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from io import BytesIO

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
                'user_name': row[0],
                'permission_name': row[1],
                'Pdescription': row[2],
                'tabla_permisos': row[3],
                'can_create': row[4],
                'can_read': row[5],
                'can_update': row[6],
                'can_delete': row[7],
                'can_import': row[8],
                'can_export': row[9],
            })
        
        return JsonResponse(permissions, safe=False)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

def download_payroll_report(request, empleado_id):
    """
    Genera y descarga un reporte de nómina en formato PDF para un empleado específico.
    """
    try:
        empleado_id = int(empleado_id)  # Asegurar que sea un entero

        # Llamar al procedimiento almacenado para obtener los datos de nómina
        with connection.cursor() as cursor:
            cursor.execute("EXEC ReporteNominaPorEmpleado @EmpleadoID = %s", [empleado_id])
            results = cursor.fetchall()

        # Verificar si se encontraron resultados
        if not results:
            return JsonResponse({'error': 'No se encontraron datos de nómina para el empleado.'}, status=404)

        # Crear un buffer para almacenar el PDF
        buffer = BytesIO()

        # Crear el objeto PDF
        pdf = canvas.Canvas(buffer, pagesize=letter)
        pdf.setTitle("Reporte de Nómina")

        # Agregar contenido al PDF
        pdf.drawString(100, 750, "Reporte de Nómina por Empleado")
        pdf.drawString(100, 730, "=" * 50)

        # Escribir los datos del empleado
        for row in results:
            pdf.drawString(100, 700, f"Empleado ID: {row[0]}")
            pdf.drawString(100, 680, f"Usuario: {row[1]}")
            pdf.drawString(100, 660, f"Correo: {row[2]}")
            pdf.drawString(100, 640, f"Compañía: {row[3]}")
            pdf.drawString(100, 620, f"Departamento: {row[4]}")
            pdf.drawString(100, 600, f"Sucursal: {row[5]}")
            pdf.drawString(100, 580, f"Salario: ${row[6]}")
            pdf.drawString(100, 560, f"Bonificaciones: ${row[7]}")
            pdf.drawString(100, 540, f"Deducciones: ${row[8]}")
            pdf.drawString(100, 520, f"Neto: ${row[9]}")

        # Finalizar el PDF
        pdf.showPage()
        pdf.save()

        # Obtener el contenido del buffer y preparar la respuesta
        buffer.seek(0)
        response = HttpResponse(buffer, content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="reporte_nomina_{empleado_id}.pdf"'
        return response

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

def home(request):
    """
    Página de inicio que redirige a la documentación de Swagger.
    """
    return HttpResponse("¡Bienvenido a la API de Buy n Large! Visita <a href='/swagger/'>Swagger</a> para ver la documentación.")