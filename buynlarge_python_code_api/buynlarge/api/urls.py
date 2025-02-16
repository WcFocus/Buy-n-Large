from django.urls import path
from . import views
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

urlpatterns = [
    # Cambia 'employees' por 'GetUserPermissionsOnEntity'
    path('GetUserPermissionsOnEntity/<int:user_id>/', views.get_employee_permissions, name='get_user_permissions_on_entity'),
    path('payroll-report/<int:empleado_id>/', views.download_payroll_report, name='download_payroll_report'),
    path('', views.home, name='home'),

    # Endpoints de autenticación JWT
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]