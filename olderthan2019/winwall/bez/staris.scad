w=180;
h=600;
 t=$t*1/72;

 path=[[[w,0,0],0],[[w,0,h],-540],[[-w,0,h],-540],[[-w,0,0] ,-540*2],[[w,0,0],-540*2]];
 echo(len3v(path));
 scale([1,1,.5]){
     
translate( [ w,0,0 ])cylinder(800,20,20);
translate( [-w,0,0 ])cylinder(800,20,20);

 for(i=[t:1/72:1-1/72+t]){
    p=v2t(path,(4*w+2*h)*(i%1));
     echo(p);
   translate(t(p[0])) rotate(p[1]) step();
 }}
        
 
module step() {
     rotate(90-10) rotate_extrude(angle=20)translate([25,0])square([55,40]);
}
        
 
 
   
 
  
  function t(p)=[p.x,p.y,p.z];
  
  // lenght along vetorlist to point 
  function v2t(v,stop,p=0)=

p>len(v)-2 || stop< norm(( v[p][0]-v[p+1][0]))?

(v[p])+((v[p+1]-v[p])/norm(v[p+1][0]-v[p][0]))*stop:  

v2t(v,stop-norm(v[p][0]-v[p+1][0]) ,p+1);

  
 