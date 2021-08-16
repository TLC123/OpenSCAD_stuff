

seed=rnd(12);
for (a=[-15:0.025:15])  translate([a,0,0])  cube([0.05,0.1, noise_1d(a+seed)]);

function  noise_1d(i,
low_range=1/4,mid_range=1,hi_range=8,
low_magnitude=1/2,mid_magnitude=0.25,hi_magnitude=0.5)=
 (  
single_noise_1d(i/low_range)*low_magnitude+
single_noise_1d(i/mid_range)*mid_magnitude+
single_noise_1d(i/hi_range)*hi_magnitude

)/(low_magnitude+mid_magnitude+hi_magnitude);


function single_noise_1d(i)=
let(
a=floor(i),
b=ceil(i),
c=smooth_curve(i-a),
arnd=rnd(1,0,a),
brnd=rnd(1,0,b),
out=lerp(arnd,brnd,c)
)
out
;

function smooth_curve(a) =let (b = clamp(a))(b * b * (3 - 2 * b));
function clamp(a, b = 0, c = 1) = min(max(a, b), c);
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
