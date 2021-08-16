echo(gcd(90,15));
echo(lcm(5,4));

function gcd(a,b)= a<=0||b<=0?min(sign(a),sign(b)):a % b==0?b:gcd(b,a % b);

function lcm(a,b)= a * (b / gcd(a, b));
