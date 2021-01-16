rotate([90,0,0])XWing ();


  WingRotation = 0;
 

module XWing () {
   scale (0.4)
union() {
//    union() {XW_BodyRearB()  ;  }
//    union() {XW_BackHatch()  ;  }
    union() {XW_NoseUnderSide()  ;  }
    union() {XW_NoseTip  ()  ;  }
//    union() {XW_Screen  ()  ;  }
//    union() {XW_ScreenSurround  ()  ;  }
//    union() { rotate ( [-15,0,0]) scale(1.65)  translate ( [0, 0, 5])XW_Pilot  ()  ;  }
//    union() {XW_Cockpit  ()  ;  }
//    union() { rotate ( [0,0,WingRotation]) translate ( [0,0.1,0]) scale ( [1,1,1])XW_Wing  ()  ;  }
//    union() { rotate ( [0,0,WingRotation]) translate ( [0,0.1,0]) scale ( [-1,1,1])XW_Wing  ()  ;  }
//    union() { rotate ( [0,0,WingRotation]) translate ( [0,0.1,0]) scale ( [1,-1,1])XW_Wing  ()  ;  }
//    union() { rotate ( [0,0,WingRotation]) translate ( [0,0.1,0]) scale ( [-1,-1,1])XW_Wing  ()  ;  }
//     union() {XW_BodyTopDetail();  }
  }
  
  
}



module Pbox(p1,p2){translate(p1)cube(p2-p1);}
module Pcylinder(p1,p2,r){
hull(){
translate(p1)sphere(r);
translate(p2)sphere(r);}}
module Pcone(p1,r1,p2,r2){
hull(){
translate(p1)sphere(r1);
translate(p2)sphere(r2);}}
module Psphere(p1,r){translate(p1)sphere(r);}
module Pplane(p1,p2){ }
module Ptorus(p1,p2){ 
rotate_extrude(){translate([p1,0,0])circle(p2);}
}

module  XW_WingGun () {
  union()  {
    union() { Pcylinder ([0,0,-4], [0,0,0], 0.45);}
    union() { Pcylinder ([0,0,-0.3], [0,0,0], 0.5);}
    union() { Pcylinder ([0,0,-3.5], [0,0,-0.7], 0.5);}
    union() { Pcylinder ([0,0,-3.55], [0,0,-0.7], 0.45);}
    union() {  rotate ( [90,0,0]) translate ( [0,0,-3.5 ])Ptorus (0.45, 0.05);}
    union() { Pcylinder ([0,0,-4.6], [0,0,-4], 0.25);}
    union() { Pcylinder ([0,0,-4.7], [0,0,-4.5], 0.35);}
    union() {  rotate ( [90,0,0]) translate ( [0,0,-4.7 ])Ptorus (0.3, 0.05);}
    union() {  rotate ( [90,0,0]) translate ( [0,0,-4.5 ])Ptorus (0.3, 0.05);}
    union() {
      intersection() {
        union() {  Pbox ([0,-0.25,-3], [1, 0.25, -1.5]);}
        union() { Pcylinder ([0,0,-4], [0,0,0], 0.55);}
      }
       
    }
    union() {  Pbox ([0,-0.1,-3], [0.6, 0.1, -2]);}
    union() {  Pbox ([0,-0.1,-3], [0.55, -0.08, 0]);}
    union() {  Pbox ([0,0.08,-3], [0.55, 0.1, 0]);}
    union() {
      difference() {
        union() { Pcylinder ([0,0,0.2], [0,0,0.5], 0.525);}
        union() { Pcylinder ([0,0,0], [0,0,1], 0.475);}
      }
      
    }
    union() {
      union() {
        for( Count=[0:30:360]){
          union() { rotate ( [0, 0, Count])Pbox ([-0.02, 0, 0], [0.02, 0.475, 0.5]);}
         }
 }
     
    }
    union() {  Pcylinder ([0,0,0], [0,0,5.1], 0.25);}
    union() {  Pcylinder ([0,0,5], [0,0,8.5], 0.15);}
    union() {  Pcylinder ([0,0,8.5], [0,0,11], 0.06);}
    union() {  Pcylinder ([0,0,8.3], [0,0,8.5], 0.2);}
    union() {  Pcylinder ([0,0,8.25], [0,0,8.5], 0.175);}
    union() {
      difference() {
        union() {  Pcylinder ([-0.1, 0, 9], [0.1, 0, 9], 0.5);}
        union() {  Pcylinder ([-1, 0, 9], [1, 0, 9], 0.425);}
        #union() {Pplane([0,0,-1], -9);}
      }
      
    }
  }
}


// ********************** Wing Surface, inc. detailing and engine block

module  XW_WingDetail () {
 union() {
    union() {
      difference() {
        union() {union() {
          difference() {
            union() {  Pbox ([2.5,0.01,-4.5], [6.5, 1, 0.05]);}
            union() {  rotate ( [0,0,-15]) translate ( [4.75, 1, 0 ]) Pbox ([0,0,-7], [5,5,1]);}
          }
        }
        union() {
            scale ( [1,1 ,1])union() {
            union() {  Pcylinder ([0,0,0], [4.5,0,0], 5);}
            union() {  Pcone ([4.5,0,0], 5.5, [13.5, 0, 0], 4);}
          }
          
        }
        union() {  Pcylinder ([3.5, 1.15, 1], [3.5, 1.15, -6], 0.9);}
      }
    }
    union() {  Pbox ([6, 0.1, -3], [7, 0.25, -1]);}
    union() {  Pbox ([12.9, 0.1, -4], [13.1, 0.6, -1]);}
    union() {  Pbox ([8, 0.1, -0.5], [9, 0.16, -1.2]);}
    union() {  Pbox ([8, 0.1, -1.3], [9, 0.16, -2]);}
    union() {  Pbox ([8, 0.1, -4], [8.4, 0.16, -3]);}
    //Lines after this point are details on front of engine block mounting
    union() {
      difference() {
        union() {
          union() {
            union() {  Pbox ([3.5, 0.1, 0.05], [6.3, 0.5, 0.1]);}
            union() {  Pbox ([5.5, 0.15, 0.05], [5.8, 0.45, 0.15]);}
            union() {  Pcylinder ([4.5, 0.3, 0.05], [4.5, 0.3, 0.1], 0.15);}
            union() {  Pcylinder ([4.5, 0.3, 0.1], [3.5, 1.15, 0.1], 0.05);}
            union() {
              intersection() {
                union() {  Pbox ([3.5, 0.1, 0.05], [5.5, 0.9, 0.1]);}
                union() {  Pcone ([4, 0.1, 0.1], 1, [5.5, 0.1, 0.1], 0)  scale ( [1,1,100]);}
              }
            }
          }
        }
        union() {  Pcylinder ([3.5, 1.15, 1], [3.5, 1.15, -1], 0.9);}
      }
    }
  }
  
}}

module  XW_WingTopSurface () {
  intersection() {
    union() {  Pbox ([0, 0.1, -6], [14, 0.15, 0]);}
    union() {
       scale ( [1,100,1])union() {
        union() {  Pcylinder ([0,0,0], [4.5,0,0], 5);}
        union() {  Pcone ([4.5,0,0], 5.5, [13.5, 0, 0], 4);}
      }
      
    }
  }
 
}
module  XW_WingBottomSurface () {
  intersection() {
    union() {  Pbox ([0, 0, -6], [14, 0.1, 0]);}
    union() {
        scale ( [1,1 ,1])union() {
        union() {  Pcylinder ([0,0,0], [4.5,0,0], 5);}
        union() {  Pcone ([4.5,0,0], 5.5, [13.5, 0, 0], 4);}
      }
     
    }
  }
 
}


// ******************************** XW_Engine assembly

module  XW_EngineFront () {
  union() {
    union() {  Pcylinder ([0,0,-3.6], [0,0,-4.5], 1.1);}
    union() {
      difference() {
        union() {  Pcylinder ([0,0,0], [0,0,-4], 1);}
        union() {  Pcylinder ([0,0,0.1], [0,0,-2], 0.9);}
        union() {  Pbox ([-2,0,-0.1], [2, 2, 2]);}
      }
    }
    union() {
      intersection() {
        union() {  Pbox ([-1.1, -0.05, -2], [1.1, 0.05, 0]);}
        union() {  Pcylinder ([0,0,-2.1], [0,0,0.1], 1);}
      }
    }
    union() {  Pcylinder ([0,0,-3], [0,0,0], 0.15);}
    union() {  Pcylinder ([0,0,-3], [0,0,-0.15], 0.2);}
    union() {  Pcylinder ([0,0,-3], [0,0,-0.3], 0.25);}
    union() {  Pcylinder ([0,0,-3], [0,0,-0.45], 0.3);}
    union() {
      intersection() {
         union() {
          union() {
            union() {  Pcylinder ([0,0,-0.3], [0,0,-0.8], 1.075);}
            union() {  Pcylinder ([0,0,-0.8], [0,0,-4], 1.05);}
          }
        }
      }
    }
    union() {  Pcone ([0,0,-1], 0, [0,0,-1.5], 1);}
    union() {
      intersection() {
        union() {
          difference() {
            union() {  Pcylinder ([0,0,-4], [0,0,0], 1.075);}
            union() {  Pcylinder ([0,0,-4.1], [0,0,0.1], 0.9);}
          }
        }
        union() {
          union() {
            union() { rotate ( [0,0,-45]) scale ( [1,1,1]) Pbox ([-2, -0.5, -2.3], [0, 0.3, -1.5]);}
            union() { rotate ( [0,0,-45]) scale ( [-1,1,1]) Pbox ([-2, -0.5, -2.3], [0, 0.3, -1.5]);}
            union() { rotate ( [0,0,-45]) scale ( [1,1,1]) Pbox ([-2, -0.5, -3.3], [0, 0.3, -2.5]);}
            union() { rotate ( [0,0,-45]) scale ( [-1,1,1]) Pbox ([-2, -0.5, -3.3], [0, 0.3, -2.5]);}
            union() {  Pbox ([-0.4, 0, -2], [0.4, 2, -0.5]);}
            union() {  Pbox ([-0.2, 0, -4], [0.2, 2, -2]);}

          }
        }
      }
    }
    union() {
      intersection() {
        union() {
          union() {
            union() {
              difference() {
                union() {  Pcylinder ([0,0,-1], [0,0,-1.3], 1.075);}
                union() {  Pcylinder ([0,0,-0.9], [0,0,-1.4], 1);}
              }
            }
                   for( Count=[0:2:360]){

            union() {rotate ( [0,0,Count])  Pcylinder ([0,1.075, -1], [0, 1.075, -1.3], 0.02)  ;}
           }
          }
        }
       union() { 
 #Pplane([0,-1,0], 0)
;}
      }
    }
  }
  
}

module  XW_EngineRing () {  rotate ( [90,0,0 ])Ptorus (0.7, 0.01);  }

module  XW_Engine1 () {
  difference() {
    union() {
      union() {
        union() { scale ( [1,1,0.5 ]) Psphere ([0,0,0], 0.7);}
        union() { scale ( [1,1,3 ]) Psphere ([0,0,0], 0.25);}
        union() {  Pcylinder ([0,0,-4], [0,0,0], 0.7);}
        union() {  rotate ( [90,0,0]) scale ( [1,1,10]) translate ( [0,0,-3 ]) Ptorus (0.7, 0.1);}
        union() { translate ( [0,0,-1])XW_EngineRing (); }
        union() { translate ( [0,0,-1.3])XW_EngineRing ();}
        union() {  translate ( [0,0,-1.4])XW_EngineRing();}
        union() {  translate ( [0,0,-1.5])XW_EngineRing();}
        union() {  translate ( [0,0,-1.6])XW_EngineRing();}
        union() {  Pcylinder ([0,0,-3.6], [0,0,-3.8], 0.8);}
        union() {  Pcylinder ([0,0,-3.85], [0,0,-4.15], 0.8);}
      }
    }
    union() {  Pcylinder ([0,0,-2], [0,0,-5], 0.5);}
  }
  
}


module  XW_Engine2 () {
  union() {
    union() {  Pcone ([0,0,0], 0.78, [0,0,-1], 0.68);}
    union() {
      intersection() {
        union() {  Pcone ([0,0,0], 0.8, [0,0,-1], 0.72);}
        union() {
          union() {
                 for( Count=[0:15:360]){

            union() {  rotate ( [0,0,Count]) Pbox ([-0.05, 0, -1.1], [0.05, 1, 0.1]);}
           }
          }
        }
      }
    }
  }
  
}

module  XW_Engine3 () {
  union() {
    union() {
      difference() {
        union() {XW_Engine2();}
        union() {
            Pcylinder ([0,0,0.1], [0,0,-2], 0.65);}
          
        }
      }
      
    }
    union() {
      intersection() {
        union() {  Pcylinder ([0,0,0], [0,0,-1], 0.63);}
        union() {
          union() {
                   for( Count2=[0:30:360]){

            union() { rotate ( [0,0,Count2]) Pbox ([-0.05, 0, -0.4], [0.05, 1, 0]);}
            }
          }
        }
      }
     }
    union() {  scale ( [1,1,2]) translate ( [0,0,-0.4 ])Psphere ([0,0,0], 0.2);}
  }


 
module  XW_EngineBack () {
  union() {
    union() {XW_Engine1();}
    union() { translate ( [0,0,-4.2])XW_Engine3 ();}
  }
  
}




module XW_Engine () {
  union() {
    union() {XW_EngineFront();}
    union() { translate ( [0,0.7, -4.75])XW_EngineBack ();}
  }
  
}

// *************************** End of engine definition

module XW_Wing () {
  union() {
    union() {XW_WingTopSurface();}
    union() {XW_WingBottomSurface();}
*    union() {XW_WingDetail();}
    union() { translate ( [13, 0.8, 0])XW_WingGun ();}
    union() { translate ( [3.5, 1.15, 1])XW_Engine ();}
   }
}

 module L_XW_Wing () {
  union() {
    union() {XW_WingTopSurface();}
    union() {XW_WingBottomSurface();}
    union() {XW_WingDetail();}
    union() { translate ( [13, 0.8, 0])XW_WingGun ();}
    union() {  translate ( [3.5, 1.15, 1])XW_Engine();  }
}}

// ********************* XW_Body (behind cockpit}

module XW_BodyRearA () {
  intersection() {
    union() {  Pbox ([-2, -2.5, -6.5], [2, 2, 4]);}
    union() {
       scale ( [1,1,1 ])union() {
        union() {  Pcone ([0,0,0], 2, [0,1.501, 0], 1.75);}
        union() {  Pcone ([0,1.5,0], 1.751, [0,2.01,0], 1);}
        union() {  Pcone ([0,0.01,0], 2, [0,-2.01, 0], 1.5);}
        union() {  Pcone ([0,-2,0], 1.5, [0,-2.5,0], 0);}
      }
      
    }
  }
}

module XW_BodyRearB () {
  difference() {
    union() {XW_BodyRearA();}
    union() {  Pbox ([-3, -0.5, -5], [3, 0.5, 0]);}
    union() {  Pcylinder ([0,1,2], [0,3,2], 0.55);}
    union() {  Pbox ([-0.75, 1.8, -6.5], [0.75, 2.1, 1]);}
    #union() { rotate ( [-25,0,0]) translate ( [0,1.6, -6.5])Pplane([ 0,-1,0], 0);}
    #union() { rotate ( [-16.699, 0, 0]) translate ( [0, -2.5, -1 ])Pplane([ 0,1,0], 0);}
    union() {  Pbox ([-4, 0, 2], [4, 4, 6]);}
     union() {
       translate ( [0,0,-0.01])
       scale ( [0.95, 0.95, 1]) intersection () {
        union() {XW_BodyRearA();}
        union() {  Pbox ([-4, -4, -7], [4, 1.5, -6]);}
      }
      
    }
  }
  
}

module XW_BackHatch1 () {
  intersection() {
    union() {XW_BodyRearA();}
    union() {
      union() {
        union() {  Pbox ([-4, -4, -6.1], [4, 1.5, -6]);}
        union() {  translate ( [0,0,0]) scale ( [1,1,1 ]) Pcylinder ([-2, -1, -6.1], [0, 0, -6.1], 0.05);}
        union() {  translate ( [0,0.5,0]) scale ( [1,1,1 ]) Pcylinder ([-2, -1, -6.1], [0, 0, -6.1], 0.05);}
        union() {  translate ( [0,1,0]) scale ( [1,1,1 ]) Pcylinder ([-2, -1, -6.1], [0, 0, -6.1], 0.05);}
        union() {  translate ( [0,1.5,0]) scale ( [1,1,1 ]) Pcylinder ([-2, -1, -6.1], [0, 0, -6.1], 0.05);}
        union() {  translate ( [0,0,0]) scale ( [-1,1,1 ]) Pcylinder ([-2, -1, -6.1], [0, 0, -6.1], 0.05);}
        union() {  translate ( [0,0.5,0]) scale ( [-1,1,1 ]) Pcylinder ([-2, -1, -6.1], [0, 0, -6.1], 0.05);}
        union() {  translate ( [0,1,0]) scale ( [-1,1,1 ]) Pcylinder ([-2, -1, -6.1], [0, 0, -6.1], 0.05);}
        union() {  translate ( [0,1.5,0]) scale ( [-1,1,1 ]) Pcylinder ([-2, -1, -6.1], [0, 0, -6.1], 0.05);}
      }
    }
  }

}

module XW_BackHatch () {
  scale ( [0.95, 0.95, 1]) union() {
    union() {XW_BackHatch1 ();}
    union() {  Pbox ([-1, -1.5, -6.25], [1, 1.5, -6.1]);}
    union() {  Pcylinder ([0, 0, -6.3], [0,0,-6.2], 0.6);}
    union() {
      difference() {
        union() {  Pcylinder ([0, 0, -6.3], [0,0,-6.2], 0.8);}
        union() {  Pcone ([0,0,-6.301], 0.8, [0,0,-6.2], 0.7);}
      }
      
    }
    union() { scale ( [1,1,1])  Pcylinder ([-1, -1.75, -6.1], [-0.75, -1.75, -6.1], 0.2);}
    union() { scale ( [-1,1,1]) Pcylinder ([-1, -1.75, -6.1], [-0.75, -1.75, -6.1], 0.2);}
    union() {  Pcylinder ([-1, -1.75, -6.1], [1, -1.75, -6.1], 0.1);}

  }
 
}




module XW_NoseUnderSide () {
 
 polyhedron (
 [[-2.00, 0, 4], [2.00, 0, 4], [-1.75, -1, 4], [1.75, -1, 4],[-1, 0, 17]
, [1, 0, 17],[-0.75, -0.5, 17],[0.75, -0.5, 17]],
    [ [0,6,2], [0,6,4], [2,6,3], [7,6,3]
    , [1,3,7], [1,5,7], [0,4,1], [5,4,1]
 ]);}


  BA = [-0.9, 2.0, 3.0];
  BB = [0.9, 2.0, 3.0];
  BC = [-0.9, 2.3, 3.4];
  BD = [0.9, 2.3, 3.4];
  BE = [-1.4, 1.2, 4.5];
  BF = [1.4, 1.2, 4.5];
  BG = [-1.0, 2.3, 4.5];
  BH = [1.0, 2.3, 4.5];
  BI = [-0.75, 1.5, 9.0];
  BJ = [0.75, 1.5, 9.0];
//Following B-points are inside cockpit

  BK = [-1.3, 0.2, 4.5];
  BL = [1.3, 0.2, 4.5];
  BM = [-0.5, 0.5, 8.0];
  BN = [0.5, 0.5, 8.0];

  CA= [-2, 0, 2];
  CB= [2, 0, 2];
  CC= [-1.75, 1.5, 2];
  CD= [1.75, 1.5, 2];
  CE= [-1, 2, 2];
  CF= [1, 2, 2];

  FR = 0.05;  
 DA=[-2,0,3.5];
 DB=[2,0,3.5];
 DC=[-1.9,0.9,3.5];
 DD=[1.9,0.9,3.5];
 DE=[-0.75,0,18];
 DF=[0.75,0,18];
 DG=[-0.55,0.9,18];
 DH=[0.55,0.9,18];
module XW_Screen () {
  
union() {
    union() {
  

   union() {
         polyhedron( [[BA,BE,BC],[[0,1,2]]]);
         polyhedron( [[BF,BD,BB],[[0,1,2]]]);
         polyhedron( [[BE,BC,BG],[[0,1,2]]]);
         polyhedron( [[BF,BD,BH],[[0,1,2]]]);
         polyhedron( [[BA,BB,BD],[[0,1,2]]]);
         polyhedron( [[BA,BC,BD],[[0,1,2]]]);
         polyhedron( [[BE,BG,BI],[[0,1,2]]]);
         polyhedron( [[BF,BH,BJ],[[0,1,2]]]);
         polyhedron( [[BG,BI,BJ],[[0,1,2]]]);
         polyhedron( [[BG,BH,BJ],[[0,1,2]]]);
      }
       
    }
    union() {
      union() {
        union() {  Pcylinder (BA,BB,FR);}
        union() {  Pcylinder (BC,BD,FR);}
        union() {  Pcylinder (BC,BG,FR);}
        union() {  Pcylinder (BG,BH,FR);}
        union() {  Pcylinder (BI,BJ,FR);}
        union() {  Pcylinder (BA,BE,FR);}
        union() {  Pcylinder (BB,BF,FR);}
        union() {  Pcylinder (BA,BC,FR);}
        union() {  Pcylinder (BB,BD,FR);}
        union() {  Pcylinder (BC,BG,FR);}
        union() {  Pcylinder (BD,BH,FR);}
        union() {  Pcylinder (BE,BG,FR);}
        union() {  Pcylinder (BF,BH,FR);}
        union() {  Pcylinder (BE,BI,FR);}
        union() {  Pcylinder (BF,BJ,FR);}
        union() {  Pcylinder (BG,BI,FR);}
        union() {  Pcylinder (BH,BJ,FR);}

      }
      
    }
    union() {
      union() {
        union() {Psphere (BA,FR);}
        union() {Psphere (BB,FR);}
        union() {Psphere (BC,FR);}
        union() {Psphere (BD,FR);}
        union() {Psphere (BE,FR);}
        union() {Psphere (BF,FR);}
        union() {Psphere (BG,FR);}
        union() {Psphere (BH,FR);}
        union() {Psphere (BI,FR);}
        union() {Psphere (BJ,FR);}
      }
      
    }
  }
  
}


module XW_Cockpit () {
   union() {
     polyhedron([[BB,BF,BE],[[0,1,2]]]);
     polyhedron([[BB,BA,BE],[[0,1,2]]]);

     polyhedron([[BF, BE, BL],[[0,1,2]]]);
     polyhedron([[BK, BE, BL],[[0,1,2]]]);

     polyhedron([[BF,BL,BN],[[0,1,2]]]);
     polyhedron([[BF,BJ,BN],[[0,1,2]]]);

     polyhedron([[BL,BK,BN],[[0,1,2]]]);
     polyhedron([[BM, BK, BN],[[0,1,2]]]);

     polyhedron([[BJ,BN,BM],[[0,1,2]]]);
     polyhedron([[BJ,BI,BM],[[0,1,2]]]);

     polyhedron([[BE,BK,BM],[[0,1,2]]]);
     polyhedron([[BE,BI,BM],[[0,1,2]]]);
  }
 
}

module XW_ScreenSurround () {
  union() {
    union() {
       union() {
         polyhedron([[BE,CA,CC],[[0,1,2]]]);
         polyhedron([[BF,CB,CD],[[0,1,2]]]);
         polyhedron([[BA,CC,CE],[[0,1,2]]]);
         polyhedron([[BB,CD,CF],[[0,1,2]]]);
         polyhedron([[BA,CC,BE],[[0,1,2]]]);
         polyhedron([[BB,CD,BF],[[0,1,2]]]);

         polyhedron([[BB,CF,CE],[[0,1,2]]]);
         polyhedron([[BB,BA,CE],[[0,1,2]]]);

         polyhedron([[BD,BC,BH],[[0,1,2]]]);
         polyhedron([[BG,BC,BH],[[0,1,2]]]);

         polyhedron([[DC, CA, BE],[[0,1,2]]]);
         polyhedron([[DD, CB, BF],[[0,1,2]]]);

         polyhedron([[DA, DC, CA],[[0,1,2]]]);
         polyhedron([[DB, DD, CB],[[0,1,2]]]);

         polyhedron([[DC, BE, DG],[[0,1,2]]]);
         polyhedron([[DD, BF, DH],[[0,1,2]]]);

         polyhedron([[BE, BI, DG],[[0,1,2]]]);
         polyhedron([[BF, BJ, DH],[[0,1,2]]]);

         polyhedron([[BI, DG, DH],[[0,1,2]]]);
         polyhedron([[BI, BJ, DH],[[0,1,2]]]);


      }
      
    }
    union() {
       union() {
         polyhedron([[DA,DC,DE],[[0,1,2]]]);
         polyhedron([[DB,DD,DF],[[0,1,2]]]);
         polyhedron([[DG,DC,DE],[[0,1,2]]]);
         polyhedron([[DH,DD,DF],[[0,1,2]]]);
      }
     
    }
  }
  
}

module XW_NoseTip () {
  intersection() {
  #  union() { Psphere ([0,-4,18], 5);}
  #  union() { Psphere ([0,12,17], 12.6);}
  #   union() { scale ( [10,0.9,1]) translate ( [0,1,17]) Psphere ([0,0,0], 1);}
  #  union() {  Pbox ([-2, -2, 17], [2, 2, 25]);}
  # union() {  Pbox ([-0.25, 0.65, 19], [0.25, 5, 25]);}
  #  union() {
       scale ( [1,1,2.75])
       translate ( [0,0,18])union() {
        union() {  Pcone ([0,0,0], 1.15, [0,2,0], 0.25);}
        union() {  Pcone ([0,0,0], 1.15, [0,-0.6,0], 0.85);}
      }
      
    }
  }
  
}

//********** Front End of body / nose assembly - uses triangle mesh
 

module XW_Pilot () {
  union() {
    union() {
      difference() {
        union() {
          union() {
            union() { Psphere ([0,1.05,0], 0.25);}
            union() {  Pcylinder ([-0.05, 1.05, 0], [0.05, 1.05, 0], 0.265);}
            union() {  Pcylinder ([-0.01, 1.05, 0], [0.01, 1.05, 0], 0.2651);}
          }
        }
 
        union() {  scale ( [1,0.4,1]) translate ( [0,1.05,0]) Pcylinder ([-1,0,0.3], [1,0,0.3], 0.25);}
      }
       
    }
    union() {
      Psphere ([0,1.05,0], 0.23);
         }
    }
    union() {  Pcylinder ([0,0.7,0.2], [0,0.2,0.15], 0.01);}
    union() {
      intersection() {
        union() {    rotate (   [0,0,90]) translate ( [0,0.7,0 ]) Ptorus (0.2, 0.01);}
        union() {  Pbox ([-1, 0.7, 0], [1, 0.9, 1]);}
      }
       }
    
    union() {
      union() {
        union() { scale ( [2,1,1]) translate ( [0,0.7,0 ])Psphere ([0,0,0], 0.2);}
        union() {  scale ( [1.5, 1, 1 ]) Pcone ([0,0.2,0], 0.15, [0,0.7,0], 0.2);}
        union() { scale ( [1.5, 1, 1 ])Psphere ([0,0.2,0], 0.15);}
      }
       
    }
  
    union() { scale ( [1,1,1])XW_PilotHalf() ;}
    union() { scale ( [-1,1,1])XW_PilotHalf ();}
  }
 
  module XW_PilotHalf () {
      union() {
        union() {  Pcone ([-0.3, 0.7, 0], 0.1, [-0.45, 0.4, 0.25], 0.08);}
        union() { Psphere ([-0.45, 0.4, 0.25], 0.08);}
        union() {  Pcone ([-0.45, 0.4, 0.25], 0.08, [-0.3, 0.4, 0.6], 0.06);}
        union() {  Pcone ([-0.17, 0.15, 0], 0.15, [-0.25, 0.05, 0.5], 0.12);}
        union() {Psphere ([-0.25, 0.05, 0.5], 0.12);}
        union() {  Pcone ([-0.25, 0.05, 0.5], 0.12, [-0.25, -0.05, 1], 0.08);}
        union() {Psphere ([-0.3, 0.4, 0.6], 0.06);}
        union() {Psphere ([-0.27, 0.4, 0.63], 0.06);}
      }
     }
module XW_BodyTopDetail () {
  union() {
  
    union() {  Pbox ([-0.75, 1.65, -6.25], [0.75, 1.9, 1]);}
  }
}


 


module LandingGear () {
  union() {
    union() {  Pcylinder ([0,0,0], [0,-4,0], 0.1);}
    union() {  Pcone ([0,-4,0], 0.2, [0, -3.5, 0], 0.1);}
    union() {  Pcylinder ([0,0,-0.5], [0,-4,-0.5], 0.05);}
    union() {  Pbox ([-0.3,-4,-1.5], [0.3, -3.9, 1]);}
    union() {
        rotate ( [-35,0,0])
       translate ( [0,-4,1])   Pbox ([-0.3, 0, 0], [0.3, 0.1, 0.5]);}
    
      
    }
  }
  
 

module L_XWing () {
    translate (   [0,4,0])
   scale ( 0.4 ) union() {
    union() {XW_BodyRearB();}
    union() {XW_BackHatch();}
    union() {XW_NoseUnderSide();}
    union() {XW_NoseTip();}
    union() {XW_Screen();}
    union() {XW_ScreenSurround();}
    union() { scale ( 1.65)  translate ( [0, 0, 5])rotate ( [-15,0,0])XW_Pilot  ();}
    union() {XW_Cockpit();}
    union() { translate ( [0,0.1,0])  scale( [1,1,1])L_XW_Wing ();}
    union() { translate ( [0,0.1,0]) scale ( [-1,1,1])L_XW_Wing ();}
    union() { translate ( [0,0.1,0]) scale ( [1,-1,1])L_XW_Wing ();}
    union() { translate ( [0,0.1,0]) scale ( [-1,-1,1])L_XW_Wing ();}
     union() {XW_BodyTopDetail();}
    union() {translate ( [0,0,16])LandingGear()  ;}
    union() {translate ( [-3.5, 0, -2])LandingGear () ;}
    union() {translate ( [3.5, 0, -2])LandingGear()  ;}
  }

  
}