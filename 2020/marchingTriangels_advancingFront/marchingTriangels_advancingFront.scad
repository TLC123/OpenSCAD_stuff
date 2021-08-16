points=[for([0:99])rands(0,20,2)];
    
for(t=points)translate(t) sphere(.1);
    
edgelist=[round(rands(0,99,1)[0])];
for(i=edgelist)translate( points[i])sphere(.2);
    
closeList=[for(t=points)t==points[edgelist[0]]?1/0:norm(t-points[edgelist[0]])];
closest=search(min(closeList),closeList,1)[0];
echo(closest,edgelist[0])
color("blue")translate( points[closest] )sphere(.2);
