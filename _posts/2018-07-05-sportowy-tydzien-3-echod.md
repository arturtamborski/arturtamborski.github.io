---
layout: post
title: sPortowy Tydzień 0x03 - Echo
description: echo! echo...
comments: true
tags:
- mikrus
---

Minął tydzień (a właściwie trochę więcej) więc czas na kolejny port.

Tym razem jest to numer 7 a na nim usługa `echod` która została opisana w 
[RFC 862](https://tools.ietf.org/html/rfc862).

Program jest dość nudny bo standard na wiele nie pozwala ale sam kod jest 
całkiem interesujący ponieważ używa nieblokującego kodu.

Poprzednia usługa `qotdd` działała w ten sposób, że po każdym połączeniu
serwer wysyłał losowy cytat i natychmiast się rozłączał. Dzięki temu nie 
musiałem się przejmować implementacją wielu połączeń na raz bo tą robotę 
robiła za mnie kolejka systemowych połączeń.

Teraz jednak musiałem podtrzymać dowolną ilość połączeń i reagować na każde
z nich nie blokując przy tym innych. Ten problem został już rozwiązany 
w wielu bibliotekach ale ja oczywiście zabrałem się za to od najniższego 
poziomu robiąc wszystko po swojemu.


Na początku użyłem `fork()`a który działa bardzo fajnie pod linuxem.
Niestety dość znacząco komplikował sprawę w przypadku wielu połączeń bo
musiałbym tworzyć nowy proces dla każdego połączenia, co byłoby dość 
głupim pomysłem. Teoretycznie można użyć coś w rodzaju procpoola 
i kolejek ale to z kolei wymaga komunikacji IPC co jeszcze bardziej 
komplikuje sprawę. Wątki wpadają w tą samą kategorię.

Można też użyć nieblokujących socketów i w kółko odpytywać system czy wreszcie
coś się stało. To podejście jest dość dobre ale wymaga drobnej modyfikacji
by nie meczyć procesora na najwyższych obrotach.

Zamiast ciągle odpytywać system skorzystałem z funkcji `select()` która
niejako odwraca role. Dzięki temu to system sam mi powie kiedy coś się stanie
i dopiero wtedy program coś zrobi :)


Niestety, sama funkcja `select()` wygląda na zapomnianą przez świat.
Korzystałem głównie z książki [Beej's Guide to Network Programming](https://beej.us/guide/bgnet/), `man 2 select` i `man 2 select_tut`.

Nie będę się tu rozpisywał bo kod jest prosty i krótki.
Jest też całkiem czytelny porównując z tym, co można znaleść
we wspomnianej książce (która jest świetna swoją drogą, serio).

Podsumowując - program działa szybko i fajnie ale nie robi nic ciekawego.
Za tydzień wezmę się za coś lepszego.

[Link do kodu](https://github.com/arturtamborski/c-playground/tree/master/echod/) i [link postu na mikrusie](http://uw515.mirk.us/posts/echod.html).
