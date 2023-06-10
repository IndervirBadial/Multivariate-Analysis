proc import out=T820 datafile="/home/u57771545/Mydata/T8-6DATcsv.csv"
dbms=csv replace;
run;
proc princomp data=T820 out=PC;
var VAR2-VAR9;
run;
proc corr data=PC;
VAR VAR2-VAR9;
with prin1 prin2;
run;
data ranked;
set PC;
keep VAR1 Prin1;
run;
proc sort data=ranked;
by Prin1;
run;
proc print data=ranked;
run;

*8.21;
data converted;
set T820;
VAR2=100/VAR2;
VAR3=200/VAR3;
VAR4=400/VAR4;
VAR5=800/(VAR5*60);
VAR6=1500/(VAR6*60);
VAR7=5000/(VAR7*60);
VAR8=10000/(VAR8*60);
VAR9=42195/(VAR9*60);
run; 
proc princomp cov data=converted out=PC1;
var VAR2-VAR9;
run;
proc corr data=PC1;
VAR VAR2-VAR9;
with prin1 prin2;
run;
data ranked1;
set PC1;
keep VAR1 Prin1;
run;
proc sort data=ranked1;
by Prin1;
run;
proc print data=ranked1;
run;

*9.20;
data table15;
input V1  V2  V3  V4  V5  V6  V7;
datalines;
  8  98  7  2  12  8  2
  7  107  4  3  9  5  3
  7  103  4  3  5  6  3
  10  88  5  2  8  15  4
  6  91  4  2  8  10  3
  8  90  5  2  12  12  4
  9  84  7  4  12  15  5
  5  72  6  4  21  14  4
  7  82  5  1  11  11  3
  8  64  5  2  13  9  4
  6  71  5  4  10  3  3
  6  91  4  2  12  7  3
  7  72  7  4  18  10  3
  10  70  4  2  11  7  3
  10  72  4  1  8  10  3
  9  77  4  1  9  10  3
  8  76  4  1  7  7  3
  8  71  5  3  16  4  4
  9  67  4  2  13  2  3
  9  69  3  3  9  5  3
  10  62  5  3  14  4  4
  9  88  4  2  7  6  3
  8  80  4  2  13  11  4
  5  30  3  3  5  2  3
  6  83  5  1  10  23  4
  8  84  3  2  7  6  3
  6  78  4  2  11  11  3
  8  79  2  1  7  10  3
  6  62  4  3  9  8  3
  10  37  3  1  7  2  3
  8  71  4  1  10  7  3
  7  52  4  1  12  8  4
  5  48  6  5  8  4  3
  6  75  4  1  10  24  3
  10  35  4  1  6  9  2
  8  85  4  1  9  10  2
  5  86  3  1  6  12  2
  5  86  7  2  13  18  2
  7  79  7  4  9  25  3
  7  79  5  2  8  6  2
  6  68  6  2  11  14  3
  8  40  4  3  6  5  2
; 
proc princomp cov data=table15;
Var V1 V2 V5 V6;
run;


PROC FACTOR METHOD=prin NFACT=1 cov data=table15;
Var V1 V2 V5 V6;
run;

PROC FACTOR METHOD=prin NFACT=2 cov data=table15;
Var V1 V2 V5 V6;
run;

*b;
PROC FACTOR METHOD=prin NFACT=1 cov rotate=varimax data=table15;
Var V1 V2 V5 V6;
run;

PROC FACTOR METHOD=prin NFACT=2 cov rotate=varimax data=table15;
Var V1 V2 V5 V6;
run;