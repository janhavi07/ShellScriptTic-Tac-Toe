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
<<<<<<< HEAD
=======
declare TRUE=1
declare FALSE=0
declare NO_OF_ROWS=3
declare NO_OF_COLUMNS=3
declare toCheckWinLoseVariable=0
>>>>>>> TicTacToeUC5

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
	echo "|" ${boardChart[4]} "|" ${boardChart[5]} "|" ${boardChart[6]} "|"
	echo "|" ${boardChart[7]} "|" ${boardChart[8]} "|" ${boardChart[9]} "|"

}
function letterToAssign()
{

	if [ $letter -eq $X_LETTER ]
        then
		 COMPUTER="O"
                 PLAYER="X"

	else
                PLAYER="O"
                COMPUTER="X"
	fi
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
<<<<<<< HEAD
	read -p "Enter the position you want to enter into: " position
}
=======
	playing=$TRUE
	while [ $playing -eq $TRUE ]
	do
		read -p "Enter the position you want to enter into: " position
		 boardChart[$position]=$PLAYER
		toDisplayBoard
		winningRow=$(checkDidHeWinOrLoseInRows)
		winningColumn=$(checkDidHeWinOrLoseInColumns)
		winningDiagonal=$(checkDidHeWinOrLoseInDiagonals)
		if [ $winningRow -eq $TRUE ] || [ $winningColumn -eq $TRUE ] || [ $winningDiagonal -eq $TRUE ]
		then
			echo "PLAYER WON "
			playing=$FALSE
			break
		fi

	done

}

function checkDidHeWinOrLoseInRows()
{
	setFlag=$FALSE
	for (( row=1; row<=$TOTAL_POSITIONS; row=$(($row+$NO_OF_ROWS))  ))
	do

		if [[ ${boardChart[$row]} == ${boardChart[$(($row+1))]} ]] && [[ ${boardChart[$row]} == ${boardChart[$(($row+2))]} ]] && [[ ${boardChart[$row]} != "_" ]]
		then
			setFlag=$TRUE
			break
		fi
	done
	if [ $setFlag -eq $TRUE ]
        then
                echo $TRUE
        else
                echo $FALSE
        fi

}
function  checkDidHeWinOrLoseInColumns()
{
	setFlag=$FALSE
	for (( column=1; column<=$NO_OF_COLUMNS; column=$(($column+1))  ))
        do
                if [[ ${boardChart[$column]} == ${boardChart[$(($column+$NO_OF_COLUMNS))]} ]] && [[ ${boardChart[$column]} == ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} ]] && [[ ${boardChart[$column]} != "_" ]]
                then
			setFlag=$TRUE
			break
                fi
        done
	if [ $setFlag -eq $TRUE ]
	then
		echo $TRUE
	else
		echo $FALSE
	fi
}

function  checkDidHeWinOrLoseInDiagonals()
{
	if [[ ${boardChart[1]} ==  ${boardChart[5]} ]] && [[  ${boardChart[1]} ==  ${boardChart[9]} ]] && [[  ${boardChart[1]} != "_" ]]
	then
		echo $TRUE
	elif [[ ${boardChart[3]} == ${boardChart[5]} ]] && [[ ${boardChart[3]} == ${boardChart[7]} ]] && [[ ${boardChart[3]} != "_" ]]
	then
		echo $TRUE
	else
		echo $FALSE
	fi

}

>>>>>>> TicTacToeUC5
function main()
{
	echo "RESETING THE BOARD"
	echo "PLAYER LETTER is: " $player
	echo "COMPUTER LETTER is: " $computer
	toToss
	echo "****DISPLAYING THE BOARD****"
	toPrintTheResetBoard
	playingLogic
}

main
