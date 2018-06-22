---
layout: post
title: sPortowy Tydzień 0x03 - Quote Of The Day
description: The simplest of them all
comments: true
tags:
- mikrus
---

Zacznę powoli od prostych i starych protokołów.
Jednym z takich jest właśnie Quote Of The Day znany również pod nazwą
[RFC865](https://tools.ietf.org/html/rfc865) który według 
[wikipedii](https://en.wikipedia.org/wiki/QOTD)
ma zapewniać niekończący się strumień mądrości prosto z portu numer 17.


Tak właściwie, to nie wiem dlaczego powstał specjalny protokół i własny port 
dla tak banalnej usługi ale nie jest to teraz istotne bo i tak nikt tego
nie używa.


Co ciekawe nie mogłem nawet znaleść oficjalnej paczki w repozytoriach debiana
i slackware dla tego protokołu. W zasadzie jedyne co znalazłem to pozostałości
po usłudze zwanej `simptcp` [o, tutaj](http://www.securityspace.com/smysecure/catid.html?id=10198).


Znalazłem też dwa nadal działające serwery które udostępniają tą funkcjonalność
[źródło](https://gkbrk.com/wiki/qotd_protocol/).


No tak, ale to już było a ja chcę się zająć implementacją tej usługi dla siebie.
Oczywiste rozwiązanie to internetowy kotek - `nc` i `fortune`.
Dzięki nim możemy bez problemu i w najłatwiejszy możliwy sposób zaimplementować
ten protokół u siebie.


	nc -l -p 17 -e /usr/games/fortune


Ale to by było zbyt proste :) Poza tym taka komenda to dość samobójcze podejście
do problemu, ponieważ port 17 (a dokładniej każdy port < 1024) może obsługiwać
tylko root co raczej nie jest bezpieczne. Co prawda nie ma pewnie żadnego 
exploitu na fortune ale i tak lepiej tego nie robić w ten sposób.


Poza tym to świetna okazja na odświerzenie wiedzy na temat linuxowych socketów
i biblioteki do obsługi połączeń TCP.


Dlatego też napisałem własną, prostą wersję takiego programu - 
[qotd](https://github.com/arturtamborski/c-playground/qotd).


Nie jest to nic specjalnego, ale działa całkiem fajnie.
Program w pewnym sensie działa jak proste proxy dla aplikacji fortune ale 
nie naraża systemu bo zrzuca uprawnienia zaraz po zajęciu portu.
