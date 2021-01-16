 echo(point_to_line(   [150,50,0],   [0,0,0],   [100,0,0]  ));


function point_to_line(   p,   a,   b  )=let(
pa = p - a, 
ba = b - a,
h = clamp( (pa*ba)/ (ba*ba)))
norm( pa - ba*h ) ;
function clamp(a, b = 0, c = 1) = min(max(a, b), c);
