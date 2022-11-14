import json
import os

def haeMockup(url):
    my_dir = os.path.dirname(__file__)
    match url[56:60]:
        case "1402":
            f = open(os.path.join(my_dir, 'mockup/maija.json'), encoding="utf-8")
        case "1408":
            f = open(os.path.join(my_dir, 'mockup/piato.json'), encoding="utf-8")
        case _:
            raise Exception("URL virheellinen, helper toimii vain ravintola maijan ja piaton kanssa") 
    
    data = json.load(f)
    f.close()
    return data
