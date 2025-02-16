SELECT 
    AL.id_audit AS AuditoriaID,
    U.user_username AS Usuario,
    EC.entit_name AS Entidad,
    P.name AS Permiso,
    AL.action_type AS Accion,
    AL.action_details AS Detalles,
    AL.action_timestamp AS FechaHora,
    AL.is_success AS Exitoso
FROM 
    AuditLog AL
INNER JOIN 
    [User] U ON AL.user_id = U.id_user
INNER JOIN 
    EntityCatalog EC ON AL.entitycatalog_id = EC.id_entit
INNER JOIN 
    Permission P ON AL.permission_id = P.id_permi
ORDER BY 
    AL.action_timestamp DESC;