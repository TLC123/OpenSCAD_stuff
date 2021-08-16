

  //MAZE GENERATOR FOR FAST GAME BUILDINGS... If you design a building mesh and can't be bothered to place doors and walls in it, you can differnce this code from the house and rooms will appear inside it. 
  //convenient because it can make a game environment in 20 lines of code, which is different from a maze. to give it depth, it's possible to overlay 2-3 mazes with different cube widths and place hyeroglypgs and othe procedural geometry and doors and things. 
  //This maze formula alos works fine for marching cubes engines and isosurfaces, because cubes exist in a square space of 1/0 mapping with square iso edges that should be the same size as the marching cubes cube size. 

 
 labyrinthIsoSurface();
  
    ridgeDensity = 10;//higher values compress the random oscillator at higher frequency
    brickDensity = 0.43;//regulates the difficulty of maze
    mixIntensity= 0.1;
    mazeSize = 100; 
    
module labyrinthIsoSurface (){

 for( j = [ 1 : mazeSize ])
   for( i = [ 1 : mazeSize ])
	{  

        li = lfo(i*ridgeDensity)*532.154;//random lfo values
        lj = lfo(j*ridgeDensity)*451;
        xc= (lfo(j*mixIntensity+li) + lfo(i*mixIntensity+lj))*.25+brickDensity;//
        //xc= (lfo(li) + lfo(lj))*.25+.40;//run this version to see simple version of maze
        
        rd = round(xc)*55;
        //echo(xc);
        if (xc > .5) // if isosurface is small, build wall cube
        {
            translate( [j ,i, 0])
            cube(1); 
        }
	} 
}

function mod(a,m) = a - m*floor(a/m);
function lfo(xx)= mod(abs((sin(floor(xx))*0.01246)*32718.927),1.0)*2.0 - 1.0  ; //erratic sin
    //low frequency oscillator function similar to synthesizer robot sound like R2D2

























	   