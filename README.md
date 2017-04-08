[![Build Status](https://travis-ci.org/EntropyRy/nakkikone.svg)](https://travis-ci.org/EntropyRy/nakkikone)

# Nakkikone

Työkalu masinoida tapahtumaan tarvittavat työvuorot. Koostuu käyttäjille näytettävästä varaus taulukosta ja admineille juhlien muokkaus ja hallinnointi työkalut.

## Kehitysympäristön asennus

Kehitysympäristö ja tuotantoympäristö ovat kovin lähellä toisiaan dockerin ansiosta.

### Dokkerin kanssa

HUOM: tee nama ohjeet ajatuksen kanssa.

0. Asenna docker tyokalut (docker-compose >~ 1.6 ja docker) sekä konfiguroi käyttöoikeudet kuntoon (lue Dockerin ohjeet)
1. Varmista etta reposi on 'puhdas', dockerin 'hienouksia' on se etta voit halutessasi mountata tyohakemiston kontaineriin sisalle (kts [AUFS filesystem](https://docs.docker.com/engine/userguide/storagedriver/aufs-driver/)).
2. Aja kehitysympäristön alustus skripti ```./initialize-development-environment.sh```
3. Buildaa ensimmainen nakkikone & db docker containers ```docker-compose build```
4. Aaja tietokanta docker ylos ```docker-compose up db```
5. Mankeloi tuotannon tietokanta railsilla kuntoon ```docker-compose run --rm nakkikone rake db:setup```.
7. Sammuta db container.

Nyt tuotannon kaltainen kehitysympäristö tulisi olla pystyssä. Jos näet että Nakkikone käynnistyy ennen tietokantaa, aja alas (ctrl-c) ja käynnistä uudelleen ```docker-compose up``` (tiedetty ongelma).

Kun haluat devata lokaalisti kayta `development` ymparistoa ja mountaa host directory `docker-compose.yml`:stä (käytä kontti myös alhaalla). Kun haluat kokeilla tuotantoa vastaavaa, vaihda ymparisto `production` ja buildaa kontti uudelleen ```docker-compose up --build```. Jos homma rokkaa voi kontin laittaa ajoon tuotanto pannulle (eli meidan tapauksessa kayda kaantamassa se siella).

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

Nakkikone deployataan docker containerina. Jos olet pystyttamassa uutta ymparistoa seuraa kehitysympariston ohjeita.

Jos olet paivittamassa vanhaa, tulee sinun vain ladata uusimmat sorsat githubista, buildata docker compose uudestaan ja restartata setti.

1. ```docker-compose down```
2. ```git pull```
3. ```docker-compose build```
4. ```docker-compose up```

Jos koko paske meni levyksi, vanhat datat voi dumpata kun docker db initialisoidaan laittamalla scriptit ```./db/docker/``` kansioon. HUOMIO: Älä koskaan version hallinnoi mitään näistä dumpeista, ne ovat ihmisten henkilökohtaista dataa.
