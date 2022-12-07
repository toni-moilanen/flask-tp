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

CREATE TABLE if not exists Ruoankomponentti (
    komponentti_id INTEGER NOT NULL UNIQUE,
    menu_id INTEGER NOT NULL,
    komponentti TEXT NOT NULL,
    PRIMARY KEY (komponentti_id),
    FOREIGN KEY (menu_id) REFERENCES Yksittainenruoka(menu_id)
);

INSERT INTO Ravintola (ravintola_nimi, ravintola_url) VALUES ('Ravintola Maija', 'https://www.semma.fi/modules/json/json/Index?costNumber=1402&language=fi');
INSERT INTO Ravintola (ravintola_nimi, ravintola_url) VALUES ('Ravintola Piato', 'https://www.semma.fi/modules/json/json/Index?costNumber=1408&language=fi');
