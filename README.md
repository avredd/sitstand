# sitstand

sitstand is a poorly assembled shell script I made to remind myself when I've had enough
sitting and when I've had enough standing. It can function as a regular timer, a timer with multiple cycles, or a timer with cycles of alternating length. It sends desktop notifications, plays a noitification sound, and pushes a notification to my phone via IFTTT.

## Running It
```
chmod +x sitstand.sh
./sitstand.sh [args]
```

Press CTRL + C to exit the script at any time.

Some variables should be modified before executing for best functionality.
Script can send IFTTT notifications if you have a webhooks notification set up
and a key for it to use.

## How it works

sitstand takes 0 - 3 arguments.

1. Cycle Length
1. Number of Cycles
1. Alternate Cycle Length

### Examples

*input*
`./sitstand.sh`

*output*
```
::OVERALL::
Timer began at 09:22:45 AM.
Timer finishes at 09:52:45 AM.
Time remaining overall: 30 min.
```

*description*
Initializes with just one cycle, and a default length of 30
minutes.


*input*
`./sitstand.sh 15` 

*output*
```
::OVERALL::
Timer began at 09:25:30 AM.
Timer finishes at 09:40:30 AM.
Time remaining overall: 15 min.
```

*description*
One Argument: One cycle, 15 minutes in length.


*input*
`./sitstand.sh 15 5`

*output*
```
::OVERALL::
Timer began at 09:26:30 AM.
Timer finishes at 10:41:30 AM.
Time remaining overall: 75 min.

::CYCLES::
Cycle began at 09:26:30 AM.
Cycle finishes at 09:41:30 AM.
Time remaining in cycle: 15 min.

5 cycles left.
```

*description*
Two Arguments: Five cycles, 15 minutes in length.


*input*
`./sitstand.sh 15 5 10`

*output*
```
::OVERALL::
Timer began at 09:27:25 AM.
Timer finishes at 10:32:25 AM.
Time remaining overall: 65 min.

::CYCLES::
Cycle began at 09:27:25 AM.
Cycle finishes at 09:42:25 AM.
Time remaining in cycle: 15 min.

5 cycles left.
```

*description*
Three Arguments: Alternates between 15 and 10 minute cycles, for 5 cycles.


