translate([1,0,0])boulder(rands(0,1000,1)[0]);
translate([-1,0,0]) cutstone(rands(0,1000,1)[0]);
module boulder(bseed)
{
  loops=6;
       n=10;// num faces  
 l=n*5;// num points
      

                       ri=rands(0,360,l,bseed); // NEED TO USE rseed
                t=rands(-180,180,l,bseed+1);  // NEED TO USE rseed

       for(loop=[0:loops]){

                v21=rands(0,l-1,n*3+1,bseed+loop);// NEED TO USE rseed

        v1 = [ for(i=[0:l])               
                [sin(ri[i])*cos(t[i]),cos(ri[i])*cos(t[i]),sin(t[i])]];

        v2 = [for(j=[0:n])[v21[j],v21[j+n],v21[j+n+n]]]; 
            // NEED TO USE rseed
         
        color("Gray")
        hull()
     scale(0,5)  polyhedron(v1, v2);

    }
}

module cutstone(bseed)
{
  loops=1;
        l=200;// num points
        n=100;// num faces

       
       for(loop=[0:loops]){

                l1=rands(0,1,l*3+3,bseed+loop); // NEED TO USE rseed
                v21=rands(0,l-1,n*3+1,bseed+loop);// NEED TO USE rseed

        v1 = [ for(i=[0:l])               
                [l1[i],l1[i+l],l1[i+l+1]]
];

        v2 = [for(j=[0:n])[v21[j],v21[j+n],v21[j+n+n]]]; 
            // NEED TO USE rseed
         
        color("Gray")
        hull()
       polyhedron(v1, v2);

    }
}