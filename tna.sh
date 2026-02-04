#!/usr/bin/env bash
#
# Author: Unpwnabl <https://www.github.com/unpwnabl>
# Date: 04/02/2026
# License: GPL-3.0

# If your terminal doesn't recognize this escape code sequence, 
# then change it and it will apply top all
escape="\033"

speed=0.125

for i in "$@"; do
	case $i in
		-h|--help)
			echo -e "Usage:\n\t-h, --help\t\t\t\tDisplay this message\n\t-s=[option], --speed=[option]\t\tSet refresh speed\n\t-e=[option], --escape-code=[option]\tSet the ANSI escape code\n\t\t\t\t\t\tdefault = '\\\033'"
			exit
			;;
		-s=*|--speed=*)
			speed="${i#*=}"
			shift
			;;
		-e=*|--escape-code=*)
			escape="${i#*=}"
			shift
			;;
		-*|--*)
			echo "Error: Unrecognized option $i. Please use \"-h\" or \"--help\" for more informations"
			exit 1
			;;
		*)
			;;
	esac
done

# Restore terminal when exiting
cleanup() {
	# Show cursor
	echo -e "$escape[?25h"
	# Print without colors
	echo -e "$escape[0m"
}

# Be sure no matter how we exit, we do clean up
trap cleanup EXIT

# Colors of each nucleobase
a=$(echo -e "$escape[38;5;28m")
t=$(echo -e "$escape[38;5;213m")
c=$(echo -e "$escape[38;5;198m")
g=$(echo -e "$escape[38;5;26m")

# Base color
col=$(echo -e "$escape[38;5;240m")
tcol=$(echo -e "$escape[38;5;255m")

# Generate frames
frames=( )
# Avoid deleting spaces
IFS=""
while read -r line; do
	# If it"s not a End-Of-DNA (hehe)
	if [[ $line != "eod" ]]; then
		# Substitute the corresponding character to the tput color
		line=$col$line
		line=${line//a/${a}a${col}}
		line=${line//t/${t}t${col}}
		line=${line//c/${c}c${col}}
		line=${line//g/${g}g${col}}
		line=${line//A/${a}A${col}}
		line=${line//T/${t}T${col}}
		line=${line//C/${c}C${col}}
		line=${line//G/${g}G${col}}
	fi
	frames+=( $line )
done < dna.txt

# Generate text
# Thank wikipedia for the brief description (https://en.wikipedia.org/wiki/DNA)
text_arr=("Deoxyribonucleic acid is a polymer composed of" "two polynucleotide chains that coil around each other" "to form a double helix." "The four bases found in DNA are adenine (A), cytosine (C)," "guanine (G) and thymine (T).")
script_arr=( )
for line in ${text_arr[@]}; do
	line=$tcol$line
	line=${line//adenine/${a}adenine${tcol}}
	line=${line//thymine/${t}thymine${tcol}}
	line=${line//cytosine/${c}cytosine${tcol}}
	line=${line//guanine/${g}guanine${tcol}}
	line=${line//\(A\)/\(${a}A${tcol}\)}
	line=${line//\(T\)/\(${t}T${tcol}\)}
	line=${line//\(C\)/\(${c}C${tcol}\)}
	line=${line//\(G\)/\(${g}G${tcol}\)}
	script_arr+=( $line )
done

# Hide cursor
echo -e "$escape[?25l"

clear

line=0
l_it=0
x=6
y=25
while true; do
	for i in ${!frames[@]}; do
		if [[ -n $frames[$i] ]]; then
			# If it"s an End-Of-DNA, we sleep, clear and repeat
			if [[ ${frames[$i]} == "eod" ]]; then
				sleep $speed
				clear
				((line=0))
				((l_it=0))
			else 
				((line++))
				# Else it"s a line and we echo it
				echo "${frames[$i]}"
				# Concurrently, we also write the script to avoid flashes 
				# between the time it takes to print out the whole image
				# and the one it takes to print out the text
				if [[ $line -ge $x ]]; then
					echo -e "$escape[${line};${y}H${script_arr[$l_it]}$escape[0m"
					((l_it++))
				fi	
			fi
		fi
	done
done
