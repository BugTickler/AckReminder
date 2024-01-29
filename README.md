# AckReminder
Skrypt powiadamia jeżeli są otwarte alerty bez ACK przez minimum 2 minuty (dźwięk jest odtwarzany co 10 sekund) oraz alerty HOD ponad 30 minut. W przypadku alertów z systemu HOD dźwięk jest odtwarzany tylko jeden raz. Jeżeli alert HOD zmieni priorytet dźwięk będzie odtworzony ponownie.

1) Pobierz wszystkie pliki.
2) Wprowadź klucz API w linii 3 (KeePass) oraz Team ID (Opsgenie)
4) Uruchom AckReminder.bat lub uruchom z Terminala (powershell.exe -ExecutionPolicy Bypass -File ".\AckReminder.ps1")


* W linii 47 można zmienić czas po jakim skrypt ma nas powiadamiać. Wystarczy zmienić liczbę minut na końcu.
      ![image](https://github.com/CMRLD/AckReminder/assets/145223486/0a402676-866b-4e35-b4be-b19556b08c1a)
* W linii 53 można zmienić czas po jakim skrypt ma nas powiadamiać w przypadku alertów z systemu HOD.
      ![image](https://github.com/CMRLD/AckReminder/assets/145223486/af34a745-8bd2-4b55-8d8f-fca5ef4ba2d1)
* W linii 55 można zmienić ścieżkę do pliku dla alertów HOD, a w linii 62 dla reszty alertów.
      ![image](https://github.com/CMRLD/AckReminder/assets/145223486/08e7586b-89d8-4a80-ba3e-52b8c506a0d2)



     
Potencjalne problemy:
1) Skrypt od razu wyrzuca warning że alert jest otwarty przez ponad 2 minuty bez ACK.
     - Sprawdź czas systemowy i ustaw właściwy. Skrypt porównuje datę z Opsgenie z czasem systemowym, jeżeli czas jest rozjechany to od razu mu wychodzi ze czas został przekroczony.
