filename="test.stl";
sliceh=.25;
kr= [50,36,12];
 
    singelslice()

    importt(filename);
 

 
module importt(filename="test.stl"){
    
    import(filename,convexity=30);
    }
    
    
    module singelslice(){
          slicedown()   
           children();
        }
   
        
        
        module undercut(){
           intersection (){
                   scale([0.87,0.87,1])translate([0,0,-sliceh*.1 ])
 hull()
                    children();
                
            difference(){
                children(); 
                translate([0,0,sliceh*1.01])children();
             
                }
                
                
            }
            
            } 
           
           
          
            
             module keeper(){
             
        translate([0,0,-sliceh]) 
                scale([0.95,0.95,1])
                  hull()
                    children();
                 
            
            }
            
              module slicedown(){
            union(){
                  intersection( ){
               children();
              color("blue") keeper()children();
            }
            
            
            undercut()children();}
            }
            