#!/bin/bash -x 
echo "WELCOME TO TIC-TAC-TOE GAME"

#VARIABLES
declare TOTAL_POSITIONS=9
declare X_LETTER=1
declare ZERO_LETTER=0
declare HEADTOSS=1
declare TAILTOSS=0
declare PLAYER=1
declare COMPUTER=2
declare TRUE=1
declare FALSE=0
declare NO_OF_ROWS=3
declare NO_OF_COLUMNS=3
declare MIDDLE_POSITION=5
declare NO_OF_TIMES_AFTER_WHICH_COMPUTER_WILL_PLAY_ITSELF=3

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
	local letter=0
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
	local blockingConditionCounter=0
	local positionsOccupiedCounter=0
	local noPosition=0
	playing=$TRUE
	oneWhoIsPlaying=$PLAYER
	while [ $playing -eq $TRUE ]
	do
		read -p "Enter the position to enter into: " position
	 	boardChart[$position]=$oneWhoIsPlaying
		((blockingConditionCounter++))
		toDisplayBoard
		echo "............."
		if [ $blockingConditionCounter -ge $NO_OF_TIMES_AFTER_WHICH_COMPUTER_WILL_PLAY_ITSELF ]
                then
			((positionsOccupiedCounter++))
                        echo $positionsOccupiedCounter
                        toBlockPlayerFromWinning
                fi
		toCheckHasAnyOneWonTheGame
		toCheckTheNextWhoIsPlaying
	done
}

function toCheckHasAnyOneWonTheGame()
{
	local winningRow=$(checkDidHeWinOrLoseInRows)
        local winningColumn=$(checkDidHeWinOrLoseInColumns)
        local winningDiagonal=$(checkDidHeWinOrLoseInDiagonals)
	((positionsOccupiedCounter++))
         echo $positionsOccupiedCounter

        if [ $winningRow -eq $TRUE ]
        then
        	echo  "WON "
        	playing=$FALSE
        	break
        elif [ $winningColumn -eq $TRUE ] 
        then
        	echo  "WON "
        	playing=$FALSE
        	break
        elif [ $winningDiagonal -eq $TRUE ]
        then
        	echo  "WON "
        	playing=$FALSE
        	break
        elif [ $positionsOccupiedCounter -eq $TOTAL_POSITIONS ]
        then
        	echo "DRAWS THE GAME"
		playing=$FALSE
        	break
        fi


}

function toBlockPlayerFromWinning()
{
	 local blockingPositionInRows=$(toCheckBlockingConditionInRows)
         local blockingPositionInColumn=$(toCheckBlockingConditionInColumns)
         local blockingPositionInDiagonal=$(toCheckBlockingConditionInDiagonals)
         if [ $blockingPositionInRows -ne $noPosition ]
         then
         	boardChart[$blockingPositionInRows]=$COMPUTER
         elif [ $blockingPositionInColumn -ne $noPosition ]
         then
         	boardChart[$blockingPositionInColumn]=$COMPUTER
         elif [ $blockingPositionInDiagonal -ne $noPosition ]
         then
         	boardChart[$blockingPositionInDiagonal]=$COMPUTER
         else
         	toCheckSidesCornerMiddlePositions
         fi
         toDisplayBoard
         oneWhoIsPlaying=$COMPUTER


}

function toCheckSidesCornerMiddlePositions()
{
        local positionsInCorner=$(toCheckAvailableCorners)
        local sidesLeft=$(toCheckAvailableSides)
        local middlePositionLeft=$(toCheckMiddlePosition)
        if [ $positionsInCorner -ne $noPosition ]
        then

                boardChart[$positionsInCorner]=$COMPUTER
        elif [ $middlePositionLeft -ne $noPosition ]
        then
                boardChart[$middlePositionLeft]=$COMPUTER
        elif [ $sidesLeft -ne $noPosition ]
        then
                boardChart[$sidesLeft]=$COMPUTER
        fi
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


function toCheckBlockingConditionInRows()
{
	flag=$FALSE
	for (( row=1; row<=TOTAL_POSITIONS; row=$(($row+$NO_OF_ROWS)) ))
	do
		if [ ${boardChart[$row]} == ${boardChart[$(($row+1))]} ] && [ ${boardChart[$row]} != "_" ] && [ ${boardChart[$(($row+2))]} != $COMPUTER ] && [ ${boardChart[$(($row+2))]} != $PLAYER ] 
		then
			flag=$TRUE
			echoThis=$((row+2))
			echo $echoThis
			break
		elif [ ${boardChart[$row]} == ${boardChart[$(($row+2))]} ] && [ ${boardChart[$(($row+2))]} != "_" ] && [ ${boardChart[$(($row+1))]} != $COMPUTER ] && [ ${boardChart[$(($row+1))]} != $PLAYER ]
		then
			flag=$TRUE
			echoThis=$(($row+1))
			echo $echoThis
			break
		elif [ ${boardChart[$(($row+2))]} == ${boardChart[$(($row+1))]} ] && [ ${boardChart[$(($row+1))]} != "_" ] && [ ${boardChart[$row]} != $COMPUTER ] && [ ${boardChart[$row]} != $PLAYER ]
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

function toCheckBlockingConditionInColumns()
{
	flag=$FALSE
	for (( column=1; column<=$NO_OF_COLUMNS; column=$(($column+1)) ))
	do
		if [ ${boardChart[$column]} == ${boardChart[$(($column+$NO_OF_COLUMNS))]} ] && [ ${boardChart[$column]} != "_" ] && [ ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} != $COMPUTER ] && [ ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} != $PLAYER ]
		then
			flag=$TRUE
			echoThis=$(($column+$((2*$NO_OF_COLUMNS))))
			echo $echoThis
			break
		elif [ ${boardChart[$column]} == ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} ] && [ ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} != "_" ] && [ ${boardChart[$(($column+$NO_OF_COLUMNS))]} != $COMPUTER ] && [ ${boardChart[$(($column+$NO_OF_COLUMNS))]} != $PLAYER ]
		then
			flag=$TRUE
			echoThis=$(($column+$NO_OF_COLUMNS))
			echo $echoThis
			break
		elif [ ${boardChart[$(($column+$NO_OF_COLUMNS))]} == ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} ] && [ ${boardChart[$(($column+$((2*$NO_OF_COLUMNS))))]} != "_" ] && [ ${boardChart[$column]} != $COMPUTER ] && [ ${boardChart[$column]} != $PLAYER ]
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

function toCheckAvailableCorners()
{

        if [ ${boardChart[1]} == "_" ]
        then
                echoThis=1
                echo $echoThis
        elif [ ${boardChart[3]} == "_" ]
        then
                echoThis=3
                echo $echoThis
        elif [ ${boardChart[7]} == "_" ]
        then
                echoThis=7
                echo $echoThis
        elif [ ${boardChart[9]} == "_" ]
        then
                echoThis=9
                echo $echoThis
	else
		echoThis=$FALSE
		echo $echoThis
        fi
}

function toCheckMiddlePosition()
{
        if [[ $boardChart[$MIDDLE_POSITON] == "_" ]]
	then
		echo $MIDDLE_POSITION
	else
		echo $FALSE
	fi

}


function toCheckBlockingConditionInDiagonals()
{
	if [ ${boardChart[1]} ==  ${boardChart[5]} ] && [ ${boardChart[5]} != "_" ] && [ ${boardChart[9]} != $COMPUTER ] && [ ${boardChart[9]} != $PLAYER ]
	then
		echoThis=9
		echo $echoThis
	elif [ ${boardChart[1]} == ${boardChart[9]} ] && [ ${boardChart[9]} != "_" ] && [ ${boardChart[5]} != $COMPUTER ] && [ ${boardChart[5]} != $PLAYER ]
	then
		echoThis=5
		echo $echoThis
	elif [ ${boardChart[9]} == ${boardChart[5]} ] && [ ${boardChart[9]} != "_" ] && [ ${boardChart[1]} != $COMPUTER ] && [ ${boardChart[1]} != $PLAYER ]
	then
		echoThis=1
		echo $echoThis
	elif [ ${boardChart[3]} == ${boardChart[7]} ] && [ ${boardChart[3]} != "_" ] && [ ${boardChart[5]} != $COMPUTER ] && [ ${boardChart[5]} != $PLAYER ]
        then
                echoThis=5
                echo $echoThis
	elif [ ${boardChart[7]} == ${boardChart[5]} ] && [ ${boardChart[5]} != "_" ] && [ ${boardChart[3]} != $COMPUTER ] && [ ${boardChart[3]} != $PLAYER ]
        then
                echoThis=3
                echo $echoThis
	elif [ ${boardChart[3]} == ${boardChart[5]} ] && [ ${boardChart[3]} != "_" ] && [ ${boardChart[7]} != $COMPUTER ] && [ ${boardChart[7]} != $PLAYER ]
        then
                echoThis=7
                echo $echoThis
	else
		echo $FALSE
	fi
}

function toCheckAvailableSides()
{
        if [ ${boardChart[2]} == "_" ]
        then
                echoThis=2
                echo $echoThis
        elif [ ${boardChart[6]} == "_" ]
        then
                echoThis=6
                echo $echoThis
        elif [ ${boardChart[4]} == "_" ]
        then
                echoThis=4
                echo $echoThis
        elif [ ${boardChart[8]} == "_" ]
        then
                echoThis=8
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
