//sixring=[[0,0,0],[1,0,0.1],[2,0,0],[2,1,0],[1,1,0.1],[0,1,0]];
sixring=sixring();
octring= octring([0,0,0.05],0.8);
/*offs=[0,0,0.33];

octring=[
sixring[0]+offs,
sixring[1]+offs,
sixring[2]+offs,
(sixring[2]+sixring[3])/2+offs,
sixring[3]+offs,
sixring[4]+offs,
sixring[5]+offs,
(sixring[5]+sixring[0])/2+offs
]*0.67;*/


echo(len(concat(sixring)));
polyhedron(concat(sixring,octring),[[0,1,7,6],[1,7,8],[1,2,8],[2,9,8],[2,3,10,9],[3,4,11,10],[4,12,11],[4,5,12],[5,13,12],[0,5,13,6]]
);

color("Red"){

polyhedron(sixring,[[0,1,2,3,4,5]]
);

//polyhedron(octring,[[0,1,2,3,4,5,6,7]]); 
    }

function sixring()=[for(i=[0:360/6:359])[sin(i),cos(i),0]];
    function octring(v,s)=[for(i=[0:360/8:359])[sin(i)*1,cos(i),sin(i)*0]*s+v];