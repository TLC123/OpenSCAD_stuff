union(){intersection(){ fejja();
mirror([0,1,0])fejja();}

rotate( [0,0,90]){
intersection(){ fejja();
mirror([0,1,0])fejja();
}}
}
 module fejja(){ intersection(){translate([0,0,27]) cube(100,center=true);
     rotate([90,0,0])  scale([1, 1, 0.5]) translate([0,0,-20]) union(){ surface(file = "smile2.png", center = true);
         translate([0,0,-49]) cube(100,center=true);       
         }
      }}