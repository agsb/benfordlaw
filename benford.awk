#/*
# *  DISCLAIMER
# *
# *  Copyright © 2020, Alvaro Gomes Sobral Barcellos,
# *
# *  Permission is hereby granted, free of charge, to any person obtaining
# *  a copy of this software and associated documentation files (the
# *  "Software"), to deal in the Software without restriction, including
# *  without limitation the rights to use, copy, modify, merge, publish,
# *  distribute, sublicense, and/or sell copies of the Software, and to
# *  permit persons to whom the Software is furnished to do so, subject to
# *  the following conditions"
# *
# *  The above copyright notice and this permission notice shall be
# *  included in all copies or substantial portions of the Software.
# *
# *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# *  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# *  NON INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# *  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# *  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# *
# *  //-\--/\-//-\/-/\\\\/-\--\\\-///\-/-/\/--/\\\\/-\-//-/\//-/\//--//-///--\\\-///\-/-/\/
# */

# author: Alvaro G. S. Barcellos, 2021
#
#	parses a csv numeric file and for each field count the frequency of first digits
#
# Benford Law, first digit theorical values, digits 0 to 9, 
# zero included for aestetics
# 0.0, 30.10, 17.60, 12.50, 9.69, 7.92, 6.69, 5.80, 5.12, 4.58
#
# for deal with float separator wise use as: "LC_ALL=c awk -f" for period
#

BEGIN { 

	FS = "," 	
	ORS = " "

# theorical values

	p[0][1] = 30.10
	p[0][2] = 17.60 
	p[0][3] = 12.50
	p[0][4] =  9.69
	p[0][5] =  7.92
	p[0][6] =  6.69
	p[0][7] =  5.80
	p[0][8] =  5.12
	p[0][9] =  4.58
	
	mm = 0
}

{
 
# escape all empty lines
if ( !NF ) {
	next
	}

# escape header first line
if (NR == 1) {
	#print $0
	#print "\n"
	next
	}

# for each field
for (i = 1; i <= NF; i++) {
# split first digit 
	n = log($i)
	n = n - int (n)
	n = int (10 ** n)
# and count occurences
	m[i][n] = m[i][n] + 1
	}

# count for percentuals
mm = mm + 1
}

END {

# print values
for (j = 1; j <= 9; j++) {
	
# print digit and theorical value
	printf ("%2d %5.3f ",j,p[0][j])

# for each field
	for (i = 1; i <= NF; i++) {

		p[i][j] = m[i][j] / mm * 100.0

# print digit and observed value
		printf ("%-5.3f ",p[i][j])

		}
	
# next line
	printf ("\n"); 
	
	}

};


