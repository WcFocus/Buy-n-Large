import pyodbc

conn_str = "DRIVER={ODBC Driver 17 for SQL Server};SERVER=127.0.0.1;DATABASE=NombreDeTuBaseDeDatos;UID=tu_usuario;PWD=tu_contraseña"
try:
    conn = pyodbc.connect(conn_str)
    print("Conexión exitosa")
except Exception as e:
    print(f"Error en la conexión: {e}")
