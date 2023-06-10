*11.24;
TITLE 'Bankruptcy Data';
DATA money;
INPUT x1 x2 x3 x4 pop;
CARDS;
-0.45  -0.41  1.09  0.45  0  
-0.56  -0.31  1.51  0.16  0  
0.06  0.02  1.01  0.40  0  
-0.07  -0.09  1.45  0.26  0  
-0.10  -0.09  1.56  0.67  0  
-0.14  -0.07  0.71  0.28  0  
0.04  0.01  1.50  0.71  0  
-0.07  -0.06  1.37  0.40  0  
0.07  -0.01  1.37  0.34  0  
-0.14  -0.14  1.42  0.43  0  
-0.23  -0.30  0.33  0.18  0  
0.07  0.02  1.31  0.25  0  
0.01  0.00  2.15  0.70  0  
-0.28  -0.23  1.19  0.66  0  
0.15  0.05  1.88  0.27  0  
0.37  0.11  1.99  0.38  0  
-0.08  -0.08  1.51  0.42  0
0.05  0.03  1.68  0.95  0
0.01  0.00  1.26  0.60  0
0.12  0.11  1.14  0.17  0
-0.28  -0.27  1.27  0.51  0
0.51  0.10  2.49  0.54  1
0.08  0.02  2.01  0.53  1
0.38  0.11  3.27  0.35  1
0.19  0.05  2.25  0.33  1
0.32  0.07  4.24  0.63  1
0.31  0.05  4.45  0.69  1
0.12  0.05  2.52  0.69  1
-0.02  0.02  2.05  0.35  1
0.22  0.08  2.35  0.40  1
0.17  0.07  1.80  0.52  1
0.15  0.05  2.17  0.55  1
-0.10  -0.01  2.50  0.58  1
0.14  -0.03  0.46  0.26  1
0.14  0.07  2.61  0.52  1
0.15  0.06  2.23  0.56  1
0.16  0.05  2.31  0.20  1
0.29  0.06  1.84  0.38  1
0.54  0.11  2.33  0.48  1
-0.33  -0.09  3.01  0.47  1
0.48  0.09  1.24  0.18  1
0.56  0.11  4.29  0.44  1
0.20  0.08  1.99  0.30  1
0.47  0.14  2.92  0.45  1
0.17  0.04  2.45  0.14  1
0.58  0.04  5.06  0.13  1
;
RUN;
*part a;
proc sgscatter data=money;
plot x2*x1/group=pop;
run; 
proc sgscatter data=money;
plot x3*x1/group=pop;
run; 
proc sgscatter data=money;
plot x4*x1/group=pop;
run; 
*none of the scatter plots indicate bivariate normal distributions.
x3 vs x1 very slightly follows a bivaraite normal trend;

*part b;
proc corr data=money cov;
VAR x1 x2;
by pop;
run;

*part c and d;
proc discrim data=money outstat=moneystat
 method=normal pool=test;
 class pop;
 var x1 x2;
 priors equal;
 run;
 proc print data=moneystat;
 run;
*E(AER);
proc discrim data=money outstat=moneys
 method=normal pool=test crosslist;
 class pop;
 var x1 x2;
 priors equal;
 run;
 proc print data=moneys;
 run;
 
 *e;
 proc discrim data=money outstat=moneys
 method=normal pool=test;
 class pop;
 var x1 x2;
 priors '0'=0.05 '1'=.95;
 run;
 proc print data=moneys;
 run;
*E(AER);
proc discrim data=money outstat=moneys
 method=normal pool=test crosslist;
 class pop;
 var x1 x2;
 priors '0'=0.05 '1'=.95;
 run;
 proc print data=moneys;
 run;
 
*f;
proc discrim data=work.money pool=yes;
CLASS pop;
var x1 x2;
priors equal; run;
proc iml;
S1={0.0441290476 0.0284764286, 0.0284764286 0.021002571};
S1_inv= inv(S1);
S2={0.0470510000 0.0085071667, 0.0085071667 0.0023756667};
S2_inv= inv(S2);
x1={-0.06905, -0.08143};
x2={0.23520, 0.05560};
dS1= det(S1);
dS2= det(S2);
k1= LOG(dS1/dS2);
k2= x1`*S1_inv*x1;
k3= x2`*S2_inv*x2;
k=(-0.5*k1)+((0.5)*(k2-k3));
w=(x1`)*S1_inv;
diffincovin=S1_inv-S2_inv;
diffincovinbymean=((x1`)*S1_inv)-((x2`)*S2_inv);
print S1 S1_inv;
print S2 S2_inv;
print diffincovin diffincovinbymean;
print k;


run;

*input dataset;
data iris;
	input x1 x2 x3 x4 pop;
	datalines;
5.1  3.5  1.4  0.2  1
4.9  3.0  1.4  0.2  1
4.7  3.2  1.3  0.2  1
4.6  3.1  1.5  0.2  1
5.0  3.6  1.4  0.2  1
5.4  3.9  1.7  0.4  1
4.6  3.4  1.4  0.3  1
5.0  3.4  1.5  0.2  1
  4.4  2.9  1.4  0.2  1
  4.9  3.1  1.5  0.1  1
  5.4  3.7  1.5  0.2  1
  4.8  3.4  1.6  0.2  1
  4.8  3.0  1.4  0.1  1
  4.3  3.0  1.1  0.1  1
  5.8  4.0  1.2  0.2  1
  5.7  4.4  1.5  0.4  1
  5.4  3.9  1.3  0.4  1
  5.1  3.5  1.4  0.3  1
  5.7  3.8  1.7  0.3  1
  5.1  3.8  1.5  0.3  1
  5.4  3.4  1.7  0.2  1
  5.1  3.7  1.5  0.4  1
  4.6  3.6  1.0  0.2  1
  5.1  3.3  1.7  0.5  1
  4.8  3.4  1.9  0.2  1
  5.0  3.0  1.6  0.2  1
  5.0  3.4  1.6  0.4  1
  5.2  3.5  1.5  0.2  1
  5.2  3.4  1.4  0.2  1
  4.7  3.2  1.6  0.2  1
  4.8  3.1  1.6  0.2  1
  5.4  3.4  1.5  0.4  1
  5.2  4.1  1.5  0.1  1
  5.5  4.2  1.4  0.2  1
  4.9  3.1  1.5  0.2  1
  5.0  3.2  1.2  0.2  1
  5.5  3.5  1.3  0.2  1
  4.9  3.6  1.4  0.1  1
  4.4  3.0  1.3  0.2  1
  5.1  3.4  1.5  0.2  1
  5.0  3.5  1.3  0.3  1
  4.5  2.3  1.3  0.3  1
  4.4  3.2  1.3  0.2  1
  5.0  3.5  1.6  0.6  1
  5.1  3.8  1.9  0.4  1
  4.8  3.0  1.4  0.3  1
  5.1  3.8  1.6  0.2  1
  4.6  3.2  1.4  0.2  1
  5.3  3.7  1.5  0.2  1
  5.0  3.3  1.4  0.2  1
  7.0  3.2  4.7  1.4  2
  6.4  3.2  4.5  1.5  2
  6.9  3.1  4.9  1.5  2
  5.5  2.3  4.0  1.3  2
  6.5  2.8  4.6  1.5  2
  5.7  2.8  4.5  1.3  2
  6.3  3.3  4.7  1.6  2
  4.9  2.4  3.3  1.0  2
  6.6  2.9  4.6  1.3  2
  5.2  2.7  3.9  1.4  2
  5.0  2.0  3.5  1.0  2
  5.9  3.0  4.2  1.5  2
  6.0  2.2  4.0  1.0  2
  6.1  2.9  4.7  1.4  2
  5.6  2.9  3.6  1.3  2
  6.7  3.1  4.4  1.4  2
  5.6  3.0  4.5  1.5  2
  5.8  2.7  4.1  1.0  2
  6.2  2.2  4.5  1.5  2
  5.6  2.5  3.9  1.1  2
  5.9  3.2  4.8  1.8  2
  6.1  2.8  4.0  1.3  2
  6.3  2.5  4.9  1.5  2
  6.1  2.8  4.7  1.2  2
  6.4  2.9  4.3  1.3  2
  6.6  3.0  4.4  1.4  2
  6.8  2.8  4.8  1.4  2
  6.7  3.0  5.0  1.7  2
  6.0  2.9  4.5  1.5  2
  5.7  2.6  3.5  1.0  2
  5.5  2.4  3.8  1.1  2
  5.5  2.4  3.7  1.0  2
  5.8  2.7  3.9  1.2  2
  6.0  2.7  5.1  1.6  2
  5.4  3.0  4.5  1.5  2
  6.0  3.4  4.5  1.6  2
  6.7  3.1  4.7  1.5  2
  6.3  2.3  4.4  1.3  2
  5.6  3.0  4.1  1.3  2
  5.5  2.5  4.0  1.3  2
  5.5  2.6  4.4  1.2  2
  6.1  3.0  4.6  1.4  2
  5.8  2.6  4.0  1.2  2
  5.0  2.3  3.3  1.0  2
  5.6  2.7  4.2  1.3  2
  5.7  3.0  4.2  1.2  2
  5.7  2.9  4.2  1.3  2
  6.2  2.9  4.3  1.3  2
  5.1  2.5  3.0  1.1  2
  5.7  2.8  4.1  1.3  2
  6.3  3.3  6.0  2.5  3
  5.8  2.7  5.1  1.9  3
  7.1  3.0  5.9  2.1  3
  6.3  2.9  5.6  1.8  3
  6.5  3.0  5.8  2.2  3
  7.6  3.0  6.6  2.1  3
  4.9  2.5  4.5  1.7  3
  7.3  2.9  6.3  1.8  3
  6.7  2.5  5.8  1.8  3
  7.2  3.6  6.1  2.5  3
  6.5  3.2  5.1  2.0  3
  6.4  2.7  5.3  1.9  3
  6.8  3.0  5.5  2.1  3
  5.7  2.5  5.0  2.0  3
  5.8  2.8  5.1  2.4  3
  6.4  3.2  5.3  2.3  3
  6.5  3.0  5.5  1.8  3
  7.7  3.8  6.7  2.2  3
  7.7  2.6  6.9  2.3  3
  6.0  2.2  5.0  1.5  3
  6.9  3.2  5.7  2.3  3
  5.6  2.8  4.9  2.0  3
  7.7  2.8  6.7  2.0  3
  6.3  2.7  4.9  1.8  3
  6.7  3.3  5.7  2.1  3
  7.2  3.2  6.0  1.8  3
  6.2  2.8  4.8  1.8  3
  6.1  3.0  4.9  1.8  3
  6.4  2.8  5.6  2.1  3
  7.2  3.0  5.8  1.6  3
  7.4  2.8  6.1  1.9  3
  7.9  3.8  6.4  2.0  3
  6.4  2.8  5.6  2.2  3
  6.3  2.8  5.1  1.5  3
  6.1  2.6  5.6  1.4  3
  7.7  3.0  6.1  2.3  3
  6.3  3.4  5.6  2.4  3
  6.4  3.1  5.5  1.8  3
  6.0  3.0  4.8  1.8  3
  6.9  3.1  5.4  2.1  3
  6.7  3.1  5.6  2.4  3
  6.9  3.1  5.1  2.3  3
  5.8  2.7  5.1  1.9  3
  6.8  3.2  5.9  2.3  3
  6.7  3.3  5.7  2.5  3
  6.7  3.0  5.2  2.3  3
  6.3  2.5  5.0  1.9  3
  6.5  3.0  5.2  2.0  3
  6.2  3.4  5.4  2.3  3
  5.9  3.0  5.1  1.8  3
;
run;

*print iris dataset;
proc print data=iris;
run;

*part a: plot the data in the (x2, x4) space;
proc gplot data=iris;
	where pop="1" or pop="2" or pop="3";
	plot x4*x2=pop;
run;

*part b: Test the hypothesis of equal variances;
proc discrim data=iris manova;
	class pop;
	var x1 x2 x3 x4;
run;

*part c: Contruct the quadratic discriminate scores;
data scores;
	input x2 x4;
	cards;
	3.5 1.75
;

proc discrim data=iris outstat=irisstat
method=normal pool=test testdata=scores;
	class pop;
	var x2 x4;
	priors equal;
run;

proc print data=irisstat;
run;

*part d: Construct the linear discriminate scores;
proc discrim data=iris pool=yes testdata=scores;
	class pop;
	var x2 x4;
	priors equal;
run;
 *part e;


