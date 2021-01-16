q=10;
some=10;
stuff=5;
A=[some-stuff+stuff+myfunction(q)+rnd(-10,10)];
a=A[0];
text(str(a));
function myfunction(b)=27+b;

function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
