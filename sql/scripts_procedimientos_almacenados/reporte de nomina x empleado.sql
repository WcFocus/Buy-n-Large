CREATE PROCEDURE ReporteNominaPorEmpleado
    @EmpleadoID BIGINT -- Parámetro de entrada: ID del empleado
AS
BEGIN
    -- Verificar si el empleado existe
    IF NOT EXISTS (SELECT 1 FROM [User] WHERE id_user = @EmpleadoID)
    BEGIN
        PRINT 'El empleado no existe en la base de datos.';
        RETURN;
    END;

    -- Generar el reporte de nómina para el empleado
    SELECT 
        U.id_user AS EmpleadoID,
        U.user_username AS Usuario,
        U.user_email AS Correo,
        C.compa_name AS Compañía,
        CC.cosce_name AS Departamento,
        BO.broff_name AS Sucursal,
        -- Campos ficticios para simular datos de nómina
        (SELECT 2000) AS Salario, -- Ejemplo de salario fijo
        (SELECT 200) AS Bonificaciones, -- Ejemplo de bonificaciones
        (SELECT 100) AS Deducciones, -- Ejemplo de deducciones
        (SELECT 2100) AS Neto -- Ejemplo de neto (Salario + Bonificaciones - Deducciones)
    FROM 
        [User] U
    INNER JOIN 
        UserCompany UC ON U.id_user = UC.user_id
    INNER JOIN 
        Company C ON UC.company_id = C.id_compa
    LEFT JOIN 
        CostCenter CC ON C.id_compa = CC.company_id
    LEFT JOIN 
        BranchOffice BO ON C.id_compa = BO.company_id
    WHERE 
        U.id_user = @EmpleadoID; -- Filtra por el ID del empleado
END;



EXEC ReporteNominaPorEmpleado @EmpleadoID = 1; -- Cambia el 1 por el ID del empleado deseado