CSL302 Compiler Design Lab Exam -1 
NAME: ASHISH RANJAN
ID: 12340370

General Guidelines:

**USAGE**: (All three usage work perfectly with this code)

./q1 < [filename]
./q1 [filename]
./q1             {then enter the input line by line }


INFO ABOUT CODE:
Q1:
The rule matches evrything as specified if there is non numeric format it says invalid if the length is more than required it says invalid.
we matched the numeric input char-by-char acc to the set of given rules,
We have added the case where the number of digits is 9 or more to give error directly as required it cant be more than 8
if the rule mismatches it says at the end invalid as required. otherwise it says the requirewd token.


FILES STRUCTURING:

12340370_ASHISH_RANJAN_LabExam1/Q1/q1.l (Lexical Analyser)
                                 /lex.yy.c (Compiled C File)
                                 /input.txt (Sample Input File)
                                 /q1    (Executable File)
                                 /readme1.txt (README File)
