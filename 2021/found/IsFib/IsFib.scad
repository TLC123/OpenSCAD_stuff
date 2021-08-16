for (i = [0: 100])
  echo(i, ":", is_fibonacci(i));


function is_fibonacci(N) =
let (
  i = floor(log(N * sqrt(5)) / log((1 + sqrt(5)) / 2) + 0.5),
  n = floor(pow((1 + sqrt(5)) / 2, i) / sqrt(5) + 0.5),
  place = (n == N) ? i : -1)
[(n == N), place];