finger=4;
all=[0:finger];
//crazy=[];//[for(a=all)[for(b=all)[for(c=all)str(a,b,c)]]];
crazy=store (r=10000);

test=adv(100);
echo(test)
echo( read(crazy,test));
crazy2=write(test,crazy,"Boom");
for(a=[0:99])
echo( read(crazy2,adv(a+1)));



function write( addr,crazy,insert)= 
[for(a=all)a!=addr[0]?crazy[a]:  
    [for(b=all)b!=addr[1]?crazy[a][b]:  
        [for(c=all)c!=addr[2]?crazy[a][b][c]:  
            [for(d=all)d!=addr[3]?crazy[a][b][c][d]:  
                [for(e=all)e!=addr[4]?crazy[a][b][c][d][e]:  
                    [for(f=all)f!=addr[5]?crazy[a][b][c][d][e][f]:  
                        [for(g=all)g!=addr[6]?crazy[a][b][c][d][e][f][g]:  
                                  insert

                             
                        ]
                    ]
                ]
            ]
        ]
    ]
]    
;
                        
function read(crazy,a)=crazy[a[0]][a[1]][a[2]][a[3]][a[4]][a[5]][a[6]];
function randomAddr()=[for([0:7])round(rands(0,finger,1)[0])];
function store (crazy,r)=
r>0?
let(addr=randomAddr())
store(write( adv(r) ,crazy,str(r,"WOOHAA")),r-1) 
:
crazy
;

function adv(a)=
[
round(a%finger),
round((a/finger)%finger),
round(a/pow(finger,2)%finger),
round(a/pow(finger,3)%finger),
round(a/pow(finger,4)%finger),
round(a/pow(finger,5)%finger),
round(a/pow(finger,6)%finger) ]
;