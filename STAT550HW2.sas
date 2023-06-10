*4.26a;
data table426;
input age price;
datalines;
1 18.95
2 19
3 17.95
3 15.54
4 14
5 12.95
6 8.94
8 7.49
9 6
11 3.99
;
proc summary data=table426 mean print;
var age price;
run;

proc corr data=table426 noprob nosimple outp=OutCorr /** store results **/
          cov;   /**  include covariances **/
var age price;
run;
*5.1;
data fivepointone;
input one two;
datalines;
2 12
8 9
6 9
8 10
;
run;
proc summary data=fivepointone mean print;
var one two;
run;

proc corr data=fivepointone noprob nosimple outp=OutCorr /** store results **/
          cov;   /**  include covariances **/
var one two;
run;

*5.18a;
proc import out=tableone datafile ="/home/u57771545/Mydata/T5-2.DAT.txt"
dbms=dlm replace;
getnames=no;
datarow=1;
run;
data table52;
set tableone;
keep VAR3 VAR5 VAR7;
rename VAR3=social VAR5=verbal VAR7=science;
run;

proc summary data=table52 mean print;
var social verbal science;
run;

proc corr data=table52 noprob nosimple nocorr outp=OutCorr /** store results **/
          cov;   /**  include covariances **/
var social verbal science;
run;

*5.18c;
Proc Univariate data =table52;
Var social verbal science;
Qqplot;
run;
proc sgscatter data=table52;
  title "Scatterplot Matrix for College Data";
  matrix social verbal science;
run;

*5.20a;
proc import out=table datafile ="/home/u57771545/Mydata/T5-12.dat.txt"
dbms=dlm replace;
getnames=no;
datarow=1;
run;
data table520;
set table;
keep VAR3 VAR5;
rename VAR3=tail VAR5=wing;
run;
proc corr data=table520 noprob nosimple nocorr outp=OutCorr /** store results **/
          cov;   /**  include covariances **/
var tail wing;
run;
proc summary data=table520 mean print;
var tail wing;
run;
ODS graphics on;
 proc corr data=table520 nomiss nosimple nocorr 
 plots=matrix plots=scatter(ellipse=confidence alpha=0.05);
 var tail wing; run;
 ODS graphics off;
 
*5.20c;
Proc Univariate data =table520;
Var tail wing;
Qqplot;
run;
proc sgscatter data=table520;
  title "Scatterplot Matrix for Bird Data";
  matrix wing tail;
run;
proc summary data=table520 mean print;
var wing tail;
run;