#!/bin/bash -x
echo "WELCOME TO TIC-TAC-TOE GAME"

#VARIABLES
declare TOTAL_POSITIONS=9
declare PLAYER_LETTER=X
declare COMPUTER_LETTER=0

#DICTIONARY DECLARATION
declare -A boardChart


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
echo "RESETING THE BOARD"
toPrintTheResetBoard
echo "PLAYER LETTER is: " $PLAYER_LETTER
echo "COMPUTER LETTER is: " $COMPUTER_LETTER
