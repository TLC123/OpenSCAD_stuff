a=1;
b=3;
echo(len3bz([[0,0],[0,b],[0,a],[0,0]]));

echo( (a*(3/4)*(a/b)+b*(3/4)*(b/a))*0.684149  );

function len3bz(v, precision = 0.01, t = 0, acc = 0) = t > 1 ? acc : len3bz(v, precision, t + precision, acc + norm(bez2(t, v) - bez2(t + precision, v)));

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for (i = [0: len(v) - 2]) v[i]* (t)  + v[i + 1] * (1 - t)
]): v[0]* (t)  + v[1]* (1 - t) ;