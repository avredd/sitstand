#!/bin/bash

clear

# MODIFY THESE VARIABLES

SYSSOUND="/usr/share/sounds/gnome/default/alerts/sonar.ogg" # REPLACE WITH SYSTEM SOUND PATH
NOTIFMSG="Cycle is complete!"

# OPTIONAL IFTTT INTEGRATION

IFTTTFLAG=0 # SET TO 1 TO USE
IFTTTKEY="" # IFTTT WEBHOOKS KEY
IFTTTPREMSG="Cycle is complete!" # IFTTT NOTIFICATION MESSAGE
IFTTTPOSTMSG=$(echo $IFTTTPREMSG | sed 's/ /%20/g') # DO NOT TOUCH

# VARIABLES

CYCLELEN1=${1-30}
CYCLES=${2-1}
CYCLELEN2=${3-0}
CYCLEFLAG=0
CURRENTCYCLE=${1-30}
CURRENTCYCLELEN=${1-30}
ALTCYCLEFLAG=false
STARTTIME=`date +"%r"`
OVERALLFINISH=`date -d "today + $((CYCLELEN1 * CYCLES)) minutes" +'%r'`
CYCLEFINISH=`date -d "today + ${CYCLELEN1} minutes" +'%r'` 
TOTALCYCLETIME=0

# CHECKS & CALCS

# CHECK IF CYCLES ARE RELEVANT

if [ $CYCLES -ge 2 ]
then
    CYCLEFLAG=1
fi

# CHECK IF ALT CYCLE IS RELEVANT

if [ ${CYCLELEN2} -ge 1 ]
then
    ALTCYCLEFLAG=true
fi                                                                                              
                                                                                               
# CALCULATE TOTAL CYCLE TIME IF ALTCYCLE IS ACTIVE                                                                                  

if [ ${ALTCYCLEFLAG} == true ]
then 
    for (( i=${CYCLES}; i>0; i-- ))                                                                                                                                                          
    do                                                                                                                                                                                            
        if (( $i % 2 != 0 ))                                                                                                                                                                      
        then                                                                                                                                                                                      
            TOTALCYCLETIME=$((${TOTALCYCLETIME} + ${CYCLELEN1}))                                                                                                                                  
        else                                                                                                                                                                                      
            TOTALCYCLETIME=$((${TOTALCYCLETIME} + ${CYCLELEN2}))                                                                                                                                  
        fi                                                                                                                                                                                        
    done                                                                                                                                                                                          
fi

# CALCULATE OVERALL TIME

if [ ${ALTCYCLEFLAG} == true ]
then
    OVERALLTIME=${TOTALCYCLETIME}
else
    OVERALLTIME=$(( ${CYCLELEN1} * ${CYCLES} ))
fi

# CALCULATE FINISH TIME FOR ALT CYCLES

if [ ${ALTCYCLEFLAG} == true ]
then
    OVERALLFINISH=`date -d "today + ${TOTALCYCLETIME} minutes" +'%r'`    
fi
    
# LOOPS

while [ $CYCLES -ge 1 ]
do
    # SET DYNAMIC VARIABLES

    CYCLESTART=`date +"%r"`

    # CYCLEFINISH

    if [ ${ALTCYCLEFLAG} == true ]
    then
        CYCLEFINISH=`date -d "today + ${CURRENTCYCLELEN} minutes" +'%r'`
    fi

    # RESET CYCLELENs

    CYCLELEN1=${1-30}
    CYCLELEN2=${3-0}

    while [ ${CURRENTCYCLELEN} -ge 1 ]
    do
        clear

        # OVERALL TIME KEEPING

        echo ::OVERALL::
        echo Timer began at ${STARTTIME}.                                                                     
        echo Timer finishes at ${OVERALLFINISH}.
        echo Time remaining overall: ${OVERALLTIME} min.
        echo

        # CYCLE TIME KEEPING

        if [  ${CYCLEFLAG} -ge 1 ]
        then
            echo ::CYCLES::
            echo Cycle began at ${CYCLESTART}.
            echo Cycle finishes at ${CYCLEFINISH}.
            echo Time remaining in cycle: ${CURRENTCYCLELEN} min.
        else
            sleep 0
        fi
 
        echo

         # CYCLES REMAINING                                                                           
                                                                                                              
        if [ ${CYCLES} -ge 2  ]                                                                                  
        then                                                                                                  
            echo ${CYCLES} cycles left.                                                                       
        elif [ ${CYCLEFLAG} -ge 1 ]                                                                                                 
        then
            echo This is the final cycle.                                                                   
        else
            sleep 0
        fi

        sleep 1m

        CURRENTCYCLELEN=$(( ${CURRENTCYCLELEN} - 1 ))
        OVERALLTIME=$(( ${OVERALLTIME} - 1 ))
    done

    notify-send "${NOTIFMSG}" && play -q ${SYSSOUND} &> /dev/null
    
    # IFTTT MESSAGE INTEGRATION

    if [ ${IFTTTFLAG} -ge 1 ] 
    then
        curl -s -o /dev/null "https://maker.ifttt.com/trigger/notify/with/key/${IFTTTKEY}?value1=${IFTTTPOSTMSG}"
    fi

    CYCLES=$(( ${CYCLES} - 1 ))
    
    # WORLDS MOST INEFFICIENT SWAP FOR ALT CYCLES

    if [ ${ALTCYCLEFLAG} == true ]
    then
        if [ ${CURRENTCYCLE} == ${1} ]
        then
            CURRENTCYCLELEN=${3}
            CURRENTCYCLE=${3}
        elif [ ${CURRENTCYCLE} == ${3} ]
        then
            CURRENTCYCLELEN=${1}
            CURRENTCYCLE=${1}
        else
            sleep 0
        fi
    fi
done

if [ ${CYCLES} -ge 2 ]
then 
    sleep 1s
fi

notify-send "Done!"
echo Done!
