/*
  A linear congruential generator (LCG) is an algorithm that yields a sequence of pseudo-randomized numbers calculated with a discontinuous piecewise linear equation. The method represents one of the oldest and best-known pseudorandom number generator algorithms 
https://en.wikipedia.org/wiki/Linear_congruential_generator*/
seed=rands(0,1,1)[0];
echo(Linear_Congruential_Generator(seed));

function  Linear_Congruential_Generator
   (seed=0,modulus=1e64, a=6364136223846793005, c=1442695040888963407)=
   (a * seed + c) % modulus;
    