
//============================================================
// Trigonometry library
//
// To improve OpenSCAD Maths
// Add :
//		secante
//		cosecante
//		cotangente
//		sinus hyperbolique
//		cosinus hyprbolique
//		tangente hyperbolique
//		... and more
//
//============================================================

// TO DO :
// add comment to explain min and max

// Warning !
// some function return a negative value
// that can not be used in primitive such as cube()
// Take care about the 0 return

// constantes
PI = 3.141592653589793 ;

// secante
function sec(x)=1/cos(x);

// cosecante
function cosec(x)=1/sin(x);

// cotangente
function cot(x)=1/tan(x);

// chord
function crd(x)=2*sin(x/2);

// sinus cardinal (without pi)
// if x=0 then y=1
function sinc(x)=( x==0 ? 1 : sin(x)/x );

// sinus cardinal normalisé (with pi)
// if x=0 then y=1
function sinc2(x)=( x==0 ? 1 : sin(pi*x)/(pi*x) );

// sinus verse
function versin(x)=1-cos(x);

// sinus hyperbolique
function sinh(x)=(exp(x)-exp(-x))/2;

// cosinus hyperbolique
function cosh(x)=(exp(x)+exp(-x))/2;

// tangente hyperbolique
// -1 to +1 max value
function tanh(x)=sinh(x)/cosh(x);

// cotangente hyberbolique
function coth(x)=cosh(x)/sinh(x);

// sécante hyperbolique
function sech(x)=1/cosh(x);

// cosécante hyberbolique
function cosech(x)=1/sinh(x);

// argument sinus hyperbolique
function asinh(x)=ln( x + sqrt(x*x+1) );

// argument cosinus hyperbolique
function acosh(x)=ln( x + sqrt(x*x-1) );

// argument tangente hyperbolique
// -1 to +1 max value where result is infinite
function atanh(x)= 0.5 * ln( (1+x)/(1-x) ) ;

// argument cotangente hyperbolique
function acoth(x)= 0.5 * ln( (x+1)/(x-1) ) ;


// TEST


A=250;
//for(x=[-1:0.01:1])
for(i=[-1800:1:1800])
//for(x=[-20:1:20])
{
	assign (
		x = .1 * i ,
		y = A * sinc(i)*50 ,
		z = 0 )
	{
		translate([x,y,z])
		cube([10,10,10]);
		echo(y);
	}
}
