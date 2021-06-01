# sitstand

sitstand is a shell script I made to remind myself when I have had enough
sitting and when I have had enough standing.

## Running It
```
chmod +x sitstand.sh
./sitstand.sh [args]
```

## How it works

sitstand takes 0 - 3 arguments. 

Examples

`./sitstand.sh`

Initializes with just one cycle, and a default length of 30
minutes.

`./sitstand.sh 15` 

One Argument: One cycle, 15 minutes in length.

`./sitstand.sh 15 5`

Two Arguments: Fives cycles, 15 minutes in length.

`./sitstand.sh 15 5 10`

Three Arguments: Alternates between 15 and 10 minute cycles, for 5 cycles.


