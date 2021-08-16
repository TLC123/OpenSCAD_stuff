a=[for([1:100000])round(rands(0,100,1)[0])];
 
d=[for(i=search([5] ,a,0 ),j=i)j];

function inverse_select(punchOuts,all)=
[for(i=[0:len(all)-1])if(search(i,punchOuts)==[])i];

selection=[for(i=d)a[d]];
remainder=[for(i=inverse_select(d,a))a[d]];
    
 echo(len(a),len(selection),len(remainder),len(selection)+len(remainder));
 function unique (m)= [
        for (i = [0: max(0, len(m) - 1)])
            if (search([m[i]], m, 1) == [i]) m[i]];