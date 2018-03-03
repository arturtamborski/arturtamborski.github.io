---
layout: post
title: Historia nieudanego startu pierwszej wersji bloga
description: czyli sprawdź, czy faktycznie działa zanim się pochwalisz ;)
author: artur
comments: on
tags:
  - django
  - blog
---

Cześć, dzisiaj opiszę mój falstart z pierwszej wersji bloga, ale najpierw lekcja - 
"Nie chwal się startem bez wcześniejszego deploymentu na właściwej platformie,
 bo nigdy nie wiesz, co pójdzie nie tak".


A więc tak... chciałem wystartować pierwszego stycznia korzystając z fali postanowień, 
mając nadzieję, że przeniesienie aplikacji z localhosta na serwer będzie łatwa szybka i przyjemna.
I tu wszystko się trzasło, bo nawaliło praktycznie wszystko, co mogło (głównie przez moją nieuwagę).

Na początku baza danych - na localhoscie miałem tylko bazę danych `SQLite3` 
bo jest wygodna w użyciu i mogę ją szybko usunąć bez większych komplikacji. 
Niestety nie wpadłem na pomysł, by przetestować te bardziej zaawansowane bazy danych 
przez co późniejsze postawienie `MySQL` na szybko odpłaciło mi się godzinką 
zmarnowanego czasu i przeniesieniem wszystkiego na PostgreSQL.

Taki protip na przyszłość - `MySQL` domyślnie nie obsługuje `UTF-8`, dlatego zamiast 
przerabiać bazę danych i aplikację po prostu uciekłem do konkurencji.


Następnie nawalił `nginx` - a właściwie moje pisane na szybko configi które 
zawierały kilka prostych literówek... Kilkadziesiąt minut w plecy, ale przynajmniej 
nauczyłem się nowej komendy - `nginx -t` sprawdza poprawność skryptów ;)


Potem na szybko konfiguracja `firewall`a, i mam już statyczne stronki! więc czas 
na ustawieniu środowiska - cały wieczór spędziłem na męczeńskiej konfiguracji 
`virtualenv`'a pythona i zgraniu tego z `uwsgi`. Kilka rzeczy zrobiłem źle, 
np. zainstalowałem nie te wersje pakietów co trzeba (pip a pip3) i korzystałem z 
nie tego pythona którego chciałem chciałem (remember kids, 2.x is legacy, 3.x is the future)
ale to pewnie przez późne godziny pracy.


Ostatecznie się udało, więc na fali nowej energii ściągnąłem moją webappkę pisaną na 
kolanie w dwa dni - szybki `tar`, `scp` i mam wszystko tak jak chciałem, ale tylko 
na pythonowym serwerze do testów, którego nie mogłem przecież tak zostawić, więc 
wziąłem się za konfigurację `uwsgi` i `nginx`, które mnie pokonało.


Nastała mroczna pora - `nginx` działał, ale nie z `uwsgi`. `uwsgi` działał ale nie z `nginx`.
A ja miałem już coraz więcej wątpliwości w swoje umiejętności, więc zostawiłem to w cholerę 
i poszedłem spać, ale nie mogąc pogodzić się z porażką całą noc myślałem o tym, 
gdzie popełniłem błąd. Po przerobieniu możliwie każdego scenariusza doszedłem do wniosku, 
że potknąłem się na czymś zbyt oczywistym, bym to zauważył za pierwszym razem - uprawnienia.


Szybki login przez `ssh`, jeszcze szybszy `ls -la` do wyświetlenia uprawnień i największy 
facepalm w życiu - plik `.socket` miał złego właściciela. Naprawiłem jedną komendą 
swoją głupotę i odetchnąłem z ulgą, wszystko działa tak, jakbym tego chciał.

Wiem wiem, przejechałem się na własnej głupocie nie czytając logów i chaotycznie 
googlając złotego rozwiązania, ale przynajmniej nauczyłem się kilku rzeczy, 
więc chyba było warto, prawda?
