v1=[rands(0,100,1)[0],rands(0,100,1)[0],rands(0,100,1)[0],rands(1,20,1)[0]];
v2=[rands(0,100,1)[0],rands(0,100,1)[0],rands(0,100,1)[0],rands(1,20,1)[0]];
v3=[rands(0,100,1)[0],rands(0,100,1)[0],rands(0,100,1)[0],rands(1,20,1)[0]];
v4=[rands(0,100,1)[0],rands(0,100,1)[0],rands(0,100,1)[0],rands(1,20,1)[0]];
v5=[rands(0,100,1)[0],rands(0,100,1)[0],rands(0,100,1)[0],rands(1,20,1)[0]];


module bez(t,v){
    unt=1-t;
    if (len(v)>1){
   v2 = [ for (i = [0 : 1 : len(v)-2])v[i]*t+v[i+1]*unt ];
    bez(t,v2);
    
    
    }else{echo (v[0]);
        p=v[0];
       translate([p[0],p[1],p[2],]) sphere(d=p[3],$fn=10);}
    }



module bline(v){
    union(){for (i=[0:0.1:1])
    {
        hull(){
            bez(i,v);
            bez(i-0.1,v);
        }
        
        }  }  
    
    
    }
    
  bline([v1,v2,v3,v4,v5]);  