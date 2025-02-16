from django.contrib import admin
from django.urls import path, include
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from rest_framework import permissions

# Configuración de Swagger/Redoc
schema_view = get_schema_view(
    openapi.Info(
        title="API Documentation",
        default_version='v1',
        description="Documentación de la API de Buynlarge",
        terms_of_service="https://www.buynlarge.com/terms/",
        contact=openapi.Contact(email="contact@buynlarge.com"),
        license=openapi.License(name="BSD License"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),  # Permitir acceso a la documentación sin autenticación
)

urlpatterns = [
    # Ruta para la página de inicio (redirige a Swagger)
    path('', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),

    # Ruta para el panel de administración de Django
    path('admin/', admin.site.urls),

    # Ruta para la API (incluye las rutas de la aplicación 'api')
    path('api/', include('api.urls')),

    # Rutas para la documentación de la API
    path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path('redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
]