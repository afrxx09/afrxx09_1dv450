#1dv450 Webbramverk

###Installation

- Ladda ner / klona repo
- installera gems : "$> bundle install"
- Generera Routes: "$> bundle exec rake routes"
- Skapa databasen: "$> bundle exec rake db:schema:load"
- Seeda data: "$> bundle exec rake db:seed"
- Starta servern: "$> rails s"

####Postman dump
[PostMan dump-fil med exempel-requests](https://github.com/afrxx09/afrxx09_1dv450/blob/master/Backup.postman_dump.txt)

###Logga in i webgränssnittet
För adminkonto: "admin@test.com" / "password"
För användarkonto: "user@test.com" / "password"

###API-användare
##### Skapa en applikation och generera API-nyckel
Efter att en API-användare skapat ett konto kan denne logga in. För att få en nyckel måste man först skapa en applikation som nyckeln ska användas till.
När applikationen är skapad kan användaren generera en API-nyckel som används för att skicka requests mot API-et.

#####Registrera Hosts / URL:er
Varje applikation måste även registrera vilka hosts/url:er som den ska acceptera requests ifrån. Detta för att ingen ska kunna använda någon annans nyckel.
För utveckling när man oftast sitter på "localhost" eller "127.0.0.1" så måste dessa registreras för att requests ska accepteras.
Ska applikationen köras live på exempelvis www.mydomain.se måste "mydomain.se" registrerad som giltig url.

###API-versioner
####Version 1: depricated - använd ej
Kan endast skicka GET-requests för öppen data med API-nyckel.

Ingen direkt säkerhet och väldigt begränsad


####Version 2 - current version
Några nämnvärda features

- Stöd för användare och inloggning, inloggade användare kan skapa nya händelser samt redigera och ta bort sina egna
- kontrollerar att requests görs från en säker källa/host
- Loggar alla requests som gör till en API-nyckel för statistik
- Mer felmeddelanden och tydligare status-koder på svaren
 

###Skicka requests
Generellt format på request url:er
```
http://host/api/{api-version}/{resource-in-plural-form}/(optional{resource-id/})(optional{parameters})
```

För att kunna skicka requests till API:et måste en giltig nyckel skickas med. Detta kan göras via http-header eller som get-parameter
```
//Header:
X-ApiKey: (api-key-goes-here)

//request url to get events
http://localhost:3000/api/v2/events/
```
or
```
http://localhost:3000/api/v2/events/?api_key=(api-key-goes-here)
```

####Parametrar
Det finns 4 parametrar som kan användas för att manipulera resultat

```
//Add API-key can be sent as get-parameter 
?api_key=api_key_goes_here

//Offset. Default is 0
?offset=number

//Limit. Default is 25, max 100
?limit=number

//Order By. DESC(Descending) is default
?order=(asc|desc)
```

####GET
För att läsa data behövs endast en API-nyckel skickas med enligt en av de två metoderna ovan.

####POST, PUT, DELETE
För att kunna manipulera data måste en användare authensieras. Detta görs via http-headers

####Logga in en användare
API-nyckel krävs
Måste skickas som POST
POST-parametrar som krävs:
"email" och "password"
```
//Http-headers:
POST /api/v2/authenticate HTTP/1.1
Host: localhost:3000
X-ApiKey: (api_key_goes_here)

//form data
email = user1@test.com
password = password

//method:POST
http://localhost:3000/api/v2/authenticate
```

Exempel på svar:
```json
{
    "user": {
        "id": 1,
        "email": "user1@test.com",
        "first_name": "A-firstname",
        "last_name": "last",
        "url": "http://localhost:3000/api/v2/users/1"
    },
    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoxfQ.88HRd2zvwmeE0p4xP0SGzccB__-oWRewUdrGnmHixtozmNExpdbQFz0iO2AIHQUeQ4f7uDg3cMtQoajBvAYhjw"
}
```

Token som kommer i svaret kan nu användas för att identifiera en inloggad användare med hjälp av http-headern "Authorization".

#### Skicka requests som inloggad användare

För att skicka requests som inloggad användare måste föregående "token" skickas med i http-headern via "Authorization"-attributet.

Exempel på header som skapar ett nytt event på en användare med autensiering
```
POST /api/v2/events/ HTTP/1.1
Host: localhost:3000
X-ApiKey: 524c94faf385b814ce22d7d83b73cbd3
Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoxfQ.88HRd2zvwmeE0p4xP0SGzccB__-oWRewUdrGnmHixtozmNExpdbQFz0iO2AIHQUeQ4f7uDg3cMtQoajBvAYhjw
Cache-Control: no-cache

----WebKitFormBoundaryE19zNvXGzXaLvS5C
Content-Disposition: form-data; name="comment"

asdf #hejh #hoe
----WebKitFormBoundaryE19zNvXGzXaLvS5C
Content-Disposition: form-data; name="lat"

82.65
----WebKitFormBoundaryE19zNvXGzXaLvS5C
Content-Disposition: form-data; name="lng"

44.22
----WebKitFormBoundaryE19zNvXGzXaLvS5C
```

###Resources and URL's
#####Users
Application users, not much to say
```
/* Get (25 first) Users */
GET: api/v2/users/

/* Get User by id */
GET: api/v2/users/{id}

/* Create user (Requires Auth) */
POST: api/v2/users
```
#####Places
"Place" är en fysisk plats, med ett namn och eventuellt adress. Exempelvis "Kaffé kaffe, storgatan 123, 123 45 Staden", "Stortorget" eller "Företaget AB, gat-vägen 1". 
```
/* Get (25 first) Places */
GET: api/v2/places/

/* Get Place by id */
GET: api/v2/places/{id}

/* Create Place (Requires Auth) */
POST: api/v2/place
```
#####Positions
Position är endast koordinater, kopplade till en händelse. Latitud och longitud, inget mer.

Dessa avrundas ner till 4 decimaler för att kunna gruppera positioner. 4 decimaler gör att det minst skiljer ca 11 meter mellan varje position.

```
/* Get (25 first) Positions */
GET: api/v2/positions/

/* Get Position by id */
GET: api/v2/positions/{id}

/* Create Position (Requires Auth) */
POST: api/v2/positions
```
#####Tags
Tags är taggar i klassiskt social-media-format "#hashtag #yolo #swag"

```
/* Get (25 first) Tags */
GET: api/v2/tags/

/* Get Tag by id */
GET: api/v2/tags/{id}

/* Create Position (Requires Auth) */
POST: api/v2/tags
```

#####Events
Event eller "händelse" är knytpunkten, alla resurser är kopplade till denna.

En händelse består minst av en användare som skapat händelsen, och en position. En användare kan välja att även knyta händelsen till en plats och lägga till taggar till händelsen.

(I dagsläget går det endast att uppdatera kommentaren till ett event)

```
/* Get (25 first) Events */
GET: api/v2/events/

/* Get Event by id */
GET: api/v2/events/{id

/* Create Event (Requires Auth) */
POST: api/v2/events

/* Update Event (Requires Auth) */
PUT: api/v2/events/{id}

/* Delete Event (Requires Auth) */
DELETE: api/v2/events/{id}
```

Det finns ytterligare sätt att hämta händelser, baserat på användare, taggar eller att söka.
```
/* Get Events By User */
GET: api/v2/users/{id}/events

/* Get Events By Tag */
GET: api/v2/tags/{id}/events

/* Search for Events  */
GET: api/v2/events/search/{search-query}
```

Det finns även möjlighet att söka efter händelse via koordinater genom att ange position.

Det går även att ange radie för att bestämma hur långt ifrån positionen sökningen ska gå. Det anges med ett heltal i kilometer.

```

/* Get Nearby events by position */
GET: api/v2/events/nearby?lat=55.9317&lng=18.4521&radius=5
```


