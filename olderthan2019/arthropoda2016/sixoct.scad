sixring=[[0,0,0],[1,0,0.1],[2,0,0],[2,1,0],[1,1,0.1],[0,1,0]];
octring=[[0.5,0.1,1.1],[1,0 ,1.1],[1.5,0.1,1.1],[2,0.5,1 ],[1.5,0.9,1.1],[1,1,1.1],[0.5,0.9,1.1],[0,0.5,1]];
octring2=octring *1.2 +[for(i=[1:len(octring)])[0,0,0.5]];
octring3=octring2 *1  +[for(i=[1:len(octring)])[0,0,1.5]];
octring4=octring3 *0.8  +[for(i=[1:len(octring)])[0,0,1]];
hull(){
polyhedron(sixring,[[0,1,2,3,4,5]]
);

polyhedron(octring,[[0,1,2,3,4,5,6,7]]
); };


hull(){
    polyhedron(octring,[[0,1,2,3,4,5,6,7]]
);
polyhedron(octring2,[[0,1,2,3,4,5,6,7]]
);
   };
  
   hull(){
    polyhedron(octring2,[[0,1,2,3,4,5,6,7]]
);
polyhedron(octring3,[[0,1,2,3,4,5,6,7]]
);
   }; 
    
 hull(){   
    polyhedron(octring3,[[0,1,2,3,4,5,6,7]]
);
    polyhedron(octring4,[[0,1,2,3,4,5,6,7]]
);
};
   