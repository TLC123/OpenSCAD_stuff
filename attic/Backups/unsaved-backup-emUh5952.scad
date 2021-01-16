function lerp(start, end, bias) = (end * bias + start * (1 - bias));
echo(lerp([2,2,2],[1,1,1],[undef]));