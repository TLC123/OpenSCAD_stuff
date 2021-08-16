echo(choose(10,8));

function choose(n, k)=
     k == 0? 1
    : (n * choose(n - 1, k - 1)) / k;