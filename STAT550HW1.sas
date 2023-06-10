*1.16;
proc import out=tableone datafile ="/home/u57771545/Mydata/T1-8DAT.txt"
dbms=dlm replace;
getnames=no;
datarow=1;
run;
data tableoneeight;
set tableone;
keep VAR3 VAR5 VAR7 VAR9 VAR11 VAR13; 
rename VAR3=dom_radius VAR5=radius VAR7=dom_humerus VAR9=humerus VAR11=dom_ulna VAR13=ulna;
run;
proc summary data=tableoneeight mean print;
var dom_radius radius dom_humerus humerus dom_ulna ulna;
run;

proc corr data=tableoneeight noprob nosimple outp=OutCorr /** store results **/
          cov;   /**  include covariances **/
var dom_radius radius dom_humerus humerus dom_ulna ulna;
run;

