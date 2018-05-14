<h2>Projekt na zaliczenie NoSQL</h2>
<hr>
<h3>Dane wykorzystane podczas projektu:</h3>
[Police Department Incidents](https://data.sfgov.org/Public-Safety/-Change-Notice-Police-Department-Incidents/tmnf-yvry).

Baza danych składa się z 2,21 mln wierszy i 13 kolumn. Poniżej przedstawiono kolumny:

|  # | Nazwa kolumny |
|:--:|:-------------:|
|  1 |   IncidntNum  |
|  2 |    Category   |
|  3 |    Descript   |
|  4 |   DayOfWeek   |
|  5 |      Date     |
|  6 |      Time     |
|  7 |   PdDistrict  |
|  8 |   Resolution  |
|  9 |    Address    |
| 10 |       X       |
| 11 |       Y       |
| 12 |    Location   |
| 13 |      PdId     |

<hr>

<h3>Opis</h3>

1. Konwersja bazy danych z csv na json
```
$ csvtojson source.csv > converted.json
```
2. Redukcja wierszy bazy danych do 20 000 za pomocą komendy split. Baza danych po redukcji znadjuje się w folderze [data](https://github.com/zyng/zalnosql/tree/master/data).
3. ReplicaSet
```
mkdir carbon
cd carbon
mkdir 1,2,3

mongod --port 27001 --replSet carbon --dbpath 1 --bind_ip localhost --oplogSize 128 
mongod --port 27002 --replSet carbon --dbpath 2 --bind_ip localhost --oplogSize 128
mongod --port 27003 --replSet carbon --dbpath 3 --bind_ip localhost --oplogSize 128

mongo --host localhost:27001

rsconf = {
  _id: "carbon",
  members: [
    { _id: 0, host: "localhost:27001" },
    { _id: 1, host: "localhost:27002" },
    { _id: 2, host: "localhost:27003" }
   ]
}

rs.initiate(rsconf)
```
4. Zaimportowanie do ReplicaSet [bazy](https://github.com/zyng/zalnosql/tree/master/data).
```
mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 --db test --collection incidents --file incidents.json --drop
```
5. W celu upewnienia się czy połączenie z bazą danych przebiegło prawidłowo. W tym celu korzystamy z polecenia rspec.

<hr>
<h3>Skrypty</h3>

Skrypt generuje [plik html](https://github.com/zyng/zalnosql/blob/master/bin/descript_list.html), w którym tworzy się tabelka pokazująca ilość wystąpień dla poszczególnych incydentów.

```
ruby script1.rb -l 20
```
W przypadku niepodania parametru -l domyślną wartością będzie 10.

|              Nazwa incydentu              | Ilość wystąpień |
|:-----------------------------------------:|:---------------:|
| DRIVERS LICENSE, SUSPENDED OR REVOKED     |       971       |
| GRAND THEFT FROM LOCKED AUTO              |       840       |
| AIDED CASE, MENTAL DISTURBED              |       721       |
| PETTY THEFT FROM LOCKED AUTO              |       677       |
| STOLEN AUTOMOBILE                         |       668       |
| WARRANT ARREST                            |       659       |
| BATTERY                                   |       595       |
| FOUND PROPERTY                            |       441       |
| SUSPICIOUS OCCURRENCE                     |       400       |
| LOST PROPERTY                             |       368       |
| MALICIOUS MISCHIEF, VANDALISM OF VEHICLES |       364       |
| INVESTIGATIVE DETENTION                   |       345       |
| PETTY THEFT SHOPLIFTING                   |       336       |
| FOUND PERSON                              |       333       |
| ENROUTE TO OUTSIDE JURISDICTION           |       325       |
| PETTY THEFT FROM A BUILDING               |       304       |
| THREATS AGAINST LIFE                      |       276       |
| TRAFFIC VIOLATION ARREST                  |       253       |
| GRAND THEFT FROM PERSON                   |       239       |
| RESISTING ARREST                          |       239       |
