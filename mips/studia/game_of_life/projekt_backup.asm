##########################################
# Wojciech Jedynak
# Nr. indeksu 209078
# Zadanie 22. Jednowymiarowa gra w zycie
##########################################

##########################################
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
###########################################


    .text
    .globl __start

####################################################
# Funkcja, ktora pobiera opis pojedynczego pokolenia
# i na jego podstawie generuje opis nastepnego.
####################################################

next:
    # Tymczasowy wynik bedziemy przechowywac w rejestrze $t7
    # Poczatkowo bedzie on zerem, w miare analizowania pokolenia bedziemy
    # zapalac odpowiednie bity.
    
    # tymczasowy wynik
    or      $t7, $zero, $zero
    
    # licznik glownej petli
    ori     $t6, $zero, 31

    # maska bitowa, ktora zawsze ma dokladnie 1 bit zapalony
    ori     $t5, $zero, 1

    # zmienna, ktorej ostatnie 5 bitow to kopia 5 ostatnich bitow z poprzedniej generacji
    or      $t0, $zero, $zero
    
    # ustawienie kopii (dwa ostatnie bity sa 0, jest to wariant straznika)
    # musimy potem przesunac o dwa miejsca w lewo, bo bity 2,1 i 0 maja
    # byc bitami 4, 3 i 2.
    andi    $t0, $a0, 7
    sll     $t0, $t0, 2


    # glowna petla, ktora chcemy wykonac raz dla kazdego bitu
for:
    # wychodzimy z petli, jesli licznik zrobi sie ujemny
    bltz    $t6, endfor
    
    # obliczamy liczbe zywych sasiadow
    # w t1 mamy sume, t2 jest tymczasowa
    # za kazdym razem tak and-ujemy i shift-ujemy, zeby w t1 bylo rowne 0 albo 1
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

    # jezeli suma jest rowna 2, to mamy zapalic bit
    # zrobimy to odejmujac 0 i porownujac z zerem
    addi    $t1, $t1, -2
    beq     $t1, $zero, zapal
    
    # pozostale mozliwosci to
    # a) komorka jest zywa i ma 4 sasiadow
    # b) komorka jest martwa i ma 3 sasiadow
    # laczymy te przypadki odejmujac od t1 jedynke, gdy komorka jest zywa
    # pozniej jesli t1 == 1 to komorka ma byc zywa (1, bo odjelismy 2)
    
    # UWAGA: t2 jest juz niepotrzebne, wiec uzywamy jej ponownie
    andi    $t2, $t0, 4
    
    # jezeli t2 jest zerem, to nasza komorka jest martwa
    beq     $t2, $zero, dalej

    # tutaj bedziemy, tylko jesli komorka jest zywa
    addi    $t1, $t1, -1

dalej:
    # druga i ostatnia mozliwosc, zeby komorka byla zywa
    addi    $t1, $t1, -1
    beq     $t1, $zero, zapal

    j jeszczedalej

zapal:
    # zapalamy aktualny bit
    or      $t7, $t7, $t5

jeszczedalej:
    # przygotowujemy wszystko przed kolejna iteracja
    # zmniejszamy licznik
    addi    $t6, $t6, -1

    # przesuwamy maske o jeden w lewo
    sll     $t5, $t5, 1

    # przesuwamy poprzedni opis i jego kopie od 1 w prawo
    srl     $a0, $a0, 1
    srl     $t0, $t0, 1

    # kopiujemy bit sasiada najbardziej na lewo
    andi    $t2, $a0, 4
    sll     $t2, $t2, 2
    or      $t0, $t0, $t2

    # zapetlamy
    j for
endfor:

    # wynik jest w $t7
    # musimy ustawic go w $v0
    or      $v0, $zero, $t7

    # wychodzimy z funkcji
    jr $ra

##################################################################################
# Procedura, ktora pobiera opis pokolenia i drukuje jego tekstowa reprezentacje
# za pomoca znakow '*' i '.'
##################################################################################

printgen:
    # skopiuj argument
    or      $t9, $zero, $a0
    
    # utworz maske bitowa, ktora jest postaci 1 i 31 zer
    ori     $t0, $zero, 1
    sll     $t0, $t0, 31
    
    # licznik petli
    ori     $t1, $zero, 31

printloop:
    # wychodzimy z petli jesli licznik stanie sie ujemny
    bltz    $t1, endprintloop

    # sprawdzamy jaki jest i-ty bit slowa (= i-ta komorka pokolenia)
    and     $t2, $t9, $t0
    
    beq     $t2, $zero, zero

jeden:
    la      $a0, star
    j wypisz
zero:
    la      $a0, dot
wypisz:
    li      $v0, 4
    syscall

    # przygotowujemy sie do nastepnej iteracji
    # przesuwamy 1 z maski o jedna pozycji w prawe
    srl     $t0, $t0, 1
    
    # zmniejszamy wartosc licznika
    addi    $t1, $t1, -1
    
    # zapetlamy
    j printloop

endprintloop:

    # wychodzimy z funkcji
    jr $ra

# Procedura, ktora pobiera adres napisu, ktory podal uzytkownik
# i tworzy reprezentacje tego pokolenia w postaci liczby 32-bitowej
parse:
    # tymczasowy wynik
    or      $t1, $zero, $zero,
    
    # maska bitowa, ktora ma na poczatku jedna 1 i 31 zer
    ori     $t2, $zero, 1
    sll     $t2, $t2, 31

    # licznik petli
    ori     $t3, $zero, 31

    # kod znaku gwiazdki
    ori     $t4, $zero, 42
    
parseloop:
    # wychodzimy z petli, gdy licznik bedzie ujemny
    bltz    $t3, endparseloop
    
    # wczytujemy pojedynczy bajt
    lbu     $t5, 0($a0)

    # jezeli wczytany bajt to odpowiada kodowi gwiazdki do zapalamy aktualny bit
    bne     $t5, $t4, parsedalej

parsezapal:
    or      $t1, $t1, $t2

parsedalej:    
    # przygotowania do nastepnej iteracji
    addi    $a0, $a0, 1
    addi    $t3, $t3, -1
    srl     $t2, $t2, 1

    # zapetlamy
    j parseloop

endparseloop:
    # ustawiamy wynik
    or      $v0, $t1, $zero

    # wychodzimy z funkcji
    jr  $ra

# Procedura startowa

__start:
    # poczatkowe pokolenie
    # addi     $s0, $zero, -1
    
    # liczba iteracji
    ori      $s1, $zero, 100

    # Pobierz poczatkowy stan od uzytkownika
    li      $v0, 8
    la      $a0, input
    li      $a1, 33
    syscall

    # przygowuj parametr dla procedury parsujacej
    # a0 jest tutaj ustawione dobrze
    jal     parse
    
    # zapis wynik procedury
    or      $s0, $zero, $v0

loop:
    beq     $s1, $zero, end

    # wypisujemy znak nowej linii
    la      $a0, str
    li      $v0, 4
    syscall

    # przygotuj parametr dla procedury wypisujacej
    or      $a0, $zero, $s0

    jal     printgen

    # przygotuj parametr dla procedury generujacej kolejny stan
    or      $a0, $zero, $s0

    # wywolaj procedure
    jal     next

    # zapisz nowy wynik w $s0
    or      $s0, $zero, $v0

    # zmniejszamy licznik
    addi    $s1, $s1, -1

    # zapetlamy
    j loop
end:
    
    .data
str:
    .asciiz "\n"
star:
    .asciiz "*"
dot:
    .asciiz "."
promt:
    .asciiz "Podaj ciag dlugosci 32 skladajacy ze sie znakow '*' i '.' .\n"
input:
    .space 33
