CSL302 Compiler Design Lab Exam -1 
NAME: ASHISH RANJAN
ID: 12340370

General Guidelines:

**USAGE**: (All three usage work perfectly with this code)

./q2 < [filename]
./q2 [filename]
./q2             {then enter the input line by line }


INFO ABOUT CODE

Q2: 
The rule matches evrything as specified by the question2 printing the required token name.
For matching the delimeter ; and ignore the line afterwars we have dealt it separetly matchiing thr ; and reading and ignoring characters till we encounter a \n
If the symbol does not match anywhere acc to our rules its reported as ERRORS in the end 
We have hardcoded generarll few errros so that if something begins with lowercase or if something start with numeric thing.
If the error lies out of these things it will still be reported as error using the last matching.


FILES STRUCTURING:

12340370_ASHISH_RANJAN_LabExam1/Q2/q2.l (Lexical Analyser)
                                 /lex.yy.c  (Compiled C File)
                                 /input.txt  (Sample Input File)
                                 /q2   (Executable File)
                                 //readme2.txt (README File)


