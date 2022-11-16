CREATE TABLE if not exists Ravintola (
    ravintola_id INTEGER UNIQUE PRIMARY KEY,
    ravintola_nimi TEXT NOT NULL,
    ravintola_url TEXT NOT NULL
);

CREATE TABLE if not exists Paivanruoat (
    paiva_id INTEGER NOT NULL UNIQUE,
    ravintola_id INTEGER NOT NULL,
    paivamaara TEXT NOT NULL,
    PRIMARY KEY (paiva_id),
    FOREIGN KEY (ravintola_id) REFERENCES Ravintola(ravintola_id)
);

CREATE TABLE if not exists Yksittainenruoka (
    menu_id INTEGER NOT NULL UNIQUE,
    paiva_id INTEGER NOT NULL,
    tyyppi TEXT NOT NULL,
    hinta TEXT NOT NULL,
    PRIMARY KEY (menu_id),
    FOREIGN KEY (paiva_id) REFERENCES Paivanruoat(paiva_id)
);

--Alla oleva rivi hävittää Ruoankomponenttitaulun, jos se on jo olemassa.
DROP TABLE IF EXISTS Ruoankomponentti;

--TODO: Ruoankomponentti
CREATE TABLE Ruoankomponentti (
    --tarvitaan  komponentti_id, menu_id, komponentti
    --huomaa myös primary key ja foreign key
    
    --Esimerkki semman jsonista ruoankomponenteista:
    --"Components": [
    --  "Kikherne-bataattipataa (* ,A ,G ,ILM ,L ,M ,Veg ,VS)",
    --  "Höyrytettyä tummaa riisiä (* ,G ,L ,M ,Veg)"  
    --]
    
    --Mieti kuinka taulukko tallentuu relaatiotietokantaan.
);

--Luntteja alla:
DROP TABLE IF EXISTS Ruoankomponentti;

CREATE TABLE if not exists Ruoankomponentti (
    komponentti_id INTEGER NOT NULL UNIQUE,
    menu_id INTEGER NOT NULL,
    komponentti TEXT NOT NULL,
    PRIMARY KEY (komponentti_id),
    FOREIGN KEY (menu_id) REFERENCES Yksittainenruoka(menu_id)
);

--Tiputetaan kaikki tallennetut arvot taulusta Ravintola
DELETE FROM Ravintola;

--TODO: Kahden ravintolan alustaminen tietokantaan, jotta fetcher.py
--osaisi hakea näiden perusteella semman sivuilta tietoa...

--Katso Ravintolataulusta kentät.
--Huomaa, että haluttua URLia ei saada mockup tiedostosta.
--URLiin tarvitaan osoite, josta JSON-data haetaan

--Runko lauseelle:
--INSERT INTO Ravintola (?, ?) VALUES ('?', '?');
--Eli: mitä ?-merkkien paikalle tulee?

--Luntteja:
INSERT INTO Ravintola (ravintola_nimi, ravintola_url) VALUES ('Ravintola Maija', 'https://www.semma.fi/modules/json/json/Index?costNumber=1402&language=fi');
INSERT INTO Ravintola (ravintola_nimi, ravintola_url) VALUES ('Ravintola Piato', 'https://www.semma.fi/modules/json/json/Index?costNumber=1408&language=fi');



INSERT INTO Paivanruoat (paiva_id, ravintola_id, paivamaara) VALUES (4,1,'2022-11-17');
INSERT INTO Paivanruoat (paiva_id, ravintola_id, paivamaara) VALUES (5,1,'2022-11-18');
INSERT INTO Paivanruoat (paiva_id, ravintola_id, paivamaara) VALUES (6,1,'2022-11-19');

SELECT * FROM Paivanruoat WHERE ravintola_id = 1 AND paivamaara >= '2023-05-05';
SELECT * FROM Paivanruoat WHERE ravintola_id = 1 AND paivamaara >= '2021-05-05';
SELECT * FROM Paivanruoat WHERE ravintola_id = 1 AND paivamaara >= '2022-11-19';