module line(from,to){hull(){
    translate(from)cube(1);
    translate(to)cube(1);
    }}
    o=rands(-20, 20, 300);
    for(i= [1:100]){
    
    union(){ line(
        [o[i-1],o[i+100-1],o[i+200-1]],
        [o[i],  o[i+100],  o[i+200]]
        );
    
        
    }}