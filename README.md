
FlightGear Logbook Add-on
==========================

# =============== EN ===============

This add-on automatically keeps a log of your flights, saving each flight to a CSV file. It does not require any interference, just add an add-on to FlightGear.

## Installation

Installation is standard:

1. Download "Logbook" add-on and unzip it.
2. In Launcher go to "Add-ons" tab. Click "Add" button by "Add-on Module folders" section and select folder with unzipped "Logbook" add-on directory (or add command line option: `--addon=path`), and click "Fly!".

## How it's working?

The add-on tries to automatically detect if an aircraft has taken off by checking the Weight of Wheels. Then the add-on starts collecting information about the flight. This means that if you are parked, taxiing, etc., it is not yet included in the flight log. If you are in the air, the add-on tries to detect if you have landed also by testing Weight of Wheels. Thus, logging takes place from the moment the aircraft is lifted off the ground until it is put back on the ground.

If the aircraft has no wheels, only the floats, then the add-on will also try to recognize if the floats are resisting the water (if the aircraft uses JSBSim), thus recognizing whether you are in the air or not.

The add-on also recognizes the moment of launch of the Space Shuttle from the starting position, which required a separate consideration due to the different launch.

## Logbook file

You will find the CSV file in the directory `$FG_HOME/Export/Addons/org.flightgear.addons.logbook/logbook-v1.0.1.csv`, where `$FG_HOME` on Windows is:

`C:\Users\{user name}\AppData\Roaming\flightgear.org\`

and on Linux/MacOS:

`/home/{user name}/.fgfs/`

You can always open it and edit by any Spreadsheet program like LibreOffice Calc, MS Excel, etc. However please don't put the characters `,` in the cells, because the Logbook parser will recognize them as a column separator, which will cause errors in the operation of the add-on. It is safer to edit the log data through the GUI in the simulator.

## Logbook file structure

The following information is logged into the file:

1. **Date** – aircraft take-off date. This is the date taken from your OS, not the date in the simulator. I decided I'd know when I flew in my own time zone, in front of my own computer, rather than what the UTC or local time was in the simulation, which would not be valuable. If you have a different opinion and reasonable arguments, let me know.
2. **Time** – aircraft take-off time. As for **Date** this is the time taken from the OS.
3. **Aircraft** – the code name of the aircraft.
4. **Callsign** – your callsign set for multiplayer.
5. **From** – the ICAO code of the airport from which you have taken off. If you are starting immediately in the air, this field will remain blank.
6. **To** – the ICAO code of the airport where you landed. If you did not land (e.g. by closing FG in flight) or by landing at an adventurous location, this field will remain blank.
7. **Landings** – number of landings made. If you landed anywhere, a 1 will be entered here. If the flight ended without landing or the add-on was unable to detect a valid landing, a 0 will be entered here.
8. **Day** – the number of hours spent flying during the day.
9. **Night** – number of hours spent flying during the night.
10. **Instrument** – the number of hours flown during the IMC (Instrument Meteorological Conditions).
11. **Duration** – total duration of the flight in hours, as the sum of **Day** and **Night**. The instrument is not added up here, as it is simply counted separately, regardless of whether it was day or night.
12. **Distance** – total distance flown from take-off to landing, in nautical miles.
13. **Fuel** – total fuel burned, in US gallons.
14. **Max Alt** – maximum altitude, in feet, reached during flight.
15. **Note** – notes, by default the full name of the aircraft.

## Viewing the logbook

The add-on also provides the ability to view the entire flight logbook from the simulator. You should select "Logbook" -> "Logbook" from the menu. The main window will open with the entire logbook in tabular form. The last row signed "Totals", contains a summary, not only of the visible entries on a given page, but of the entire logbook. The same "Totals" row is visible on every page.

At the very bottom we have a row of buttons, mainly for moving through the log pages. The `|<<` button means moving to the first page, `<` moving to the previous page, `>` moving to the next page, `>>|` moving to the last page. In the middle we have text information in the format `{on which page we are} / {number of all pages} (number of entries in the log)`. On the right we have a `dark`/`light` button to switch between window styles. The `?` button opens a window with help (the same as from the "Logbook" -> "Help" menu).

Each log entry can be hovered over and clicked. Then an additional window will open presenting the details of the given entry. In general, we have the same information here as in the main window, except:

1. ICAO airport codes include their names in parentheses.
2. With numerical data, we have given the units in which these values are presented.
3. At the very bottom we have an additional `Note` field, which is not displayed in the main window, due to the possibility of placing any length of text here.

## Editing and deleting data

Each logbook entry can be edited from the simulator. You need to select "Logbook" -> "Logbook" from the menu. The main window with the entire logbook will open. Here you can search for the entry you want to edit and click on it. The details window for the entry will open. Now you can click on the specific entry you want to edit. Another window with a text field will open. Just enter the new value and confirm with the "Save" button. The change will immediately be saved to a file.

At the bottom of the details window there is a `Delete` button, with which you can completely delete the selected entry.

### Backup

Before each saving of a single change, the add-on creates a copy of the original CSV file, to which it appends the `.bak` extension at the end. So, if something goes wrong while editing the data and the original file is corrupted, you can always recover it by removing the `.bak` from the copy name.

## NOTE

1. If you properly close the simulator during the flight ("File" -> "Exit"), the current flight status will be saved to the logbook (without landing information, of course).
2. If the simulator will be closed incorrectly during flight, e.g. via the [X] button on the window bar, or a crash occurs, the flight status will lost.
3. For the add-on to count as a landing, the aircraft must rest on all wheels and maintain this state for at least 3 seconds. In this way, an ugly bounce off the runway will not be counted as a landing.
4. If you start a simulation in the air, the add-on will recognize this and start logging without waiting for take-off.
5. If you start a simulation in the air, the add-on is unable to recognize the landing gear, so the landing pass will extend to 6 seconds (giving an extra 3 seconds to make sure the aircraft is resting on all wheels).
6. Helicopters should also be supported, although I have not tested all of them.
7. The add-on supports JSBSim-based watercraft, although I have not tested all of them.
8. The add-on supports the Space Shuttle.
9. Flights with UFO will not be logged.
10. Pausing the simulation or turning on the replay mode stops the flight statistics from being added to the log.
11. As for fuel burn, the add-on does not take into account the change in the amount of fuel during the flight. When you change the amount of fuel during the flight, the result in the **Fuel** column will be incorrect. So try to avoid it and refuel the aircraft before the flight.
12. Supported FG versions from 2020.1.
13. A CSV file with more than 100,000 entries will take much longer to load. On my powerful hardware about 2-3 seconds. This file is always loaded when the add-on loads. Thus, large files will cause a temporary but noticeable stuttering of the entire simulator. I'm considering moving the loading to a separate thread, as long as I also get good stability of this solution.

## Authors

- Roman "PlayeRom" Ludwicki

## License

Logbook is an Open Source project and it is licensed under the GNU Public License v3 (GPLv3).

# =============== PL ===============

Dodatek ten automatycznie prowadzi dziennik naszych lotów, zapisując każdy odbyty lot do pliku CSV. Nie wymaga to żadnej ingerencji, wystarczy dodać wtyczkę do FlightGeara.

## Instalacja

Instalacja jest standardowa:

1. Pobierz dodatek z repozytorim i rozpokauj go do dowolnego katalogu.
2. W Laucherze przejdź do zakładki „Dodatki”. Kliknij przycisk „Dodaj” w sekcji „Katalogi dodatkowych modułów” i wybierz folder z rozpakowanym katalogiem dodatku „Logbook” (lub dodaj opcję wiersza poleceń: `--addon=ścieżka`) i kliknij „Lećmy!”.

## Jak to działa?

Dodatek stara się automatycznie wykryć czy statek powietrzny wystartował, poprzez sprawdzenie Weight of Wheels. Wtedy dodatek rozpoczyna zbieranie informacji o locie. Oznacza to, że jeśli stoimy zaparkowani, kołujemy itp. to jeszcze nie jest wliczane do dziennika lotów. Jeśli jesteśmy w powietrzu, to dodatek stara się wykryć czy wylądowaliśmy także testując Weight of Wheels. Zatem logowanie następuje od chwili oderwania statku powietrznego od ziemi, do posadzenia go na ziemi z powrotem.

Jeśli samolot nie ma kół tylko pływaki, to dodatek także postara się rozpoznać, czy pływaki stawiają opór wodzie (o ile samolot wykorzystuje JSBSim), tym samym rozpoznając czy jesteśmy w powietrzu czy nie.

Dodatek rozpoznaje także moment startu Wahadłowca Kosmicznego z pozycji startowej, co wymagało osobnego uwzględnienia, ze względu na odmienność startu.

## Plik logbooka

Plik CSV znajdziesz w katalogu `$FG_HOME/Export/Addons/org.flightgear.addons.logbook/logbook-v1.0.1.csv`, gdzie `$FG_HOME` pod Windows to:

`C:\Users\{user name}\AppData\Roaming\flightgear.org\`

pod Linuxem/MacOS-em:

`/home/{user name}/.fgfs/`

Zawsze możesz otworzyć ten plik w dowolnym programie typu arkusz kalkulacyjny, jak LibreOffice Calc, MS Excel itp. Proszę jednak nie umieszczać tam w komórce znaków `,`, ponieważ parser Logbooka rozpozna przecinki jako separator kolumn, co spowoduje błędy w działaniu dodatku. Bezpieczniej jest edytować dane w dzienniku poprzez GUI w symulatorze.

## Struktura pliku logbooka

Do pliku logowane są następujące informacje:

1. **Date** – data startu statku powietrznego. Jest to data pobierana z twojego systemu operacyjnego, a nie data w symulatorze. Uznałem, że wolę wiedzieć, kiedy odbyłem lot we własnej strefie czasowej, przed własnym komputerem, niż to jaki był czas UTC czy lokalny w symulacji, co wg mnie było by mało wartościową informacją. Jeśli masz inne zdanie i sensowne argumenty, daj mi znać.
2. **Time** ‒ czas startu statku powietrznego. Podobnie jak dla **Date** jest to czas pobrany z systemu operacyjnego.
3. **Aircraft** ‒ nazwa kodowa statku powietrznego.
4. **Callsign** ‒ Twój callsign ustawiony dla multiplayer.
5. **From** ‒ kod ICAO lotniska, z którego wystartowałeś. Jeśli startujesz od razu w powietrzu, pole to pozostanie puste.
6. **To** ‒ kod ICAO lotniska, na którym wylądowałeś. Jeśli nie wylądowałeś (np. zamykając FG w locie) lub lądując w miejscu przygodnym, pole to pozostanie puste.
7. **Landings** ‒ ilość wykonanych lądowań. Jeśli wylądowałeś, gdziekolwiek, zostanie tu wpisane 1. Gdy lot zakończył się bez lądowania lub dodatek nie był w stanie wykryć prawidłowego lądowania, zostanie tu wpisane 0.
8. **Day** ‒ ilość godzin spędzonych w czasie lotu podczas dnia.
9. **Night** ‒ ilość godzin spędzonych w czasie lotu podczas nocy.
10. **Instrument** ‒ ilość godzin spędzonych w czasie lotu podczas warunków IMC (Instrument Meteorological Conditions).
11. **Duration** ‒ łączny czas trwania lotu w godzinach, jako suma **Day** i **Night**.  Instrument jest tutaj nie sumowany, jako że po prostu liczony jest osobno, niezależnie od tego czy był dzień czy noc.
12. **Distance** ‒ łączny dystans pokonany od startu do lądowania, w milach morskich.
13. **Fuel** ‒ łączna ilość spalonego paliwa, w galonach amerykańskich.
14. **Max Alt** ‒ maksymalna wysokość w stopach, osiągnięta podczas lotu.
15. **Note** ‒ notatki, domyślnie pełna nazwa statku powietrznego.

## Przeglądanie dziennika

Dodatek udostępnia także możliwość przeglądania całego dziennika lotów z poziomu symulatora. Należy z menu wybrać pozycję "Logbook" -> "Logbook". Otworzy się okno główne z całym dziennikiem w postaci tabelarycznej. Ostatni rząd podpisany "Totals", zawiera podsumowanie, nie tylko widocznych wpisów na danej stronie, ale całego dziennika. Rząd "Totals" widoczny jest na każdej stronie.

Na samym dole mamy rząd przycisków, głównie do przemieszczania się po stronach dziennika. Przycisk `|<<` oznacza przejście do pierwszej strony, `<` przejście do poprzedniej strony, `>` przejście do następnej strony, `>>|` przejście do ostatniej strony. Na środku mamy informację tekstową w formacie `{na której jesteśmy stronie} / {ilość wszystkich stron} (ilość wpisów w dzienniku)`. Po prawej mamy przycisk `dark`/`light` do przełączania się między stylami okna. Przycisk `?` otwiera okno z pomocą (to samo co z menu "Logbook" -> "Help").

Każdy wpis w dzienniku można najechać myszką i kliknąć. Wówczas otworzy się dodatkowe okno prezentujące szczegóły danego wpisu. Ogólnie mamy tutaj to samo co w oknie głównym, poza tym:

1. Przy kodach ICAO lotnisk mamy w nawiasie podane ich nazwy.
2. Przy danych liczbowych mamy podane jednostki w jakich prezentowane są te wartości.
3. Na samym dole mamy dodatkowe pole `Note`, które nie jest wyświetlane w oknie głównym, ze względu na możliwość umieszczenia tutaj, dowolnie długiego tekstu.

## Edycja i usuwanie danych

Każdy wpis w dzienniku można edytować z poziomu symulatora. Należy z menu wybrać pozycję "Logbook" -> "Logbook". Otworzy się okno główne z całym dziennikiem. Możesz tu wyszukać wpisu, który chcesz edytować i kliknąć na niego. Otworzy się okno szczegółów dla danego wpisu. Teraz możesz kliknąć na konkretną pozycję, którą chcesz edytować. Otworzy się kolejne okienko z polem tekstowym. Wystarczy wprowadzić nową wartość i potwierdzić przyciskiem "Save". Zmiana od razu zostanie zapisana do pliku.

Na dole okna szczegółów znajduje się przycisk `Delete`, za pomocą którego możesz całkowicie usunąć wybrany wpis.

### Kopia zapasowa

Przed każdym zapisem pojedynczej zmian, dodatek tworzy kopię oryginalnego pliku CSV, do którego dokleja na koniec rozszerzenie `.bak`. Tak więc gdyby podczas edycji danych coś się nie powiodło i oryginalny plik został by uszkodzony, zawsze możesz go odzyskać, usuwając z nazwy kopi dopisek `.bak`.

## Uwagi

1. Jeśli podczas lotu prawidłowo zamkniesz symulator ("Plik" -> "Zamknij"), aktualny stan lotu zostanie zapisany do dziennika (oczywiście bez informacji o lądowaniu).
2. Jeśli podczas lotu symulator zostanie zamknięty w nieprawidłowy sposób, np. poprzez przycisk [X] na belce okna lub wystąpi crash, to stan lotu zostanie utracony.
3. Aby dodatek zaliczył lądowanie, statek powietrzny musi oprzeć się na wszystkich kołach i utrzymać ten stan przez co najmniej 3 sekundy. W ten sposób brzydkie odbicie się od pasa nie zostanie zaliczone jako lądowanie.
4. Jeśli rozpoczniesz symulację w powietrzu, dodatek to rozpozna i rozpocznie logowanie nie czekając na start.
5. Jeśli rozpoczniesz symulację w powietrzu, dodatek nie jest w stanie rozpoznać podwozia, więc zaliczenie lądowania wydłuży się do 6 sekund (dając dodatkowe 3 sekundy na upewnienie się, że statek powietrzny spoczywa na wszystkich kołach).
6. Śmigłowce także powinny być wspierane, choć nie testowałem wszystkich.
7. Dodatek wspiera wodnosamoloty oparte o JSBSim, choć nie testowałem wszystkich.
8. Dodatek wspiera Wahadłowiec Kosmiczny.
9. Loty UFO nie będą logowane.
10. Zapauzowanie symulacji lub włączenie trybu powtórki, zatrzymuje naliczanie statystyk lotu do dziennika.
11. Co do spalania paliwa, dodatek nie uwzględnia zmiany ilości paliwa podczas lotu. Gdy zmienisz ilość paliwa podczas lotu, rezultat w kolumnie **Fuel** będzie błędny. Zatem staraj się tego unikać i tankuj samolot przed lotem.
12. Wspierane wersje FG od 2020.1.
13. Plik CSV zawierający ponad 100 000 wpisów, będzie znacznie dłużej się wczytywał. Na moim wydajnym sprzęcie około 2-3 sekundy. Plik ten zawsze jest wczytywany podczas wczytywania się dodatku. Zatem duże pliki spowodują chwilowe lecz zauważalne przycięcie się całego symulatora. Rozważam przenieść wczytywanie do osobnego wątku, o ile uzyskam też dobrą stabilność takiego rozwiązania.

## Autorzy

- Roman "PlayeRom" Ludwicki

## Licencja

Logbook jest projektem Open Source i jest objęty licencją GNU Public License v3 (GPLv3).
