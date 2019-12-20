-- 1. Quantitat de registres de la taula de vols:
SELECT COUNT(*) AS total 
FROM usairlineflights2.flights;

-- 2. Retard promig de sortida i arribada segons l’aeroport origen.
SELECT Origin, AVG(ArrDelay) AS prom_arribades, AVG(DepDelay) AS prom_sortides
FROM flights
GROUP BY Origin;

-- 3. Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen. 
SELECT Origin, colMonth, colYear, AVG(ArrDelay) 
FROM flights 
GROUP BY Origin, colMonth, colYear 
ORDER BY Origin, colYear, colMonth;

-- 4. Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen 
-- (mateixa consulta que abans i amb el mateix ordre). Però a més, ara volen que 
-- en comptes del codi de l’aeroport es mostri el nom de la ciutat.
SELECT City, colYear, colMonth, AVG(ArrDelay) 
FROM flights INNER JOIN usairports ON flights.Origin=usairports.IATA 
GROUP BY City, colMonth, colYear 
ORDER BY City, colYear, colMonth;

-- 5. Les companyies amb més vols cancelats, per mesos i any. 
-- A més, han d’estar ordenades de forma que les companyies amb més cancel·lacions apareguin les primeres.
SELECT UniqueCarrier, colYear, colMonth, SUM(Cancelled)  AS total_cancelled 
FROM flights
GROUP BY UniqueCarrier, colYear, colMonth
ORDER BY total_cancelled DESC;

-- 6. L’identificador dels 10 avions que més distància han recorregut fent vols.
SELECT TailNum, SUM(Distance) AS Totaldistance 
FROM flights 
WHERE TailNum !="" 
GROUP BY TailNum 
ORDER BY Totaldistance DESC;

-- 7. Companyies amb el seu retard promig només d’aquelles les quals 
-- els seus vols arriben al seu destí amb un retràs promig major de 10 minuts.
SELECT Uniquecarrier, Avg(ArrDelay) AS avgDelay 
from flights
GROUP BY Uniquecarrier 
HAVING  avgDelay > 10
ORDER BY avgDelay DESC;
