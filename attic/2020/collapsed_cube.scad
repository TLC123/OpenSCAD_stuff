u=[[0,0,0],[1,0,0],[1,1,0],[0,1,0],[0,0,1],[1,0,1],[1,1,1],[0,1,1]];
l=[for(i=u)round(rands(0,10,1)[0])>5?mutate(i):i];

call=collapsedEdges(l);
call2=collapsedCross(l);
call3= eq2avrg(l);

echo(call,call2 ,call3 ,
call>=7?"by 1 invalid":"",
odd(call2+call+1)?"by 2 invalid":"",
abs(call3)<=1?"by 3 invalid":"");

function flatten(v)=[for(n=v)for( nn=n)nn];
    

union()
{polyhedron(
l,

[[0,1,2],[0,2,3],[4,6,5],[4,7,6],
    [0,4,5],[1,0,5],[1,5,6],[2,1,6],
    [2,6,7],[2,7,3],[3,7,4],[0,3,4]]);
cube(.001);
}
//    0123
//    4567

function mutate(p)=[0.5,.5,0.5];
function odd(n)=n%2>=1;
 
// doesn not do whats intended
function eq2avrg(l)=   ones(3)*(ones(8)*([for([1:8])l[0]]-l));
function collapsedEdges(l)=let(eds=EDGES())(ones(len(eds))*[for(ed=eds)l[ed[0]]==l[ed[1]]? 1:0])
    ;
 function collapsedCross(l)=    
 (l[0]==l[6]?0:1)+
 (l[1]==l[7]?0:1)+
 (l[2]==l[4]?0:1)+    
 (l[3]==l[5]?0:1)+ 
(
(((l[0]==l[2])==(l[1]==l[3]))&&
((l[4]==l[6])==(l[5]==l[7])))&&
 
(((l[0]==l[5])==(l[1]==l[4]))&&
((l[2]==l[7])==(l[3]==l[6])))&&
 
(
((l[3]==l[4])==(l[0]==l[7]))&&
((l[1]==l[6])==(l[2]==l[5])))?0:1 )
;
function EDGES() = [
    [0,1],    [1,2],    [2,3],
    [3,0],    [4,5],    [5,6],
    [6,7],    [7,4],    [0,4],
    [1,5],    [2,6],    [3,7]  ];
function ones(l)=[for([1:l])1];