 union () {
         union () {
           translate ([-40.0, 0, 8.0]) {
            rotate (a=16.0, v=[0, 1, 0]) {
            thing();
            }
           }
         }
         union () {
           translate ([-20.0, 0, 2.0]) {
            rotate (a=8.0, v=[0, 1, 0]) {
            thing();
        
            }
           }
         }
         union () {
           translate ([0.0, 0, 0.0]) {
            rotate (a=-0.0, v=[0, 1, 0]) {
            thing();
        
            }
           }
         }
         union () {
           translate ([20.0, 0, 2.0]) {
            rotate (a=-8.0, v=[0, 1, 0]) {
            thing();
        
            }
           }
         }
         union () {
           translate ([40.0, 0, 8.0]) {
            rotate (a=-16.0, v=[0, 1, 0]) {
            thing();
        
            }
           }
         }

}
color("red"){
hull(){ 
 union () {
   translate ([-40.0, 0, 8.0]) {
    rotate (a=16.0, v=[0, 1, 0]) {
    thingright();
    }
   }
 }
 union () {
   translate ([-20.0, 0, 2.0]){
    rotate (a=8.0, v=[0, 1, 0]) {
    thingleft();

    }
   }
 }
}



hull(){


 union () {
   translate ([-20.0, 0, 2.0]) {
    rotate (a=8.0, v=[0, 1, 0]) {
    thingright();
    }
   }
 }
 union () {
   translate ([-00.0, 0, 0.0]){
    rotate (a=0.0, v=[0, 1, 0]) {
    thingleft();

    }
   }
 }
}

hull(){


 union () {
   translate ([20.0, 0, 2.0]) {
    rotate (a=-8.0, v=[0, 1, 0]) {
   thingleft();
    }
   }
 }
 union () {
   translate ([-00.0, 0, 0.0]){
    rotate (a=0.0, v=[0, 1, 0]) {
     thingright();

    }
   }
 }
}


hull(){
 union () {
   translate ([40.0, 0, 8.0]) {
    rotate (a=-16.0, v=[0, 1, 0]) {
   thingleft();
    }
   }
 }
 union () {
   translate ([20.0, 0, 2.0]){
    rotate (a=-8.0, v=[0, 1, 0]) {
     thingright(); 

    }
   }
 }
}


 }






module thingleft (){ 
 
      render() difference () {
        cube ([19-.001, 19-.001, 4.901], center=true);
        cube ([18.99, 20.001, 10], center=true);
       translate ([10, 0,0]) cube ([25, 20, 10], center=true);
        
       } 
     };
module thingright (){ 
 
      render() difference () {
        cube ([19.001, 19.001, 4.901], center=true);
        cube ([18.99, 20.001, 10], center=true);
       translate ([-10, 0,0]) cube ([25, 20, 10], center=true);
        
       } 
     };


module thing(){ 
 union () {
      render() difference () {
        cube ([19, 19, 4.9], center=true);
        cube ([15, 15, 10], center=true);
        *translate ([0, 0, -3.9]) {
         cube ([15, 15, 4], center=true);
        }
       }
       translate ([0, -7.125, 0]) {
        rotate (a=90.0, v=[0, 0, 1]) {
         rotate (a=180.0, v=[0, 0, 1]) {
           rotate (a=180.0, v=[0, 1, 0]) {
           knob();
           }
         }
        }
       }
       translate ([0, 7.125, 0]) {
        rotate (a=90.0, v=[0, 0, 1]) {
         rotate (a=180.0, v=[0, 1, 0]) {
           knob();
         }
        }
       }
     }};



module knob(){
 render()

difference () {
            cube ([0.75, 2.9, 3.85], center=true);
            translate ([0, 0, 3.85]) {
             rotate (a=45.0, v=[0, 1, 0]) {
               cube ([7.5, 2.9, 3.85], center=true);
             }
            }
           }
}