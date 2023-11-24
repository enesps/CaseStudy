
# Weather Aplication 

Bu proje hava durumu uygulamasidir.

## Kullanılan Teknolojiler

**Client:** Swift, UIKit , Alamofire , Deeplink , API



  
## API Kullanımı

#### Tüm öğeleri getir

```http
  https://api.openweathermap.org/data/2.5/onecall?lat=?&lon=?exclude=?&appid=?
```

| Parametre | Tip     | Açıklama                |
| :-------- | :------- | :------------------------- |
| `appid` | `string` | **Gerekli**. API anahtarınız. |
| `lat` | `int` | **Gerekli**. API anahtarınız. |
| `lon` | `int` | **Gerekli**. API anahtarınız. |

Projenin constans.swift dosyasindan appid girilmelidir ya da guncellenmelidir.
