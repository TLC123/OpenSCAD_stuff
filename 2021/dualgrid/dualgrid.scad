so=2;
so2=so*3 ;
for(x=[-10:so:10 ],y=[-10:so:10 ])
{
    line(snap([x,y]),snap([x,y]+[so,0]));
    line(snap([x,y]),snap([x,y]+[0,so]));
 
 
    dual=[x,y]-[so,so]/2;
    point(ncenter(dual));
    
    
  color("blue") {
      line(ncenter(dual),ncenter(dual+[so,0]));
    line(ncenter(dual),ncenter(dual+[0,so]));
    }
    }



module line (a,b){
    
    hull(){
    
    translate(a) sphere( .1);
    translate(b)sphere(.1);
    }
    }
    
    module point(b){
            translate(b)sphere(.1);

        }
 function   snap(p)= (norm([p.x-.05,p.y ]))<4.5?[round(p.x/so2)*so2,round(p.y/so2)*so2]:p;
        
    function ncenter(p)=(
    snap(p+[so,so]/2)+
    snap(p+[-so,so]/2)+
    snap(p+[-so,-so]/2)+
    snap(p+[so,-so]/2)
    )/4; 