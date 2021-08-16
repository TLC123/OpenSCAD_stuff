module randomObject(i) 
{
       translate(rands(-23,23 ,3,i)){
    
    for(i=[0:2]){
   translate(rands(-2,2,3)) rotate(rands(0,360,3)) cube(rands(2,5,3),true);
   translate(rands(-2,2,3)) rotate(rands(0,360,3)) cylinder(rands(2,5,3),true);
    }
    }
}
seed=rands(1,0,1).x;


hull()
{
randomObject(seed);


 
 f=[-1:1];
 intersection_for(x=f,y=f,z=f,xi=f,yi=f,zi=f){
mirror([x,y,z])
     mirror([xi,yi,zi])
hull(){  
mirror([1,0,0]) 
mirror([0,1,0]) 
mirror([0,0,1])
randomObject(seed);
randomObject(seed);
}


}
}
 