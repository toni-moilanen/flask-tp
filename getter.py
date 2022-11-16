import sqlite3
import json

def haeRavintoloidenMenut():
    tietokanta_yhteys = sqlite3.connect("./SQL/semma-db.db")
    kursori = tietokanta_yhteys.cursor()

    kursori.execute('SELECT ravintola_id, ravintola_nimi FROM Ravintola')
    ravintolat = kursori.fetchall()

    def tuplesToStrings(lista):
        uusiLista = []
        for x in lista:
            uusiLista.append(x[0])
        return uusiLista

    kaikkiRavintolat = []

    for (ravintola_id, ravintola_nimi) in ravintolat:
        palautus = {}
        
        kursori.execute('SELECT paiva_id, paivamaara FROM Paivanruoat WHERE ravintola_id = ? AND paivamaara = (SELECT max(paivamaara) from Paivanruoat where ravintola_id=?)', (ravintola_id, ravintola_id, ))

        palautus['RestaurantName'] = ravintola_nimi

        (paiva_id, paivamaara) = kursori.fetchall().pop()

        kursori.execute('SELECT menu_id, tyyppi, hinta FROM Yksittainenruoka where paiva_id=?', (paiva_id, ))
        
        yksittaiset_ruoat = kursori.fetchall()

        SetMenus = []

        for (menu_id, tyyppi, hinta) in yksittaiset_ruoat:
            kursori.execute('SELECT komponentti FROM Ruoankomponentti where menu_id=?', (menu_id, ))
            komponentit = kursori.fetchall()
            SetMenu = ({'Name' : tyyppi, 'Price': hinta, 'Components' : tuplesToStrings(komponentit)})
            SetMenus.append(SetMenu)

        palautus['MenusForDays'] = [{'Date' : paivamaara, 'SetMenus' : SetMenus}]
        kaikkiRavintolat.append(palautus)
        
    return kaikkiRavintolat

print(json.dumps(haeRavintoloidenMenut(), indent=2))
