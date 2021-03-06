#! /bin/bash

# Lag en begin + includegraphics + end for hvert bilde i generated

for i in generated/*.png; do
	echo '\begin{center}'
	echo '\includegraphics[width=7in]{'"$i"'}'
	echo "$i" | sed 's/_/\\textunderscore /g'
	if [ -f "${i%.png}".comment ]; then
		printf '\n'
		cat "${i%.png}".comment
	fi
	echo '\end{center}'
done
