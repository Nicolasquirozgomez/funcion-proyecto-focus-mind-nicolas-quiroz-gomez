DELIMITER //

CREATE FUNCTION ObtenerResumenUsuario(
    p_IdUsuario INT
) RETURNS VARCHAR(500)
DETERMINISTIC
BEGIN
    DECLARE resumen VARCHAR(500);
    
    SELECT CONCAT('Usuario: ', P.Nombre, ' - Total Actividades: ', COUNT(A.IdActividades),
                  ' - Actividades: ', GROUP_CONCAT(A.Nombre SEPARATOR ', '))
    INTO resumen
    FROM Personas P
    LEFT JOIN Planificador PL ON P.IdPersonas = PL.IdUsuario
    LEFT JOIN Actividades A ON PL.IdActividad = A.IdActividades
    WHERE P.IdPersonas = p_IdUsuario
    GROUP BY P.IdPersonas;
    
    RETURN IFNULL(resumen, 'Usuario no encontrado o sin actividades');
END //

DELIMITER ;
