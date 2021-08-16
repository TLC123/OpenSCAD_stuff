hull () {
polyhedron( 
    
    points = [ 
    [rnd(),rnd(), rnd()], 
    [rnd(),rnd(), rnd()],
    [rnd(),rnd(), rnd()], 
    [rnd(),rnd(), rnd()],
    [rnd(),rnd(), rnd()],
    [rnd(),rnd(), rnd()], 
    [rnd(),rnd(), rnd()]
    ], 
    
    
    faces = [ 
    [rnd(1,5), rnd(1,5),rnd(1,5)], 
    [rnd(1,5), rnd(1,5),rnd(1,5)], 
    [rnd(1,5), rnd(1,5),rnd(1,5)], 
    [rnd(1,5), rnd(1,5),rnd(1,5)], 
    [rnd(1,5), rnd(1,5),rnd(1,5)], 
    [rnd(1,5), rnd(1,5),rnd(1,5)]
    ]) ;
}
function rnd(a=0,b=1)=a+(rands(a,b,1)[0])*(b-a);
