
a=seg(square(10,5));
    
function square(w,h)=[[0,0],[w,0],[w,h],[0,h]];
function seg(p)=[for(i=[0:len(p)-1])[i[p],i[(p+1)%(len(p)-1)]]];