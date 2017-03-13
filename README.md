[![Build Status](https://travis-ci.org/EntropyRy/nakkikone.svg)](https://travis-ci.org/EntropyRy/nakkikone)

# Nakkikone

Työkalu masinoida tapahtumaan tarvittavat työvuorot. Koostuu käyttäjille näytettävästä varaus taulukosta ja admineille juhlien muokkaus ja hallinnointi työkalut.

## Kehitysympäristön asennus

### Dokkerin kanssa

1. Asenna docker tyokalut (docker-compose >~ 1.6 ja docker) sekä konfiguroi käyttöoikeudet kuntoon (lue Dockerin ohjeet)
2. Aja kehitysympäristön alustus skripti ```./initialize-development-environment.sh```
3. Buildaa ensimmainen nakkikone & db docker containers ```docker-compose build```
4. Tietokannan puutostilaan aja ylos tietokanta docker ```docker-compose up db``` ja mankeloi tietokanta railsilla kuntoon ```docker-compose run --rm nakkikone rake db:setup```. Sammuta sen jälkeen db container.

Nyt tuotannon kaltainen kehitysympäristö tulisi olla pystyssä. Jos näet että Nakkikone käynnistyy ennen tietokantaa, aja alas (ctrl-c) ja käynnistä uudelleen ```docker-compose up``` (tiedetty ongelma).

### Ilman dokkeria

*DEPREKOITU TAPA, KÄYTÄ DOCKERIA.*

1. Forkkaa ja kloonaa projekti itsellesi (lue Githubin ohjeet, jos et tiedä
   miten)
2. Asenna rvm kotihakemistoosi ```curl -L https://get.rvm.io | bash -s stable --ruby```, 
   skripti tulostaa ohjeet konfigurointiin
3. Kun rvm toimii, asenna nakkikoneen käyttämä ruby ```rvm install 2.2.5```
4. Asenna MySQL
5. Kopioi malliasetukset tietokantayhteyttä varten ```cp config/database.yml.sample config/database.yml``` ja muokkaa tarvittaessa. Kopio `.env.sample` `.env`:ksi ja muokkaa filua pitamaan salaisuudet piilossa, tama pitaa sourcettaa ajoymparistoon aina.
6. Asenna projektin käyttämät kirjastot ```bundle install```
7. Lataa submoduulit ```git submodule init && git submodule update```
8. Käynnistä kehityspalvelin ```rails s``` ja avaa selaimella osoite ``localhost:3000```

## Kontribuointi

Tee tästä projektista Githubissa oma forkki ja luo tekemääsi ominaisuutta varten oma branch. Kun koet olevasi valmis, lähetä pull request.

## Testaaminen

Olisi suotavaa että uuden toiminnallisuuden yhteydessä olisi toiminnallisuus regressio testauksen piirissä, helpottaa ihmisten ylläpitoa.

Projekti käyttää CI-ohjelmana travisia, jonka voi ja joka myös kannattaa virittää omaan forkiin käyttöön. Pitäisi onnistua helposti osoitteessa http://travis-ci.org.

Masterin travis build löytyy täältä: https://travis-ci.org/EntropyRy/nakkikone

## Deployaaminen

Nakkikone deployataan docker containerina. Aja initialisointi ja muokkaa konfigurointi salaisuudet kuntoon.

Pystyta applikaatio docker-composella,

```
sudo docker-compose up --build
```

Kaynnistyksen jalkeen bootsrappaukseen taulut ja initial datan voidaan luoda seuraavasti:

```sh
sudo docker-compose run --rm nakkikone rake db:setup
```

Tai upgradettaessa vanhasta, konffaa composen mysql volume joka sisaltaa dumpattavan sisallon.

```
volumes:
    - ./docker/data:/docker-entrypoint-initdb.d
```
