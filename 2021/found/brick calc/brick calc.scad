
brick_length=5;
half_brick_length=brick_length/2;
brick_width=3;
brick_height=2;

for(layer=[0:1:5])
for(run=[0:1:5]){
shift= layer % 2; // <-- this is the sauce
translate(
[run*brick_length+shift*half_brick_length,
0,
layer*brick_height])
brick();
}

module brick(){color(rands(0,1,3)) 
cube([brick_length,brick_width,brick_height]);}