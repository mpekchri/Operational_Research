set Mines;
set Years;

param bigM;
param c {Mines,Years} ;
param max_x {Mines};
param PF {Years};
param pi {Mines};
param Pi {Years};

var x {Mines,Years} >= 0;
var y {Mines,Years} integer >=0 , <=1;
var cost {Mines,Years} binary;

maximize total_profit: sum{j in Years}(PF[j]*(sum{i in Mines}x[i,j] ))
					 - sum{j in Years}((sum{i in Mines}c[i,j]*cost[i,j] ));

subject to c11 {j in Years}: 
	sum {i in Mines} y[i,j] <= 3;
	
subject to c12 {i in Mines, k in Years }:
	sum{j in Years}c[i,j]*cost[i,j] - sum{j in Years : j <= k-1}c[i,j] <= sum{j in Years : j>=k} (bigM*y[i,j]);

subject to c121 {i in Mines,j in Years }:
	cost[i,j] >= y[i,j];

subject to c13 {i in Mines, j in Years}:
	x[i,j] <= bigM*y[i,j];
	
subject to c14 {i in Mines, k in Years }:
	sum{j in Years}c[i,j]*cost[i,j] - sum{j in Years : j <= k-1}c[i,j] >= 0;
	
subject to c2 {i in Mines,j in Years}:
	x[i,j] <= max_x[i];
	
subject to c3 {j in Years}:
	(sum{i in Mines}pi[i]*x[i,j]) = Pi[j]*(sum{i in Mines}x[i,j]);