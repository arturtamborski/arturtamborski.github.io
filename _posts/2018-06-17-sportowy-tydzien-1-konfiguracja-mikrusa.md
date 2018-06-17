---
layout: post
title: sPortowy Tydzień 0x01 - konfiguracja mikrusa
description: panel administracyjny, ssh, slackpkg i inne
comments: true
tags:
- mikrus
---

## 1. Panel administracyjny

Pierwszym krokiem jest wybór systemu i zmiana hasła - robimy to 
[tutaj](https://mikr.us/panel/).

Ja postawiłem na slackware 14.1 x86_64 minimal.

Następnie podajemy nowe hasło roota do serwera (nie panelu!) i to w zasadzie wszystko.
Możemy jeszcze aktywować TUN/TAP i FTP ale narazie nie jest to potrzebne.


## 2. SSH

Tworzymy parę kluczy asymetrycznych u siebie, lokalnie.

	# -N "" nie pyta o passphrase (opcjonalne)

	ssh-keygen -f $HOME/.ssh/keys/mikrus -N ""


Wpisujemy serwer w konfigurację ssh pamiętając o właściwym porcie.

	# vim $HOME/.ssh/config

	Host mikrus
		HostName srv02.mikr.us
		Port 10515
		IdentityFile /home/artur/.ssh/keys/mikrus
		IdentitiesOnly yes
		User root


Wysyłamy klucz publiczny do serwera

	# przy wysyłaniu serwer powinien poprosić o hasło dla roota
	# wtedy podajemy wcześniej ustawione hasło w panelu

	ssh-copy-id -i $HOME/.ssh/keys/mikrus.pub mikrus


Logujemy się do serwera

	ssh mikrus


Dopisujemy konfigurację usługi ssh

	cat <<EOF >> /etc/ssh/sshd_config
	PubkeyAuthentication yes
	PasswordAuthentication no
	EOF

	
Restart sshd
	
	/etc/rc.d/rc.sshd restart


Otwórz nowe okno terminala i połącz się jeszcze raz by przetestować konfiugrację.
Nie zamykaj starego okna! W razie błędu zostaniesz odcięty od dostępu.

	ssh mikrus


Jeśli wszystko się udało to teraz możesz się dużo łatwiej logować na serwer.



## 3. Manager pakietów

	slackpkg update gpg
	slackpkg update

Więcej na ten temat jest [tutaj](https://docs.slackware.com/slackware:slackpkg).


## 4. Inne

Domyślnie slack ma zainstalowanego elvisa - to taki lepszy vi ale gorszy vim.
Całkiem fajny i bardzo szybki program. Niestety, nawyk sprawia, że często piszę
vim zamiast elvis co można łatwo naprawić tworząc link symboliczny.
Można tez zainstalować vim.

	ln -s /usr/bin/elvis /usr/local/bin/vim

	# można też zainstalować vima
	slackpkg install vim


Jest jescze drobny lecz denerwujący błąd z wyświetlaniem programów używających
całego ekranu terminala (takich jak vim właśnie).

	echo 'export TERM=xterm' >> ~root/.profile
