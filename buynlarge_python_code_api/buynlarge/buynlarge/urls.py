from django.contrib import admin
from django.urls import path, include
from drf_yasg.views import get_schema_view
from drf_yasg import openapi

# Configuración de Swagger/Redoc
schema_view = get_schema_view(
    openapi.Info(
        title="API Documentation",
        default_version='v1',
        description="Documentación de la API de Buynlarge",
    ),
    public=True,
)

urlpatterns = [
    # Ruta para la página de inicio (redirige a Swagger)
    path('', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),

    # Ruta para el panel de administración de Django
    path('admin/', admin.site.urls),

    # Ruta para la API
    path('api/', include('api.urls')),

    # Rutas para la documentación de la API
    path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path('redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
]