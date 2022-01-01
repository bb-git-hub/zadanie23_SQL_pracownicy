1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.
CREATE TABLE pracownicy (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    salary DECIMAL(7,2) NOT NULL,
    birth_date DATE NOT NULL,
    position VARCHAR(30) NOT NULL
);

2. Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO pracownicy
	(first_name, last_name, email, salary, birth_date, position)
VALUES
	("M","N-M","mnm@firma.pl",4211.56,"1974-12-02","Kierownik"),
	("I","P-G","ipg@firma.pl",8283.45,"1962-04-04","Kierownik"),
	("J","Ś-W","jsw@firma.pl",4732.11,"1992-03-03","Specjalista ds handlowych"),
	("M","C","mc@firma.pl",3749.01,"1999-05-05","Specjalista ds handlowych"),
	("T","N","tn@firma.pl",4200.00,"1980-07-07","Specjalista ds handlowych"),
	("B","C","bc@firma.pl",6500.05,"1998-08-08","Analityk"),
	("B","B","bb@firma.pl",4199.99,"1981-01-01","Specjalista ds handlowych");

3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM "pracownicy" ORDER BY last_name ASC;

4. Pobiera pracowników na wybranym stanowisku
SELECT * FROM "pracownicy" WHERE position = "Kierownik";

5. Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM pracownicy WHERE birth_date <= "1991-12-29";

6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE pracownicy SET salary = salary * 1.1 WHERE position = "Analityk";

7. Pobiera najmłodszego pracowników (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)
SELECT * FROM pracownicy WHERE birth_date = (SELECT MAX(birth_date) FROM pracownicy);

8. Usuwa tabelę pracownik
DROP TABLE pracownicy;

9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE java_stanowisko (
	id INT PRIMARY KEY AUTO_INCREMENT,
	position VARCHAR(30) NOT NULL,
	description VARCHAR(30) NOT NULL,
	position_salary DECIMAL(10,2) NOT NULL
);

10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE java_adres (
	id INT PRIMARY KEY AUTO_INCREMENT,
	street_no VARCHAR(50) NOT NULL,
	postal_code VARCHAR(5) NOT NULL,
	city VARCHAR(30) NOT NULL
);

11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE java_employee (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	java_stanowisko_id INT NOT NULL,
	java_adres_id INT NOT NULL,
	FOREIGN KEY (java_stanowisko_id) REFERENCES java_stanowisko(id),
	FOREIGN KEY (java_adres_id) REFERENCES java_adres(id)
);

12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)
INSERT INTO java_stanowisko
	(position, description, position_salary)
VALUE
	("Zastępca Kierownika", "Osoba zastępująca kierownika.", 6888.88),
	("Starszy Specjalista", "Pracownik z doświadczeniem powyżej 5 lat.", 3900),
	("Specjalista", "Pracownik z doświadczeniem 2-5 lat.", 3000),
	("Młodszy Specjalista", "Pracownik z doświadczeniem do 2 lat.", 2499.99);

INSERT INTO java_adres
	(street_no, postal_code,city)
VALUE
	("Ulica 2/2","22222", "Miasto Dwa"),
	("Ulica 3/3","33333", "Miasto Trzy"),
	("Ulica 4/4","44444", "Miasto Trzy"),
	("Ulica 5/5","22222","Miasto Dwa");

INSERT INTO java_employee
	(first_name,last_name,java_stanowisko_id,java_adres_id)
VALUES
	("I","PG",5,1),
	("M","NM",4,2),
	("T","N",3,3),
	("B","B",2,4),
	("B","C",1,5);

13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT first_name, last_name, position, street_no, postal_code, city
FROM java_employee, java_stanowisko, java_adres
WHERE java_employee.java_stanowisko_id = java_stanowisko.id
AND java_employee.java_adres_id = java_adres.id

14. Oblicza sumę wypłat dla wszystkich pracowników w firmie
SELECT first_name, last_name, position, position_salary, street_no, postal_code, city
FROM java_employee, java_stanowisko, java_adres
WHERE java_employee.java_stanowisko_id = java_stanowisko.id
AND java_employee.java_adres_id = java_adres.id

SELECT SUM(java_stanowisko.position_salary)
FROM java_employee, java_stanowisko
WHERE java_employee.java_stanowisko_id = java_stanowisko.id

15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)
SELECT first_name, last_name, postal_code
FROM java_employee, java_adres
WHERE java_employee.java_adres_id = java_adres.id
AND postal_code = "22222"