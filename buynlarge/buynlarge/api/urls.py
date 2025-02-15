from django.urls import path
from . import views
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

urlpatterns = [
    # Endpoints de la API
    path('employees/<int:user_id>/', views.get_employee_permissions, name='get_employee_permissions'),
    path('payments/<int:user_id>/', views.get_payment_permissions, name='get_payment_permissions'),

    # Endpoints de autenticación JWT
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]