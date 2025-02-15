from django.urls import reverse
from rest_framework.test import APITestCase
from rest_framework import status

class EmployeePermissionsTest(APITestCase):
    def test_get_employee_permissions(self):
        url = reverse('get_employee_permissions', args=[1])
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)