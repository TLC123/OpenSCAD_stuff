for (i = [0: 100])
  echo(i, ":", next_pow2(i));

function next_pow2(x) = pow(2, ceil(log(x)/log(2)));