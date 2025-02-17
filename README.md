


# Buy-n-Large
Página de inicio (Swagger): http://127.0.0.1:8000/ (swagger, documentacion de la api)

Documentación de la API (Swagger): http://127.0.0.1:8000/swagger/

Documentación de la API (Redoc): http://127.0.0.1:8000/redoc/


***Endpoints de la API:***

API usuarios con permisos: http://127.0.0.1:8000/api/GetUserPermissionsOnEntity/1/

API Reporte de nomina: http://localhost:8000/api/payroll-report/1/


#opcional faltan permisos
Autenticación JWT: (opcional no implementado completamente, faltan los permisos)

Obtener token: http://127.0.0.1:8000/api/token/

Refrescar token: http://127.0.0.1:8000/api/token/refresh/



# Coding Case: Sql Server

# 🏢 **Contexto**

Tu tarea es ayudar a **Buy n Large**, una empresa de tecnología, a desarrollar un **Sistema de Control de Permisos en una API**.

Aunque se usará un **Software de Nómina** como escenario, el verdadero objetivo de esta prueba es implementar **un sistema de permisos granular**, donde los usuarios tengan acceso restringido a nivel de **tabla y registro**, según sus roles y permisos definidos en **SQL Server**.

---

# ⚒️ **Objetivo Principal: Sistema de Permisos**

El sistema debe permitir definir y aplicar permisos que determinen:

✔️ **A qué tablas puede acceder un usuario o grupo de usuarios (roles).**

✔️ **A qué registros dentro de esas tablas puede acceder cada usuario o rol.**

Estos permisos deben aplicarse al consultar la API, asegurando que los usuarios solo accedan a la información permitida.

🔹 **Ejemplo de permisos esperados:**

- **Un rol "Supervisor"** puede ver los empleados de su departamento, pero **no** los detalles de pagos.
- **Un rol "Gerente"** puede ver tanto empleados como pagos, pero **solo dentro de su área de supervisión**.
- **Un usuario específico (ej. Bruno Díaz)** puede acceder a **todos los pagos**, pero **no a los datos personales** de los empleados.

🔹 **Requisitos técnicos:**

✅ Los permisos deben almacenarse en **SQL Server**, utilizando tablas específicas.

✅ **Toda la lógica de permisos debe estar en SQL Server** (por ejemplo, mediante funciones, procedimientos almacenados o vistas).

✅ **Django Rest Framework (DRF) solo debe ser usado para exponer los endpoints**, sin manejar lógica de permisos en la capa de aplicación.

> 🎯 El enfoque principal de esta prueba es la implementación y correcta aplicación de permisos en SQL Server.
> 

---

# ✨ **Características Opcionales (Extras)**

Si deseas agregar más valor a tu solución, puedes incluir:

### 📌 1. Reportes de Nómina

- Generar reportes de pagos de nómina por empleado, departamento o período.
- Permitir exportación en **CSV o PDF**.

### 📌 2. Auditoría de Permisos

- Registrar quién accede a información sensible y cuándo.
- Permitir consultar qué usuarios han accedido a qué información.

> Nota: Estas características son opcionales. La prioridad es el sistema de permisos.
> 

---

# 🎯 **Entrega y Evaluación**

### 📌 **Entrega**

Cada equipo debe entregar:

1️⃣ **Repositorio en GitHub**

- Código estructurado y documentado siguiendo buenas prácticas.

2️⃣ **Video Explicativo** (Máximo 10 min)

- Explicación de la solución, mostrando cómo funcionan los permisos.
- Subir el video a **YouTube** y compartir el enlace.
- **Debe ser un esfuerzo grupal**, con participación de todos los miembros.

3️⃣ **Formulario de Entrega**

- Completar y adjuntar los entregables en el siguiente formulario:[Airtable | Everyone's app platform](https://airtable.com/appQdUghInIelDQii/pagg0cUoCjq0IsQqL/form)

---

# 🔍 **Criterios de Evaluación**

✅ **Implementación de permisos en SQL Server** – Correcto uso de funciones, procedimientos almacenados, vistas y restricciones.

✅ **Diseño de la base de datos** – Estructura optimizada y lógica clara para manejar permisos.

✅ **Consumo de servicios** – Integración eficiente de DRF para exponer los datos con las restricciones adecuadas.

✅ **División de tareas** – Organización y colaboración del equipo.

✅ **Gestión del tiempo y alcance** – Entregar un MVP funcional dentro del tiempo establecido.

✅ **Calidad del código** – Uso de buenas prácticas, documentación y estructura clara.

✅ **Creatividad en la solución** – Soluciones innovadoras para manejar los permisos.

---

# ⚙️ **Consideraciones Técnicas**

✔️ **Tecnologías requeridas: Django - SQL Server - Django Rest Framework**

✔️ **Se evaluará la calidad del código y buenas prácticas de programación**

✔️ **Un repositorio bien estructurado será clave en la evaluación**