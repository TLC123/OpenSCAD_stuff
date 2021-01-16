//antdata
body= [[-5, 0, 0, 1], [-4, 0, 1, 2], [-2, 0, 2, 3], [0, 0, 2, 3], [3, 0, 2, 1], [4, 0, 1, 1], [7, 0, 4, 3], [9, 0, 5, 3], [12, 0, 4, 1], [14, 0.5, 4, 3], [15, 1, 2, 2], [16, 0.7, -0.5, 0.5]]
;
ant1= [[14.4062, 0.35, 5.21244, 0.525], [16.4468, 1.52811, 7.89352, 0.49], [18.9311, 2.96244, 8.66218, 0.525], [20.728, 3.99987, 6.65596, 0.525], [21.4749, 4.43109, 5.34974, 0.35]]
;leg1= [[5.5, 0, 2.5, 0.5], [7.03209, 1.28558, 0.5, 0.75], [10.8623, 4.49951, 2.5, 1], [11.8623, 4.49951, -3.5, 0.75], [13.944, 5.78509, -5.75, 0.65], [15, 6.42788, -6, 0.5]]
;leg2=[[4.75, 0, 1.75, 0.5], [4.75, 2.31691, 0.127681, 0.75], [4.75, 6.89365, 2.96554, 1], [4.75, 7.93554, -2.94331, 0.75], [4.75, 10.4261, -5.55044, 0.75], [4.75, 11.4977, -5.86919, 0.5]]
;leg3=[[3, 0.2, 0.25, 0.5], [0.972499, 2.8691, -0.26813, 0.75], [-3.8651, 5.7605, 2.8302, 1], [-4.66323, 6.43022, -3.07865, 0.75], [-7.02376, 8.41093, -5.58159, 0.75], [-8.071, 9.28967, -5.84825, 0.5]];
 
 {
horrorpolyline(body);
horrorpolyline(ant1);
horrorpolyline(leg1);
horrorpolyline(leg2);
horrorpolyline(leg3);
}
 mirror ([0,1,0]){
horrorpolyline(body);
horrorpolyline(ant1);
horrorpolyline(leg1);
horrorpolyline(leg2);
horrorpolyline(leg3);
}

 module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[ i+1 ]);}
     
 module horrorpolyline(p) {for(i=[0:max(0,len(p)-2)]) horrorline(p[i],p[ i+1 ]);
} // polyline plotter
module line(p1, p2 ,width=0.5) 
{ // single line plotter
p1p=v3(p1);
p2p=v3(p2);
width1=p1[3];
width2=p2[3];
    hull() {
        translate(p1p) sphere(width1);
        translate(p2p) sphere(width2);
    }
}
 module horrorline(p1,p2)
  {
    
      
//    toothpick(p1,p2);
          
          
      l=norm(p1-p2);
      m=min(p1[3],p2[3])*.5;
      for ( i=[0:m/l:1]) {   
       p=lerp(p1,p2,i);
          p_3=[p.x,p.y,p.z];
    translate(p_3+rands(-m/2,m/2,3))scale(1)rotate([90,0,0])horror(p[3]*1,$fn=20);
 
     } 
      
      }
 module horror(s,q)
 {
     $fm=q;
     
     for (u=[0:s*0.6])
     
          hull()
     {
         
         rotate(rands(0,360,3))cube(s,center=true);
         rotate(rands(0,360,3))cube(s,center=true);
         rotate(rands(0,360,3))cube(s,center=true);
         
          }
 
     
     
     }

function v3(p1)=[p1.x,p1.y,p1.z];
     function lerp(a,b,bias)=a*bias+b*(1-bias);