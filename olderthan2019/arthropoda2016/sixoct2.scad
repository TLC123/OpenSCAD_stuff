sixring=[[0,0,0],[1,0,0.1],[2,0,0],[2,1,0],[1,1,0.1],[0,1,0]];
offs=[0,0,1];
octring=[
sixring[0]+offs,
sixring[1]+offs,
sixring[2]+offs,
(sixring[2]+sixring[3])/2+offs,
sixring[3]+offs,
sixring[4]+offs,
sixring[5]+offs,
(sixring[5]+sixring[0])/2+offs
];


echo(len(concat(sixring,octring)));
polyhedron(concat(sixring,octring),[[0,1,2,8,7,6],[3,4,5,12,11,10],[5,0,6,13,12],[2,3,10,9,8]]
);

color("Red"){

polyhedron(sixring,[[0,1,2,3,4,5]]
);

polyhedron(octring,[[0,1,2,3,4,5,6,7]]); }