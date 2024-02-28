#!/bin/bash

# Colours

greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# FUncion salir

function ctrl_c(){

    echo -e "\n\n${redColour}[!] Saliendo...\n"
    exit 1
}

# Ctrl+C
trap ctrl_c INT

function helpPanel(){
    echo -e "\n[!] Uso: $0\n"
    echo -e "\t -m) Dinero con el que se desea jugar"
    echo -e "\t -t) Técnica a utilizar ( fibonacci / inverseFibonacci / martingala / inverseMartingala / alembert / inverseAlembert )"
    exit 1
}

function fibonacci() {

    echo -e "\n[=] Dinero actual: $money"
    echo -e "[!] Vamos a apostar 1€"
    echo -ne "[?] ¿Cuánto dinero quieres ganar? -> " && read win_money
    echo -ne "[?] ¿A qué desea apostar continuamente? (par | impar) -> " && read par_impar

    initial_bet=1
    echo -e "[!] Vamos a jugar con una cantidad inicial de $initial_bet€ a $par_impar\n"

    play_counter=1
    bad_games=" "
    better_game=$initial_bet

    # fibonacci

    n=1
    a=1
    b=1
    c=0

    while true; do
        money=$(($money - $initial_bet))
        echo "[!] Acabas de apostar $(($initial_bet)) y tines $money"
        random_number="$(($RANDOM % 37))"
        echo -e "[!] Ha salido el número $random_number"

        if [ "$money" -gt 0 ]; then
            if [ "$par_impar" == "par" ]; then
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo "[!] Ha salido el 0, por lo tanto has perdido"
                        for i in $n; do
                            fn=$(($a + $b))
                            c=$a
                            a=$b
                            b=$fn
                        done
                        n=$((n+1))
                        initial_bet=$fn
                        bad_games+="$random_number "
                    else
                        echo "[+] El número que ha salido es par, ganas!"
                        reward=$(($initial_bet*2))
                        echo "[+] Ganas un total de $reward€"
                        money=$(($money+$reward))
                        better_game=$money
                        if [ $money -gt $better_game ]; then
                            better_game=$money
                        fi
                        n=1
                        a=1
                        b=1
                        initial_bet=1
                        bad_games=" "
                        if [ $money -eq $win_money ]; then
                            echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                            echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                            exit 0
                        fi
                    fi
                else
                    echo "[-] El número que ha salido es impar, pierdes!"
                    for i in $n; do
                        fn=$(($a + $b))
                        c=$a
                        a=$b
                        b=$fn
                    done
                    n=$((n+1))
                    initial_bet=$fn
                    bad_games+="$random_number "
                fi
                echo -e "[=] Tienes $money€\n"
                let play_counter+=1
            else
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo "[!] Ha salido el 0, por lo tanto has perdido"
                        for i in $n; do
                            fn=$(($a + $b))
                            c=$a
                            a=$b
                            b=$fn
                        done
                        n=$((n+1))
                        initial_bet=$fn
                        bad_games+="$random_number "
                    else
                        echo "[+] El número que ha salido es par, pierdes!"
                        for i in $n; do
                            fn=$(($a + $b))
                            c=$a
                            a=$b
                            b=$fn
                        done
                        n=$((n+1))
                        initial_bet=$fn
                        bad_games+="$random_number "
                    fi
                else
                    echo "[-] El número que ha salido es impar, ganas"
                    reward=$(($initial_bet*2))
                    echo "[+] Ganas un total de $reward€"
                    money=$(($money+$reward))
                    better_game=$money
                    if [ $money -gt $better_game ]; then
                        better_game=$money
                    fi
                    n=1
                    a=1
                    b=1
                    initial_bet=1
                    bad_games=" "
                    if [ $money -eq $win_money ]; then
                        echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                        echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                        exit 0
                    fi
                fi
                echo -e "[=] Tienes $money€\n"
                let play_counter+=1
            fi
        else
            # No hay dinero
            echo -e "\n${redColour}[!] Te has quedado sin dinero${endColour}\n"
            echo -e "${redColour}[!] Total de jugadas: $play_counter${endColour}"
            echo -e "${redColour}[!] Total de jugadas malas: $bad_games${endColour}"
            echo -e "${redColour}[!] Mayor cantidad de dinero conseguido: $better_game${endColour}"
            exit 0
        fi
    done
}

function inverseFibonacci() {
    echo -e "\n[+] Dinero actual:$money€"
    echo -e "[+] Vamos a apostar 1€"
    echo -ne "[+] ¿Cuanto dinero quieres ganar? -> " && read win_money
    echo -ne "[+] ¿A qué deseas apostar continuamente (par/impar)? ->  " && read par_impar

    initial_bet=1
    echo -e "[+] Vamos a jugar con una cantidad inicial de $initial_bet€ a $par_impar\n"

    play_counter=1
    bad_games=" "
    better_game=$initial_bet

    #fibonacci
    n=1
    a=1
    b=1
    c=0

    while true; do
        money=$(($money - $initial_bet))
        echo "[+] Acabas de apostar $(($initial_bet)) y tienes $money"
        random_number="$(($RANDOM % 37))"
        echo -e "[+] Ha salido el número $random_number"

        if [ "$money" -ge 0 ]; then
            if [ "$par_impar" == "par" ]; then
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo "[+] Ha salido el 0, por lo tanto has perdido"
                        n=1
                        a=1
                        b=1
                        initial_bet=1
                        bad_games+="$random_number "
                    else
                        echo "[+] El número que ha salido es par, ganas!"
                        reward=$(($initial_bet*2))
                        echo "[+] Ganas un total de $reward€"
                        money=$(($money+$reward))
                        better_game=$money
                        if [ $money -gt $better_game ]; then
                            better_game=$money
                        fi
                        for i in $n; do
                            fn=$(($a + $b))
                            c=$a
                            a=$b
                            b=$fn
                        done
                        n=$((n+1))
                        initial_bet=$fn
                        bad_games=" "
                        if [ $money -eq $win_money ]; then
                            echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                            echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                            exit 0
                        fi
                    fi
                else
                    echo "[-] El número que ha salido es impar, pierdes!"
                    n=1
                    a=1
                    b=1
                    initial_bet=1
                    bad_games+="$random_number "
                fi
                echo -e "[=] Tienes $money€\n"
                let play_counter+=1
            else
                if [ "$(($random_number % 2))" == 0 ]; then
                    if [ "$random_number" == 0 ]; then
                        echo "[+] Ha salido el 0, por lo tanto has perdido"
                        n=1
                        a=1
                        b=1
                        initial_bet=1
                        bad_games+="$random_number "
                    else
                        echo "[+] El número que ha salido es par, pierdes!"
                        n=1
                        a=1
                        b=1
                        initial_bet=1
                        bad_games+="$random_number "
                    fi
                else
                    echo "[-] El número que ha salido es impar, ganas!"
                    reward=$(($initial_bet*2))
                    echo "[+] Ganas un total de $reward€"
                    money=$(($money+$reward))
                    better_game=$money
                    if [ $money -gt $better_game ]; then
                        better_game=$money
                    fi
                    for i in $n; do
                        fn=$(($a + $b))
                        c=$a
                        a=$b
                        b=$fn
                    done
                    n=$((n+1))
                    initial_bet=$fn
                    bad_games=" "
                    if [ $money -eq $win_money ]; then
                        echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                        echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                        exit 0
                    fi
                fi
                echo -e "[=] Tienes $money€\n"
                let play_counter+=1
            fi
        else
            # No hay dinero
            echo -e "\n${redColour}[!] Te has quedado sin dinero${endColour}\n"
            echo -e "${redColour}[!] Total de jugadas: $play_counter${endColour}"
            echo -e "${redColour}[!] Total de jugadas malas: $bad_games${endColour}"
            echo -e "${redColour}[!] Mayor cantidad de dinero conseguido: $better_game${endColour}"
            exit 0
        fi
    done
}

function martingala(){
    echo -e "\n[+] Dinero actual:$money€"
    echo -ne "[+] ¿Cuánto dinero tines pensado apostar? -> " && read initial_bet
    echo -ne "[+] ¿Cuanto dinero quieres ganar? -> " && read win_money
    echo -ne "[+] ¿A qué deseas apostar continuamente (par/impar)? ->  " && read par_impar

    echo -e "[+] Vamos a jugar con una cantidad inicial de $initial_bet€ a $par_impar\n"

    backup_bet=$initial_bet
    play_counter=1
    bad_games=" "
    better_game=$initial_bet

    while true; do
        money=$(($money-$initial_bet))
        echo "[+] Acabas de apostar $initial_bet€ y tines $money€"
        random_number="$(($RANDOM % 37))"
        echo -e "[+] Ha salido el número $random_number"

        if [  "$money" -ge 0 ]; then
            if [ "$par_impar" == "par" ]; then
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo "[-] Ha salido el 0, por tanto has perdido "
                        initial_bet=$(($initial_bet*2))
                        bad_games+="$random_number "
                    else
                        echo "[+] El número que ha salido es par, ganas!"
                        reward=$(($initial_bet*2))
                        echo "[+] Ganas un total de $reward€"
                        money=$(($money+$reward))
                        better_game=$money
                        if [ $money -gt $better_game ]; then
                            better_game=$money
                        fi

                        if [ $money -eq $win_money ]; then
                            echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                            echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                            exit 0
                        fi
                        initial_bet=$backup_bet
                        bad_games=" "
                    fi
                else
                    echo "[-] El número que ha salido es impar, pierdes!"
                    initial_bet=$(($initial_bet*2))
                    bad_games+="$random_number "
                fi
                echo -e "[=] Tines $money€\n"
                let play_counter+=1
                #sleep 1.5
            else
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo "[-] Ha salido el 0, por tanto has perdido "
                        initial_bet=$(($initial_bet*2))
                        bad_games+="$random_number "
                    else
                        echo "[-] El número que ha salido es par, pierdes!"
                        initial_bet=$(($initial_bet*2))
                        bad_games+="$random_number "
                    fi
                else
                    echo "[+] El número que ha salido es impar, ganas!"
                    reward=$(($initial_bet*2))
                    echo "[+] Ganas un total de $reward€"
                    money=$(($money+$reward))
                    better_game=$money
                    if [ $money -gt $better_game ]; then
                        better_game=$money
                    fi

                    if [ $money -eq $win_money ]; then
                        echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                        echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                        exit 0
                    fi

                    initial_bet=$backup_bet
                    bad_games=" "
                fi
                echo -e "[=] Tines $money€\n"
                let play_counter+=1
            fi
        else
            echo -e "\n${redColour}[!] Te has quedado sin dinero${endColour}\n"
            echo -e "${redColour}[!] Total de jugadas: $play_counter${endColour}"
            echo -e "${redColour}[!] Total de jugadas malas: $bad_games${endColour}"
            echo -e "${redColour}[!] Mayor cantidad de dinero conseguido: $better_game${endColour}"
            exit 0
        fi
    done
}

function inverseMartingala(){
    echo -e "\n[+] Dinero actual:$money€"
    echo -ne "[+] ¿Cuánto dinero tines pensado apostar? -> " && read initial_bet
    echo -ne "[+] ¿Cuanto dinero quieres ganar? -> " && read win_money
    echo -ne "[+] ¿A qué deseas apostar continuamente (par/impar)? ->  " && read par_impar

    echo -e "[+] Vamos a jugar con una cantidad inicial de $initial_bet€ a $par_impar\n"

    backup_bet=$initial_bet
    play_counter=1
    bad_games=" "
    better_game=$initial_bet

    while true; do
        money=$(($money-$initial_bet))
        echo "[+] Acabas de apostar $initial_bet€ y tines $money€"
        random_number="$(($RANDOM % 37))"
        echo -e "[+] Ha salido el número $random_number"

        if [  "$money" -ge 0 ]; then
            if [ "$par_impar" == "par" ]; then
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo "[-] Ha salido el 0, por tanto has perdido "
                        initial_bet=$backup_bet
                        bad_games+="$random_number "
                    else
                        echo "[+] El número que ha salido es par, ganas!"
                        reward=$(($initial_bet*2))
                        echo "[+] Ganas un total de $reward€"
                        money=$(($money+$reward))
                        better_game=$money
                        if [ $money -gt $better_game ]; then
                            better_game=$money
                        fi

                        if [ $money -eq $win_money ]; then
                            echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                            echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                            exit 0
                        fi
                        initial_bet=$(($initial_bet*2))
                        bad_games=" "
                    fi
                else
                    echo "[-] El número que ha salido es impar, pierdes!"
                    initial_bet=$backup_bet
                    bad_games+="$random_number "
                fi
                echo -e "[=] Tines $money€\n"
                let play_counter+=1
                #sleep 1.5
            else
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo "[-] Ha salido el 0, por tanto has perdido "
                        initial_bet=$backup_bet
                        bad_games+="$random_number "
                    else
                        echo "[-] El número que ha salido es par, pierdes!"
                        initial_bet=$backup_bet
                        bad_games+="$random_number "
                    fi
                else
                    echo "[+] El número que ha salido es impar, ganas!"
                    reward=$(($initial_bet*2))
                    echo "[+] Ganas un total de $reward€"
                    money=$(($money+$reward))
                    better_game=$money
                    if [ $money -gt $better_game ]; then
                        better_game=$money
                    fi

                    if [ $money -eq $win_money ]; then
                        echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                        echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                        exit 0
                    fi
                    initial_bet=$(($initial_bet*2))
                    bad_games=" "
                fi
                echo -e "[=] Tines $money€\n"
                let play_counter+=1
            fi
        else
            echo -e "\n${redColour}[!] Te has quedado sin dinero${endColour}\n"
            echo -e "${redColour}[!] Total de jugadas: $play_counter${endColour}"
            echo -e "${redColour}[!] Total de jugadas malas: $bad_games${endColour}"
            echo -e "${redColour}[!] Mayor cantidad de dinero conseguido: $better_game${endColour}"
            exit 0
        fi
    done
}

function alembert() {
    echo -e "\n[+] Dinero actual:$money€"
    echo -ne "[+] ¿Cuánto dinero tines pensado apostar? -> " && read initial_bet
    echo -ne "[+] ¿Cuanto dinero quieres ganar? -> " && read win_money
    echo -ne "[+] ¿A qué deseas apostar continuamente (par/impar)? ->  " && read par_impar

    echo -e "[+] Vamos a jugar con una cantidad inicial de $initial_bet€ a $par_impar\n"

    backup_bet=$initial_bet
    play_counter=1
    bad_games=" "
    better_game=$initial_bet

    while true; do
        money=$(($money-$initial_bet))
        echo "[+] Acabas de apostar $initial_bet€ y tines $money€"
        random_number="$(($RANDOM % 37))"
        echo -e "[+] Ha salido el número $random_number"

        if [  "$money" -ge 0 ]; then
            if [ "$par_impar" == "par" ]; then
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo -e "[-] Ha salido el 0, por tanto has perdido"
                        initial_bet=$(($initial_bet+1))
                        bad_games+="$random_number "
                    else
                        echo "[+] El número que ha salido es par, ganas!"
                        reward=$(($initial_bet*2))
                        echo -e "[+] Ganas un total de $reward€"
                        money=$(($money+$reward))
                        better_game=$money
                        if [ $money -gt $better_game ]; then
                            better_game=$money
                        fi
                        if [ $money -eq $win_money ]; then
                            echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                            echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                            exit 0
                        fi
                        if [ $initial_bet == 1 ]; then
                            initial_bet=1
                        else
                            initial_bet=$(($initial_bet-1))
                        fi
                        bad_games=" "
                    fi
                else
                    echo -e "[-] El número que ha salido es impar, pierdes!"
                    initial_bet=$(($initial_bet+1))
                    bad_games+="$random_number "
                fi
            else
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo -e "[-] Ha salido el 0, por tanto has perdido"
                        initial_bet=$(($initial_bet+1))
                        bad_games+="$random_number "
                    else
                        echo -e "[+] El número que ha salido es par, pierdes!"
                        initial_bet=$(($initial_bet+1))
                        bad_games+="$random_number "
                    fi
                else
                    echo "[-] El número que ha salido es impar, ganas!"
                    reward=$(($initial_bet*2))
                    echo -e "[+] Ganas un total de $reward€"
                    money=$(($money+$reward))
                    better_game=$money
                    if [ $money -gt $better_game ]; then
                        better_game=$money
                    fi
                    if [ $money -eq $win_money ]; then
                        echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                        echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                        exit 0
                    fi
                    if [ $initial_bet == 1 ]; then
                        initial_bet=1
                    else
                        initial_bet=$(($initial_bet-1))
                    fi
                    bad_games=" "
                fi
            fi
            echo -e "[=] Tines $money€\n"
            let play_counter+=1
        else
            echo -e "\n${redColour}[!] Te has quedado sin dinero${endColour}\n"
            echo -e "${redColour}[!] Total de jugadas: $play_counter${endColour}"
            echo -e "${redColour}[!] Total de jugadas malas: $bad_games${endColour}"
            echo -e "${redColour}[!] Mayor cantidad de dinero conseguido: $better_game${endColour}"
            exit 0
        fi
    done
}

function inverseAlembert() {
    echo -e "\n[+] Dinero actual:$money€"
    echo -ne "[+] ¿Cuánto dinero tines pensado apostar? -> " && read initial_bet
    echo -ne "[+] ¿Cuanto dinero quieres ganar? -> " && read win_money
    echo -ne "[+] ¿A qué deseas apostar continuamente (par/impar)? ->  " && read par_impar

    echo -e "[+] Vamos a jugar con una cantidad inicial de $initial_bet€ a $par_impar\n"

    backup_bet=$initial_bet
    play_counter=1
    bad_games=" "
    better_game=$initial_bet

    while true; do
        money=$(($money-$initial_bet))
        echo "[+] Acabas de apostar $initial_bet€ y tines $money€"
        random_number="$(($RANDOM % 37))"
        echo -e "[+] Ha salido el número $random_number"

        if [  "$money" -ge 0 ]; then
            if [ "$par_impar" == "par" ]; then
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo -e "[-] Ha salido el 0, por tanto has perdido"
                        if [ $initial_bet == 1 ]; then
                            initial_bet=1
                        else
                            initial_bet=$(($initial_bet-1))
                        fi
                        bad_games+="$random_number "
                    else
                        echo "[+] El número que ha salido es par, ganas!"
                        reward=$(($initial_bet*2))
                        echo -e "[+] Ganas un total de $reward€"
                        money=$(($money+$reward))
                        better_game=$money
                        if [ $money -gt $better_game ]; then
                            better_game=$money
                        fi
                        if [ $money -eq $win_money ]; then
                            echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                            echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                            exit 0
                        fi
                        initial_bet=$(($initial_bet+1))
                        bad_games=" "
                    fi
                else
                    echo -e "[-] El número que ha salido es impar, pierdes!"
                    if [ $initial_bet == 1 ]; then
                        initial_bet=1
                    else
                        initial_bet=$(($initial_bet-1))
                    fi
                    bad_games+="$random_number "
                fi
            else
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo -e "[-] Ha salido el 0, por tanto has perdido"
                        if [ $initial_bet == 1 ]; then
                            initial_bet=1
                        else
                            initial_bet=$(($initial_bet-1))
                        fi
                        bad_games+="$random_number "
                    else
                        echo -e "[+] El número que ha salido es par, pierdes!"
                        if [ $initial_bet == 1 ]; then
                            initial_bet=1
                        else
                            initial_bet=$(($initial_bet-1))
                        fi
                        bad_games+="$random_number "
                    fi
                else
                    echo "[-] El número que ha salido es impar, ganas!"
                    reward=$(($initial_bet*2))
                    echo -e "[+] Ganas un total de $reward€"
                    money=$(($money+$reward))
                    better_game=$money
                    if [ $money -gt $better_game ]; then
                        better_game=$money
                    fi
                    if [ $money -eq $win_money ]; then
                        echo -e "\n${greenColour}[+] Total de jugadas: $play_counter${endColour}"
                        echo -e "${greenColour}[+] Has alcanzado tu objetivo de $win_money€, esta vez has tenido suerte${endColour}"
                        exit 0
                    fi
                    initial_bet=$(($initial_bet+1))
                    bad_games=" "
                fi
            fi
            echo -e "[=] Tines $money€\n"
            let play_counter+=1
        else
            echo -e "\n${redColour}[!] Te has quedado sin dinero${endColour}\n"
            echo -e "${redColour}[!] Total de jugadas: $play_counter${endColour}"
            echo -e "${redColour}[!] Total de jugadas malas: $bad_games${endColour}"
            echo -e "${redColour}[!] Mayor cantidad de dinero conseguido: $better_game${endColour}"
            exit 0
        fi
    done
}

while getopts "m:t:h" arg; do
    case $arg in
        m) money=$OPTARG;;
        t) technique=$OPTARG;;
        h) helpPanel;;
    esac
done

if [ $money ] && [ $technique ]; then

    if [ "$technique" = "martingala" ]; then
        martingala

    elif [ "$technique" = "fibonacci" ]; then
        fibonacci

    elif [ "$technique" = "alembert" ]; then
        alembert

    elif [ "$technique" = "inverseMartingala" ]; then
        inverseMartingala

    elif [ "$technique" = "inverseAlembert" ]; then
        inverseAlembert

    elif [ "$technique" = "inverseFibonacci" ]; then
        inverseFibonacci

    else
        echo -e "\n${redColour}[!] La técnica introducida no existe"
        helpPanel
    fi

else
   helpPanel
fi