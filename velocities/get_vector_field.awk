#! /usr/bin/awk -f

# Henter vektor feltet fra stdin og printer det til stdout

BEGIN { on = 0; number = 0; }
/# END VECTOR FIELD/ {
	number += 1;
	on = 0;
}
// {
	if (on == 1) {
		print;
	}
}
/# BEGIN VECTOR FIELD/ {
	on = 1;
	print "# Frame", number;
}
END { print "# Generated", number, "sequence(s)"; }
