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
declare TRUE=1
declare FALSE=0
declare NO_OF_ROWS=3
declare NO_OF_COLUMNS=3
declare toCheckWinLoseVariable=0
declare winningPositionOfRows=0
declare oneWhoIsPlaying=0
declare winningPositionOfColumn=0
declare winningPositionOfDiagonal=0 

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
	winningConditionCounter=0
	playing=$TRUE
	oneWhoIsPlaying=$PLAYER
	while [ $playing -eq $TRUE ]
	do
		read -p "Enter the position to enter into: " position
	 	boardChart[$position]=$oneWhoIsPlaying
		((winningConditionCounter++))
		toDisplayBoard
		echo "............."
		if [ $winningConditionCounter -ge 3 ]
                then
                        winningPositionOfRows=$(toCheckWinningConditionInRows)
			winningPositionOfColumn=$(toCheckWinningConditionInColumns)
			winningPositionOfDiagonal=$(toCheckWinningConditionInDiagonals)
			if [ $winningPositionOfRows -gt $FALSE ]
			then
				boardChart[$winningPositionOfRows]=$COMPUTER
			elif [ $winningPositionOfColumn -gt $FALSE ]
			then
				boardChart[$winningPositionOfColumn]=$COMPUTER
			elif [ $winningPositionOfDiagonal -gt $FALSE ]
			then
				boardChart[$winningPositionOfDiagonal]=$COMPUTER
			fi
			toDisplayBoard
			oneWhoIsPlaying=$COMPUTER
                fi
		winningRow=$(checkDidHeWinOrLoseInRows)
		winningColumn=$(checkDidHeWinOrLoseInColumns)
		winningDiagonal=$(checkDidHeWinOrLoseInDiagonals)
		if [ $winningRow -eq $TRUE ] || [ $winningColumn -eq $TRUE ] || [ $winningDiagonal -eq $TRUE ]
		then
			echo  "WON "
			playing=$FALSE
			break
		fi
		toCheckTheNextWhoIsPlaying
	done
}

function toCheckTheNextWhoIsPlaying()
{
	if [ $oneWhoIsPlaying == $PLAYER ]
                then
                        oneWhoIsPlaying=$COMPUTER
                else
                        oneWhoIsPlaying=$PLAYER
                fi

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


function toCheckWinningConditionInRows()
{
	flag=$FALSE
	for (( row=1; row<=TOTAL_POSITIONS; row=$(($row+$NO_OF_ROWS)) ))
	do
		if [ ${boardChart[$row]} == ${boardChart[$(($row+1))]} ] && [ ${boardChart[$row]} != "_" ] && [ ${boardChart[$(($row+2))]} != $COMPUTER ]
		then
			flag=$TRUE
			echoThis=$((row+2))
			echo $echoThis
			break
		elif [ ${boardChart[$row]} == ${boardChart[$(($row+2))]} ] && [ ${boardChart[$(($row+2))]} != "_" ] && [ ${boardChart[$(($row+1))]} != $COMPUTER ]
		then
			flag=$TRUE
			echoThis=$(($row+1))
			echo $echoThis
			break
		elif [ ${boardChart[$(($row+2))]} == ${boardChart[$(($row+1))]} ] && [ ${boardChart[$(($row+1))]} != "_" ] && [ ${boardChart[$row]} != $COMPUTER ]
		then
			flag=$TRUE
			echo $row
			break
		fi
	done
	if [ $flag -ne $TRUE ]
	then
		echo $FALSE
	fi
}

function toCheckWinningConditionInColumns()
{
	flag=$FALSE
	for (( column=1; column<=$NO_OF_COLUMNS; column=$(($column+1)) ))
	do
		if [ ${boardChart[$column]} == ${boardChart[$(($column+$NO_OF_COLUMNS))]} ] && [ ${boardChart[$column]} != "_" ] && [ ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} != $COMPUTER ]
		then
			flag=$TRUE
			echoThis=$(($column+$((2*$NO_OF_COLUMNS))))
			echo $echoThis
			break
		elif [ ${boardChart[$column]} == ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} ] && [ ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} != "_" ] && [ ${boardChart[$(($column+$NO_OF_COLUMNS))]} != $COMPUTER ]
		then
			flag=$TRUE
			echoThis=$(($column+$NO_OF_COLUMNS))
			echo $echoThis
			break
		elif [ ${boardChart[$(($column+$NO_OF_COLUMNS))]} == ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} ] && [ ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} != "_" ] && [ ${boardChart[$column]} != $COMPUTER ]
		then
			flag=$TRUE
			echo $column
			break
		fi
	done
	if [ $flag -ne $TRUE ]
        then
                echo $FALSE
        fi

}

function toCheckWinningConditionInDiagonals()
{
	if [ ${boardChart[1]} ==  ${boardChart[5]} ] && [ ${boardChart[5]} != "_" ] && [ ${boardChart[9]} != $COMPUTER ]
	then
		echoThis=9
		echo $echoThis
	elif [ ${boardChart[1]} == ${boardChart[9]} ] && [ ${boardChart[9]} != "_" ] && [ ${boardChart[5]} != $COMPUTER ]
	then
		echoThis=5
		echo $echoThis
	elif [ ${boardChart[9]} == ${boardChart[5]} ] && [ ${boardChart[9]} != "_" ] && [ ${boardChart[1]} != $COMPUTER ]
	then
		echoThis=1
		echo $echoThis
	 elif [ ${boardChart[3]} == ${boardChart[7]} ] && [ ${boardChart[3]} != "_" ] && [ ${boardChart[5]} != $COMPUTER ]
         then
                echoThis=5
                echo $echoThis
	 elif [ ${boardChart[7]} == ${boardChart[5]} ] && [ ${boardChart[5]} != "_" ] && [ ${boardChart[3]} != $COMPUTER ]
         then
                echoThis=3
                echo $echoThis
	 elif [ ${boardChart[3]} == ${boardChart[5]} ] && [ ${boardChart[3]} != "_" ] && [ ${boardChart[7]} != $COMPUTER ]
         then
                echoThis=7
                echo $echoThis
	 else
		echo $FALSE
	 fi
}

function mainfunction()
{
	echo "RESETING THE BOARD"
	toToss
	echo "PLAYER LETTER is: " $PLAYER
        echo "COMPUTER LETTER is: " $COMPUTER
	echo "****DISPLAYING THE BOARD****"
	toPrintTheResetBoard
	playingLogic
	echo "THANKYOU"
}

mainfunction
