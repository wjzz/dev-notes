##########################################
# Wojciech Jedynak
# Nr. indeksu 209078
# Zadanie 22. Jednowymiarowa gra w zycie
##########################################

#################################################################################
# Struktura kodu
# Program sklada sie z trzech funkcji i procedury glownej.
# Funkcja next pobiera opis pokolenia i zwraca opis nastepnego.
# Funkcja print drukuje na konsole tekstowa reprezentacje podanego pokolenia.
# Funkcja parse pobiera adres napisu skladajacego sie z 32 znakow
# i zwraca opis pokolenia wygenerowanego na podstawie ww. napisu
#
# Reprezentacja binarna pokolenia
# Przez wyrazenie "opis pokolenia" rozumiemy rejestr 32 bitowy. 
# Jezeli i-ty bit jest rowny 1, to i-ta komorka jest zywa. Jesli jest rowny 0,
# to komorka jest martwa.
#################################################################################


    .text
    .globl __start

#################################################################################
# Funkcja, ktora pobiera opis pojedynczego pokolenia
# i na jego podstawie generuje opis nastepnego.
#
# Opis algorytmu:
# Idea jest taka, zeby zaczac od wszystkich bitow ustawionych
# na 0. Nastepnie dla i = 0..31
# - obliczamy liczbe zywych sasiadow
# - jezeli w nastepnym pokoleniu komorka jest zywa, to
# ustawiamy i-ty bit na 1.

# Podczas implementacji natrafiamy na nastepujace problemy:
# a) komorki o numerach 0, 1, 30, 31 maja inna liczbe sasiadow
# b) jak najprosciej sprawdzic czy komorka ma byc zywa w nastepnym pokoleniu

# Problem a) powoduje, ze musimy uwazac, zeby nie probowac sprawdzac bitow,
# ktore znajduja sie "poza slowem". W kodzie wykorzystano nastepujacy pomysl:
# Wykorzystujemy 5 bitow pomocniczego rejestru tak, ze jesli aktualnie pracujemy
# z i-tym bitem to te 5 bitow to bity o numerach i+2, i+1, i, i-1, i-2. 
# W skrocie - bit i-ty i sasiedzi. Dzieki tej sztuczce mozemy udawac, ze
# bity 30. i 31. maja sasiadow o numerach 32, 33 (ktorzy sa zawsze martwi).
# Druga dziwna rzecza, ktora robimy jest przesuwanie slowa z poczatkowym opisem
# pokolenia o 1 w prawo po kazdej iteracji. Dzieki temu latwo nam aktualniac
# zawartosc pomocniczego rejestru oraz mamy kolejna wlasnosc: bity, ktore sa
# "zwalniane"  w wyniku przesuniecia sa ustawiane na 0. Dzieki temu mozemy
# udawac, ze bity 0. i 1. majac wiecznie martwych sasiadow: -1. i -2.
# A wszystko to po to, zeby rozwazac przypadkow...

# Problem b). Zauwazamy, ze jesli liczba zywych sasiadow wynosi 2, to
# komorka bedzie w nastepnym pokoleniu zywa niezaleznie od tego jaki jest jej
# aktualny stan. Pozostaly dwa przypadki: komorka jest zywa i ma 4 zyw. sasiadow
# lub jest martwa i ma 3. Wystarczy wiec odjac 1 od liczby zywych sasiadow
# jesli komorka jest zywa i sprawdzic czy zostalo 3.

# Przeznaczenie rejestrow:
# $a0 - opis poczatkowego pokolenia

# $t7 - tymczasowy wynik (czyli opis nastepnego pokolenia)
# $t6 - licznik glownej petli (next_loop)
# $t5 - rejestr, ktory ma zawsze dokladnie jeden bit rowny 1.
# $t2 - rejestr wielokrotnego uzycia, pojemnik na tymczasowe wyniki
# $t1 - liczba zywych sasiadow aktualnej komorki
# $t0 - rejestr pomocniczy z opisu problemu a), uzywamy jego 5 bitow
################################################################################

next:
    # Tymczasowy wynik. Poczatkowo bedzie on zerem, w miare analizowania pokolenia
    # bedziemy zapalac odpowiednie bity.
    or      $t7, $zero, $zero
    
    # Licznik glownej petli. Wartosc licznika to numer bitu, ktory wlasnie rozwazamy.
    ori     $t6, $zero, 31

    # Maska bitowa, ktora zawsze ma dokladnie 1 bit zapalony
    # Uzywamy jej do zapalania ustalonego bitu.
    ori     $t5, $zero, 1

    # Zmienna, ktorej ostatnie 5 bitow to kopia 5 ostatnich bitow z poprzedniej generacji
    or      $t0, $zero, $zero

    # Chcemy zeby 5 ostatnich bitow bylo takich, ze 0. i 1. sa zerami,
    # a 2., 3. i 4. odpowiaja bitom odpowiednio 0., 1. i 2. z $a0
    # Kopiujemy wiec 3 ostatnie bity i przesuwamy wszystko o 2 pozycje w lewo.
    andi    $t0, $a0, 7
    sll     $t0, $t0, 2

    # Glowna petla, ktora chcemy wykonac raz dla kazdego bitu
next_loop:

    # Wychodzimy z petli, jesli licznik zrobi sie ujemny
    bltz    $t6, next_loop_end
    
    # Obliczamy liczbe zywych sasiadow 
    # Idea jest taka, zeby do $t2 zapisac koncowe 2, 3 lub 4 bity, a nastepnie przesunac
    # zawartosc $t2 o odp. 1, 2, 3 miejsca w prawo. Dzieki temu najmniej znaczacy bit w $t2
    # bedzie rowny sasiadom i-1, i+1, i+2. (i-2 mozemy od razu uwzglednic i wpisac do t1)
    andi    $t1, $t0, 1

    andi    $t2, $t0, 2
    srl     $t2, $t2, 1
    add     $t1, $t1, $t2

    andi    $t2, $t0, 8
    srl     $t2, $t2, 3
    add     $t1, $t1, $t2

    andi    $t2, $t0, 16
    srl     $t2, $t2, 4
    add     $t1, $t1, $t2

    # Jezeli suma jest rowna 2, to mamy zapalic bit
    # Sprawdzamy to odejmujac 2 od $t1 i porownujac z zerem
    addi    $t1, $t1, -2
    beq     $t1, $zero, next_turn_on
    
    # Pozostale mozliwosci to
    # a) komorka jest zywa i ma 4 sasiadow
    # b) komorka jest martwa i ma 3 sasiadow
    # Laczymy te przypadki odejmujac od t1 jedynke, gdy komorka jest zywa
    # pozniej jesli t1 == 1 to komorka ma byc zywa (1, bo odjelismy 2)
    
    # UWAGA: t2 jest juz niepotrzebne, wiec uzywamy jej ponownie
    # umieszczajac w jej ostatnim bicie wartosc aktualnego bitu.
    andi    $t2, $t0, 4
    srl     $t2, $t2, 2
    
    # Jezeli t2 jest zerem, to nasza komorka jest martwa
    beq     $t2, $zero, next_dead_cell

    # Tutaj bedziemy tylko jesli komorka jest zywa
    addi    $t1, $t1, -1

next_dead_cell:
    # Druga i ostatnia mozliwosc, zeby komorka byla zywa
    addi    $t1, $t1, -1
    beq     $t1, $zero, next_turn_on

    j next_before_jump

next_turn_on:
    # Zapalamy aktualny bit uzywajac naszej maski
    or      $t7, $t7, $t5

next_before_jump:
    # Przygotowujemy wszystko przed kolejna iteracja

    # Zmniejszamy licznik
    addi    $t6, $t6, -1

    # Przesuwamy maske o jeden w lewo
    sll     $t5, $t5, 1

    # Przesuwamy poprzedni opis i jego kopie o 1 w prawo
    srl     $a0, $a0, 1
    srl     $t0, $t0, 1

    # Kopiujemy bit sasiada najbardziej na lewo
    andi    $t2, $a0, 4
    sll     $t2, $t2, 2
    or      $t0, $t0, $t2

    # Zapetlamy
    j next_loop

next_loop_end:

    # Wynik jest w $t7
    # Musimy ustawic go w $v0
    or      $v0, $zero, $t7

    # Wychodzimy z funkcji
    jr $ra

##################################################################################
# Procedura, ktora pobiera opis pokolenia i drukuje jego tekstowa reprezentacje
# za pomoca znakow '*' i '.'

# Przeznaczenie rejestrow
# $a0 - na poczatku opis poczatkowego pokolenia, pozniej adres napisu

# $t0 - rejestr, ktory ma zawsze dokladnie jeden bit rowny 1.
# $t1 - licznik glownej petli (print_loop)
# $t9 - kopia opisu pokolenia
##################################################################################

print:
    # Skopiuj argument ($a0 jest potrzebne przy syscall)
    or      $t9, $zero, $a0
    
    # Utworz maske bitowa, ktora jest postaci 1 i 31 zer
    ori     $t0, $zero, 1
    sll     $t0, $t0, 31
    
    # Licznik petli
    ori     $t1, $zero, 31

print_loop:
    # wychodzimy z petli jesli licznik stanie sie ujemny
    bltz    $t1, print_loop_end

    # sprawdzamy jaki jest i-ty bit slowa (= i-ta komorka pokolenia)
    and     $t2, $t9, $t0
    beq     $t2, $zero, print_zero

print_one:
    # jezeli bit jest rowny 1 to drukujemy gwiazdke
    la      $a0, star
    j print_print

print_zero:
    # jezeli bity jest rowny 0 to drukujemy kropke
    la      $a0, dot

print_print:
    # Wyswielamy odpowiedni znak (ciag dl. jeden)
    li      $v0, 4
    syscall

    # przygotowujemy sie do nastepnej iteracji
    # przesuwamy 1 z maski o jedna pozycji w prawe
    srl     $t0, $t0, 1
    
    # zmniejszamy wartosc licznika
    addi    $t1, $t1, -1
    
    # zapetlamy
    j print_loop

print_loop_end:

    # wychodzimy z funkcji
    jr $ra

####################################################################
# Funkcja, ktora pobiera adres napisu, ktory podal uzytkownik
# i tworzy reprezentacje tego pokolenia w postaci liczby 32-bitowej

# Przeznaczenie rejestrow:
# $a0 - adres tablicy, ktora zawiera napis zlozony z 32 znakow ('*' lub '.')
# $t1 - tymczasowy wynik
# $t2 - rejestr, ktory ma zawsze dokladnie jeden bit rowny 1.
# $t3 - licznik glownej petli (parse_loop)
# $t4 - kod ASCII znaku  '*'
# $t5 - aktualnie sprawdzany bajt (znak) wejsciowego napisu
####################################################################

parse:
    # Tymczasowy wynik (na poczatku wszystko ustawiamy na 0)
    or      $t1, $zero, $zero,
    
    # Maska bitowa, ktora ma na poczatku jedna 1 i 31 zer
    ori     $t2, $zero, 1
    sll     $t2, $t2, 31

    # Licznik petli
    ori     $t3, $zero, 31

    # Kod ASCII znaku '*'
    ori     $t4, $zero, 42
    
parse_loop:
    # Wychodzimy z petli, gdy licznik bedzie ujemny
    bltz    $t3, parse_loop_end
    
    # Wczytujemy pojedynczy bajt
    lbu     $t5, 0($a0)

    # Jezeli wczytany bajt odpowiada kodowi '*' do zapalamy aktualny bit
    bne     $t5, $t4, parse_before_jump

parse_turn_on:
    or      $t1, $t1, $t2

parse_before_jump:    
    # Przygotowania do nastepnej iteracji
    addi    $a0, $a0, 1
    addi    $t3, $t3, -1
    srl     $t2, $t2, 1

    # Zapetlamy
    j parse_loop

parse_loop_end:
    # Ustawiamy wynik
    or      $v0, $t1, $zero

    # Wychodzimy z funkcji
    jr  $ra

#####################################################################
# Procedura startowa
#
# Tutaj skladamy wszystko w jedna calosc.
# Najpierw pobieramy od uzytkownika opis startowego pokolenia.
# Nastepnie parsujemy je by uzyskac jego reprezentacje w postaci
# jednego rejestru. Nastepnie ustalona liczbe razy (aktualnie 100)
# wyswietlamy opis pokolenia i generujemy nastepne.
#####################################################################

#__start:  
main:
    # Liczba iteracji
    ori      $s1, $zero, 100

    # Wyswietl prosbe o podanie danych
    la      $a0, prompt
    li      $v0, 4
    syscall

    # Pobierz poczatkowy stan od uzytkownika
    li      $v0, 8
    la      $a0, input
    li      $a1, 33
    syscall

    # Przygowuj parametr dla procedury parsujacej i wywolaj ja
    # a0 jest tutaj ustawione dobrze
    jal     parse
    
    # Zapisz wynik procedury
    or      $s0, $zero, $v0

loop:
    beq     $s1, $zero, end

    # Wypisz znak nowej linii
    la      $a0, str
    li      $v0, 4
    syscall

    # Przygotuj parametr dla procedury wypisujacej i wywolaj ja
    or      $a0, $zero, $s0
    jal     print

    # Przygotuj parametr dla procedury generujacej kolejny stan i wywolaj ja
    or      $a0, $zero, $s0
    jal     next

    # Zapisz nowy wynik w $s0
    or      $s0, $zero, $v0

    # Zmniejsz licznik
    addi    $s1, $s1, -1

    # Zapeltij
    j loop
end:
    
    .data
str:
    .asciiz "\n"
star:
    .asciiz "*"
dot:
    .asciiz "."
prompt:
    .asciiz "Podaj ciag dlugosci 32 skladajacy ze sie znakow '*' i '.' .\n"
input:
    .space 33
