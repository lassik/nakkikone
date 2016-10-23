[![Build Status](https://travis-ci.org/EntropyRy/nakkikone.svg)](https://travis-ci.org/EntropyRy/nakkikone)

# Nakkikone

Työkalu masinoida tapahtumaan tarvittavat työvuorot. Tarkoitus olisi tehdä käyttäjä ystävällinen, jottei tarvitsi korkeakoulututkintoa tämän käyttämiseen.

## Kehitysympäristön asennus

Ilman dokkeria:

1. Forkkaa ja kloonaa projekti itsellesi (lue Githubin ohjeet, jos et tiedä
   miten)
2. Asenna rvm kotihakemistoosi ```curl -L https://get.rvm.io | bash -s stable --ruby```, 
   skripti tulostaa ohjeet konfigurointiin
3. Kun rvm toimii, asenna nakkikoneen käyttämä ruby ```rvm install 2.2.5```
4. Asenna MySQL
5. Kopioi malliasetukset tietokantayhteyttä varten ```cp config/database.yml.sample config/database.yml``` ja muokkaa tarvittaessa. Kopio `.env.sample` `.env`:ksi ja muokkaa filua pitamaan salaisuudet piilossa, tama pitaa sourcettaa ajoymparistoon aina.
6. Asenna projektin käyttämät kirjastot ```bundle install```
7. Käynnistä kehityspalvelin ```rails s``` ja avaa selaimella osoite ``localhost:3000```

Dokkerin kanssa:

1. Asenna docker tyokalut (docker-compose >~ 1.6)
2. Kopio `.env.sample -> .env` ja lisaa omat salaisuudet
3. Kopio `config/database.yml.sample -> config/database.yml` ja muokkaa halutessassi
3. aja ```sudo docker-compose up --build```
4. tietokannan puutostilaan aja ```sudo docker-compose run --rm nakkikone rake db:setup```

Nyt tuotannon kaltainen kehitysympäristö tulisi olla pystyssä.

## Kontribuointi

Tee tästä projektista Githubissa oma forkki ja luo tekemääsi ominaisuutta varten oma branch. Kun koet olevasi valmis, lähetä pull request.

## Testaaminen

Olisi suotavaa että uuden toiminnallisuuden yhteydessä olisi toiminnallisuus regressio testauksen piirissä, helpottaa ihmisten ylläpitoa.

Projekti käyttää CI-ohjelmana travisia, jonka voi ja joka myös kannattaa virittää omaan forkiin käyttöön. Pitäisi onnistua helposti osoitteessa http://travis-ci.org.

Masterin travis build löytyy täältä: https://travis-ci.org/EntropyRy/nakkikone

## Deployaaminen

Nakkikone deployataan docker containerina. Bootsrappaukseen taulut ja initial datan voidaan luoda seuraavasti:

```sh
sudo docker-compose run --rm nakkikone rake db:setup
```

Muista alustaa ajo config/configurations.env:lla, joka sisaltaa applikaation salaisuudet. Katso tarkemmat tiedot docker-compose.yml.
