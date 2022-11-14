import sqlite3
from mockuphelper import haeMockup
#from urllib.request import Request, urlopen
#import json

tietokanta_yhteys = sqlite3.connect("./SQL/semma-db.db")
kursori = tietokanta_yhteys.cursor()

kursori.execute('SELECT ravintola_id, ravintola_url FROM Ravintola')
ravintolat = kursori.fetchall()

#TODO: tiedon haku palvelimelta mockup-datan sijaan...
def hae(url):
    return haeMockup(url)
    #pyynto = Request(url)
    #pyynto.add_header('User-Agent', 'Minun py skripti')
    #sisalto = urlopen(pyynto)
    #return json.load(sisalto)

for (ravintola_id, url) in ravintolat:
    data = hae(url)
    uusimman_pvm = (data["MenusForDays"][0]["Date"])[0:10]

    kursori.execute('''
        SELECT * FROM Paivanruoat
        WHERE ravintola_id = ?
        AND paivamaara >= ?''',
        (ravintola_id, uusimman_pvm,))

    kirjatut = len(kursori.fetchall())

    if not kirjatut:
        kursori.execute('''
            INSERT INTO Paivanruoat
            (ravintola_id, paivamaara)
            VALUES (?, ?)''',
            (ravintola_id, uusimman_pvm,))

        paiva_id = kursori.lastrowid

        for yksittainenruoka in data["MenusForDays"][0]["SetMenus"]:
            tyyppi = yksittainenruoka["Name"]
            hinta = yksittainenruoka["Price"]
            kursori.execute('''
                INSERT INTO Yksittainenruoka
                (paiva_id, tyyppi, hinta)
                VALUES (?, ?, ?)''',
                (paiva_id, tyyppi, hinta,))

            menu_id = kursori.lastrowid

            #TODO ruoankomponenttien vienti tietokantaan...
            for ruoankomponentti in yksittainenruoka["Components"]:
                #print(ruoankomponentti)
                kursori.execute('''
                    INSERT INTO Ruoankomponentti
                    (menu_id, nimi)
                    VALUES (?, ?)''',
                    (menu_id, ruoankomponentti,))

kursori.connection.commit()
kursori.close()
