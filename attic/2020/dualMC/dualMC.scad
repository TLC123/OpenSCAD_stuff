scene_select=2;

sdScene   =  
 function(p)    -max( -(norm(p-[-1.15,0,0] )-2) ,norm(p-[1.15,0,0] )-2) 
;

ocTree  = sdDualMarchingCubes (sdScene,[[-5,-5,-5],[5,5,5]],5);
   showCell(ocTree);
   
   
   
   
   
   
function getCell(p,tree)=   
   
   
   
   
   
   
function isInCell(p,cell)=p.x<max(cell[].x,cell[].y)
   
    function sdDualMarchingCubes(sdScene, cell=[],sub  )=
    let(        O = cell[0], S = cell[1],  C = (O + S) / 2, D = S - O)
    let(    maxD = max( abs (D.x),abs (D.y),abs (D.z)) *.87)

let(e=   sdScene(C))
     sub>0?  
        let(e=   sdScene(C))
          abs(e)<=maxD?
            let( pxxx=[O+[0,0,0],O+[D.x,0,0],O+[0,D.y,0],O+[0,D.y,D.z],
                    O+[0,0,D.z],O+[D.x,D.y,0],O+[D.x,0,D.z],O+[D.x,D.y,D.z]])
                    [for(i=[0:7])sdDualMarchingCubes(sdScene,bflip([C,pxxx[i]]),sub-1   ) ]  :
                      [sub,cell,C]       
                    :
            
         [sub,cell,C]       ;
                    
                    function bflip(a,b) = is_undef(b)&&len(a)==2?bflip(a[0],a[1]):[ [min(a.x,b.x),min(a.y,b.y),min(a.z,b.z)], [max(a.x,b.x),max(a.y,b.y),max(a.z,b.z)] ];
                    
module printTree(t,indent=""){
if(is_list(t)&&t[0]!="leaf") {for(i=t){
//echo(str(indent,"v"));
    printTree(i,str(indent," "));}
    }
    else
        echo(str(indent,t));
                    }
                    
                    
                    module showCell(t ){
if(is_list(t)&&!is_num(t[0])) {for(i=t){
     showCell(i);}
    }
    else{
        cell= t[1];
      color(rands(0,1,3)) translate(t[2])
        
     cube(10/pow(2,8));
        
        }
    }