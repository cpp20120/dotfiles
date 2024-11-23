awk '/[0-9]*/{print $1 ":" $2 ":" $4}')

for i in $RAWIN
do
    PID$(echo $i | cut -d: -f1)
    OWNER=$(echo $i | cut -d: f2)
    COMMAND=$(echo $i | cut -d:)
