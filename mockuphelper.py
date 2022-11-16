import json
import os

def haeMockup(url):
    my_dir = os.path.dirname(__file__)
    
    tunniste = url[56:60]
    
    if tunniste == "1402":
        f = open(os.path.join(my_dir, 'mockup/maija.json'), encoding="utf-8")
    elif tunniste == "1408":
        f = open(os.path.join(my_dir, 'mockup/piato.json'), encoding="utf-8")
    else:
        raise Exception("URL virheellinen, helper toimii vain ravintola maijan ja piaton kanssa") 
    
    data = json.load(f)
    f.close()
    return data
