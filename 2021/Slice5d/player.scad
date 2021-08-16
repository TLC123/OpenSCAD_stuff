names=[for (i=[1000:1050])
    let(
t=str(str(i)[1],str(i)[2],str(i)[3]) 
)
str("slice_",t,".off")
 
];
 
frame= ((len(names)-1)*$t);
getfile=  names[frame] ;
 echo(names[frame],frame,getfile);

import(getfile);

 

