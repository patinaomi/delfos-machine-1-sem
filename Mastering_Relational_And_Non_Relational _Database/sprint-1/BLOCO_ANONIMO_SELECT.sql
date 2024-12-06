1. Consulta com INNER JOIN
DECLARE
    CURSOR c IS
        SELECT c.Nome, COUNT(e.ID_Consulta) AS Total_Consultas
        FROM CLIENTE c
        INNER JOIN CONSULTA e ON c.ID_Cliente = e.ID_Cliente
        GROUP BY c.Nome
        ORDER BY Total_Consultas DESC;
BEGIN
    FOR x IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || x.Nome || ', Total de Consultas: ' || x.Total_Consultas);
    END LOOP;
END;


2. Consulta com LEFT JOIN
DECLARE
    CURSOR c IS
        SELECT c.Nome, COUNT(e.ID_Consulta) AS Total_Consulta
        FROM CLIENTE c
        LEFT JOIN CONSULTA e ON c.ID_Cliente = e.ID_Cliente
        GROUP BY c.Nome
        ORDER BY Total_Consultas ASC;
BEGIN
    FOR x IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || x.Nome || ', Total de Consultas: ' || NVL(x.Total_Consultas, 0));
    END LOOP;
END;

3. Consulta com RIGHT JOIN
DECLARE
    CURSOR c IS
        SELECT e.Cidade, COUNT(c.ID_Cliente) AS Total_Clientes
        FROM CONSULTAS e
        RIGHT JOIN CLIENTE c ON c.ID_Cliente = e.ID_Cliente
        GROUP BY e.Status_Consulta
        ORDER BY Total_Clientes DESC;
BEGIN
    FOR x IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Status: ' || NVL(x.Status, 'Sem Status') || ', Total de Clientes: ' || x.Total_Clientes);
    END LOOP;
END;

