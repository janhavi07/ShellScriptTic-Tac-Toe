#!/bin/bash -x 
echo "WELCOME TO TIC-TAC-TOE GAME"

#VARIABLES
declare TOTAL_POSITIONS=9
declare X_LETTER=1
declare ZERO_LETTER=0
declare HEADTOSS=1
declare TAILTOSS=0
declare letter=0
declare PLAYER=1
declare COMPUTER=2

#DICTIONARY DECLARATION
declare -A boardChart
declare -A playerChart


function toPrintTheResetBoard()
{
	for(( position=1; position<=$TOTAL_POSITIONS; position++ ))
	do
		boardChart[$position]="_"
	done
	toDisplayBoard
}

function toDisplayBoard()
{
	echo "|" ${boardChart[1]} "|" ${boardChart[2]} "|" ${boardChart[3]} "|"
	echo "|" ${boardChart[1]} "|" ${boardChart[2]} "|" ${boardChart[3]} "|"
	echo "|" ${boardChart[1]} "|" ${boardChart[2]} "|" ${boardChart[3]} "|"

}
function letterToAssign()
{

	if [ $letter -eq $X_LETTER ]
        then
		 COMPUTER="0"
                 PLAYER="X"

	else
                PLAYER="0"
                COMPUTER="X"
	fi
}

function toToss()
{
	whichLetter=$((RANDOM%2))
        if [[ $whichLetter -eq $X_LETTER ]]
        then
                letter=$X_LETTER

        else
                letter=$ZERO_LETTER
        fi

	headOrTail=$((RANDOM%2))
	if [[ $headOrTail -eq $HEADTOSS ]]
	then
		echo "PLAYER STARTS THE GAME"
		letterToAssign
	else
		echo "COMPUTER STARTS THE GAME"
		letterToAssign

	fi
}

function playingLogic()
{
	read -p "Enter the position you want to enter into: " position
}
function main()
{
	echo "RESETING THE BOARD"
	echo "PLAYER LETTER is: " $player
	echo "COMPUTER LETTER is: " $computer
	toToss
	echo "****DISPLAYING THE BOARD****"
	toPrintTheResetBoard
}

main
