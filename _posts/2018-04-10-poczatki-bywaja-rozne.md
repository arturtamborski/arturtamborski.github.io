---
layout: post
title: Początki bywają różne
description: Kilka słów o tym, jak zacząłem przygodę z programowaniem.
comments: true
tags:
- blog
---

Niedawno czyściłem stare dyski i trafiłem na moje pierwsze nieśmiałe próby programowania z wakacji 2013r,
co z kolei zachęciło mnie do dalszych poszukiwań tego jak to wszystko się u mnie zaczęło.


Niestety, mimo odzyskiwania danych i zdjęć niewiele znalazłem a to dlatego, że zdecydowaną większość 
starego kodu usunąłem sądząc (słusznie zresztą), że jest tragiczny i nie warty zachowania. 
To samo zrobiłem ze zdjęciami, których jednak trochę mi szkoda, bo to zawsze jakaś pamiątka 
z pierwszych działających projektów.


Jedyne, co udało mi się wykopać to kilka zdjęć z forum i kod z emaili - nie jest to nic wartego uwagi,
ale fajnie było zobaczyć te straszne karykatury funkcji i programów.
Choć z drugiej strony, może trochę przesadzam... W końcu każdy kiedyś zaczyczynał ;)


No właśnie, a jak ja zacząłem? Z obecnego punktu widzenia mogę powiedzieć, że wybrałem dość trudną
drogę na początek programowania - mikrokontrolery ośmiobitowe.


Przyczyn było kilka:
  - ambicje -  bardzo chciałem zacząć "blisko sprzętu" inspirując się początkami kultury hakerów i phreakerów z lat 80tych i 90tych.
  - języki skryptowe wydawały mi się za łatwe i nudne, co z dzisiejszego punktu widzenia jest oczywiście bardzo głupie i naiwne.
  - zainteresowanie elektroniką - od zawsze rozbierałem zdalnie sterowane zabawki sprawdzając 
co mają w środku. Miałem też karton silniczków DC, kabli i diod LED. 
Pamiętam też bardzo ciekawy drobiazg - często zastanawiałem się, czy istnieje coś takiego jak 
przełącznik sterowany prądem ale nie zorientowałem się, że takie coś to właśnie tranzystor 
będący największym wynalazkiem ubiegłego wieku ;)
  - nowy laptop - tak! Może to brzmi śmiesznie, bo któż z nas nie prosił o komputer "do nauki" ale w tym przypadku był to najważniejszy element całej układanki, bo mogłem spędzić dużo więcej czasu eksperymentując
z kodem i elektroniką często do późnego wieczora. No i komputer kusił grami a mój wierny thinkpad X31
już wtedy był dość stary jak na swoje czasy więc o grach mogłem zapomnieć.
  - linux - tak, linux! Oryginalny windows XP na wspomnianym laptopie był strasznie wolny,
co mnie niesamowicie denerwowało więc po kilku dniach przerzuciłem się na linuxa właśnie
zachęcony obietnicą wydajności i małego zużycia pamięci.
Obietnica się sprawdziła a ja już nigdy nie musiałem narzekać na wydajność mimo starego procesora.
Miałem potem jeszcze kilka problemów z Javą i Eclipsem (IDE) ale szybko wyrzuciłem to przez
okno i nauczyłem się obsługi VIM'a który swoją drogą jest niesamowitym programem.
  - Mirosław Kardaś - osoba, dzięki której mimo wielu, wielu porażek nie porzuciłem dalszej nauki. 
Autor wspaniałej książki "Mikrokontrolery AVR, Język C Podstawy Programowania" która stanowiła 
podstawę i główne źródło wiedzy. Jest on również twórcą niezliczonych poradników wysokiej 
jakości o wszystkim, co jest związane z mikrokontrolerami AVR oraz wszelakiego oprogramowania
ułatwiającego pracę z elektroniką i ośmiobitowcami.


Pierwszy program to oczywiście klasyczne "hello world" ale w wydaniu mikroprocesorowym czyli 
miganie diodką LED co sekundę napisany w języku BASCOM AVR będący przerobioną wersją języka Pascal i BASIC dla mikrokontrolerów firmy ATMEL pod nazwą AVR. Bardzo szybko przerzuciłem się na coś innego, 
bo ten język jak i całe środowisko było bardzo ograniczone i nie mogłem znaleść dobrego źródła do nauki.

Więc mój pierwszy faktyczny program to miganie diodą ale w języku C dla mikrokontrolera ATmega8 
o szalonych parametrach - 8 KB pamięci flash, 2 KB RAMu i dwa timery z czego jeden z nich 
mający 16 bitową dokładność! Niesamowity sprzęt który już wtedy był bardzo słaby ale wtedy 
w zupełności wystarczał.


Oto kod, który migał taką diodą:
```c
#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	DDRC = 0xff;

	while(1)
	{
		PORTC ^= 0xff;
		_delay_ms(100);
	}
}
```

Te kilka linijek to coś niesamowitego. Może nie robiło to takiego wrażenia jak dzisiejsze "hello world",
ale wtedy po wielu dniach oczekiwania na zamówioną elektronikę, kilka godzin zmagań z programatorem 
i błędem `rc = -1` programu avrdude i wreszcie udanym uruchomieniem był niezapomniany.


I mimo dość trudnego środowiska dla totalnego amatora udało mi się po kilku tygodniach czy nawet miesiącach stworzyć kilka programów wykorzystujących serię przycisków, diod, timerów czy nawet wyświetlacza LCD 4x16 (taki, jak w kasach fiskalnych wyświetlający klientowi nazwę i koszt produktu).
Praktycznie każdy z tych projektów opierał się na bluebooku czyli niebieskiej książce 
Pana Mirosława Kardasia.


Ostatecznie mikrokontrolery nauczyły mnie bardzo dużo o procesorze, pamięci, stosie, i tak dalej 
lecz stały się one niewystarczające a ja skierowałem swoją uwagę w kierunku programów komputerowych 
i języka C++ na podstawie kursów kolejnego świetnego nauczyciela - Mirosława Zelenta.

Oto fragment jednego z moich pierwszych programów napisany w C++:
```cpp
void read_table( int _table )
{
  fstream plik;
  string linia;
  int i;

  //wybrane okno do odczytu i początek tego okna w pliku .txt
  if(_table == 1) line = 0;  else
  if(_table == 2) line = 1137; else
  if(_table > 2 || _table < 1) cout << "nie znaleziono okna";

  plik.open(DIRECTORY_TABLE, ios::in); //otwórz plik z tabelą
  plik.seekg(line, ios::beg); //przesunięcie kursora do odczytu
  for(i = 0; i <= 22 && getline(plik, linia); i++) table[i] = linia;
  plik.close();


  plik.open(DIRECTORY_SCORE, ios::in); //otwórz plik z top_score
//  getline(plik, linia); top_score_file = atoi(linia, c_str());
  plik >> top_score_file;
  top_score_game = top_score_file;
  plik.close();
}
```

Tragedia. Nie będę nawet wymieniał, co tu jest źle, bo niewiele to zmieni ale ten kod
jak i większość tego, co napisałem nadaje się tylko do wyrzucenia.
Jedyne, co mogę sobie przyznać, to to, że ~300 linii takiego kodu faktycznie działało.


Znalazłem jeszcze jeden bardzo ciekawy fragment z obiektowego C++:
```cpp
//╔═════════════════════════════════════════════════════════════════
//║Budowa: void open( void )
//║Opis:   Tworzy dwie podstawowe tablice, i otwiera potrzebne pliki
//║Uwagi:  brak
//╚═════════════════════════════════════════════════════════════════
void Convert::open( void )
{ bmp = new FileBMP(path_bmp.c_str());

  x_last = ((bmp->getWidth()  - 2) / (scale + 1));
  y_last = ((bmp->getHeight() - 2) / (scale + 1));
  // ...
```


Ta linijka kodu wchodząca na klamrę otwierającą jest definicją okropnego stylu a mimo tego ja pisałem
tak cały kod. I tak, ten program też działał choć jeszcze bardziej nie powinien.


I tak powoli zgłębiałem kolejne tajniki programowania. Często wpadałem w pułapki wiecznej nauki 
gdzie zamiast pisać programy czytałem książki o pisaniu programów. Miałem też sporo problemów z
imposter syndrome którego ostatecznie nadal nie pokonałem ale już nie podchodzę tak krytycznie
do własnego kodu.


Podsumowując:
  - Początki bywają różne,
  - Pierwszy kod jest okropny,
  - Warto mieć dobrego nauczyciela,
  - I nie zaczynać od trudnych rzeczy.
