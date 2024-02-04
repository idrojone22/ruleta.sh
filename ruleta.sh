#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){

    echo -e "\n\n${redColour}[!] Saliendo...\n"
    # tiput cnrom # mosrar el cursor
    exit 1
}

# Ctrl+C
trap ctrl_c INT

function helpPanel(){
    echo -e "\n[!] Uso: $0\n"
    echo -e "\t -m) Dinero con el que se desea jugar"
    echo -e "\t -t) Técnica a utilizar (martingala /inverselabrouchere)"
    exit 1
}

function martingala(){
    echo -e "\n[+] Dinero actual:$money€"
    echo -ne "[+] ¿Cuánto dinero tines pensado apostar? -> " && read initial_bet
    echo -ne "[+] ¿A qué deseas apostar continuamente (par/impar)? ->  " && read par_impar

    echo -e "[+] Vamos a jugar con una cantidad inicial de $initial_bet€ a $par_impar\n"

    backup_bet=$initial_bet
    play_counter=1
    bad_games=" "
    better_game=$initial_bet

    # tput civis # Ocultar el cursor
    while true; do
        money=$(($money-$initial_bet))
        echo "[+] Acabas de apostar $initial_bet€ y tines $money€"
        random_number="$(($RANDOM % 37))"
        echo -e "[+] Ha salido el número $random_number"

        if [  "$money" -gt 0 ]; then

            if [ "$par_impar" == "par" ]; then 

                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo "[+] Ha salido el 0, por tanto has perdido "
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
                        initial_bet=$backup_bet
                        bad_games=" "
                    fi
                else
                    echo "[+] El número que ha salido es impar, pierdes!"
                    initial_bet=$(($initial_bet*2))
                    bad_games+="$random_number "
                fi
                echo -e "[+] Tines $money€\n"
                let play_counter+=1
                sleep 1.5
            else
                if [ "$par_impar" == "impar" ]; then 

                    if [ ! "$(($random_number % 2))" -eq 0 ]; then
                        if [ "$random_number" -eq 0 ]; then
                            echo "[+] Ha salido el 0, por tanto has perdido "
                        else
                            echo "[+] El número que ha salido es impar, ganas!"
                            reward=$(($initial_bet*2))
                            echo "[+] Ganas un total de $reward€"
                            money=$(($money+$reward))
                            initial_bet=$backup_bet
                        fi
                    else
                        echo "[+] El número que ha salido es par, pierdes!"
                        initial_bet=$(($initial_bet*2))
                    fi
                    echo -e "[+] Tines $money€\n"
                    let play_counter+=1
                    sleep 1
                fi
            fi
        else
            # Nos quedamos sin dinero
            echo -e "\n${redColour}[!] Te has quedado sin dinero${endColour}\n"
            echo -e "${redColour}[!] Total de jugadas: $play_counter${endColour}"
            echo -e "${redColour}[!] Total de jugadas malas: $bad_games${endColour}"
            echo -e "${redColour}[!] Mayor cantidad de dinero conseguido: $better_game${endColour}"
            # tput cnrom;
            exit 0
        fi
    done

    # tiput cnorm # mostrar el cursor 
}

while getopts "m:t:h" arg; do 
    case $arg in
        m) money=$OPTARG;;
        t) technique=$OPTARG;;
        h) helpPanel;;
    esac
done

if [ $money ] && [ $technique ]; then
    if [ "$technique" == "martingala" ]; then
        martingala
    else
        echo -e "\n${redColour}[!] La técnica introducida no exsiste"
        helpPanel
    fi
else 
    helpPanel
fi