#! /bin/bash

# Kjører hele simulasjonen med resultat videoer, og avviksberegning

depend() {
	command -v $1 >/dev/null 2>&1 || {
		echo "This script requires $1, but it's not installed. Aborting." >&2
		exit 1
	}
}

# Sjekk om vi har alle programmer som er nødvendige
depend avconv
depend awk
depend cp
depend find
depend gfortran
depend gnuplot
depend ls
depend make
depend mv
depend rm
depend vlc
depend wc

# Forsikre at temp mappa eksisterer
if ! [ -d temp ]; then
	mkdir temp
fi

# Forsikre at den nyeste versjonen er laget
make

# Print alle input variabler til en fil, som pipes til nstokes
echo "Running the simulation, hold on..."
# To argument eller flere betyr at input er gitt via kommandolinje
if [ $# -gt 2 ]; then
	truncate -s 0 input
	for i in $@; do
		echo $i >> input
	done
# Dersom ett argument er gitt, er dette en fil eller fifo
elif [ $# -eq 1 ]; then
	if ! [ -f "$1" ]; then
		echo "Can't find the file specified"
		exit 2
	fi
	./nstokes < "$1" > output
else
	# Ellers kjører vi bare med gammel input
	./nstokes < input > output
fi
echo "Done with the simulation, processing data..."

# Dersom nstokes feilet, avslutter vi skriptet. Det skjer hvis vi får NaN for eksempel.
if [ $? -ne 0 ]; then
	echo "Invalid input, try adjusting dt and n to be lower"
	exit 2
fi

# Kjør plotting parallellt
cd velocities
./everything.sh &

cd ../pressures
./everything.sh &

cd ../streams
./everything.sh

# Vent til plottingen er ferdig
while [ $(jobs | wc -l) -gt 0 ]; do
	jobs > /dev/null
	sleep 0.1
done

cd ..

# Beregn den absolutte og relative forskjellen fra matlab
# Det blir store avvik dersom vi ikke bruker 12-20-12-20 boksen, det er fordi
# matlab bare ble kjørt med 12-20-12-20 boksen. Vi har ikke annet å sammenligne med
echo Computing differences with conventional 12-20-12-20 matlab answer
echo Note: these are very much not meaningful when not comparing standard
./matrix_to_image.awk output
./compare.sh > temp/differences
./average.awk temp/differences > temp/avg_differences
cat temp/avg_differences
cp temp/avg_differences generated/avg_differences
