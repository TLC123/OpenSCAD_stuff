echo(prod(rands(.9,1/.9,50000)));
function prod(v) =  exp([for(i=v) ln(i)]* [for(i=v) 1]);