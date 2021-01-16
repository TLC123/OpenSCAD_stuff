p= [
[5,5,7],[3,9,8],[7,6,6],[4,8,6],[1,5,3],
[8,8,10],[4,4,6],[5,8,2],[5,9,2],[5,2,4],
[9,4,8],[10,3,8],[0,1,7],[5,8,7],[7,3,7],
[3,9,6],[7,1,8],[8,6,4],[0,5,8],[3,1,4]];
// Iof :index_of_...  
echo("min/max point of x",p[minX(p)],p[IofmaxX(p)]);
echo("min/max point of y",p[IofminY(p)],p[IofmaxY(p)]);
echo("min/max point of z",p[IofminZ(p)],p[IofmaxZ(p)]);

echo("min/max of x", minX(p) , maxX(p) );
echo("min/max of y",  minY(p) , maxY(p) );
echo("min/max of z",  minZ(p) , maxZ(p) );

function IofminX(p)=let(m=min([for(i=p)i.x]))search(m,p,0, 0)[0];
function IofmaxX(p)=let(m=max([for(i=p)i.x]))search(m,p,0, 0)[0];
function IofminY(p)=let(m=min([for(i=p)i.y]))search(m,p,0, 1)[0];
function IofmaxY(p)=let(m=max([for(i=p)i.y]))search(m,p,0, 1)[0];
function IofminZ(p)=let(m=min([for(i=p)i.z]))search(m,p,0, 2)[0];
function IofmaxZ(p)=let(m=max([for(i=p)i.z]))search(m,p,0, 2)[0];

function minX(p)=min([for(i=p)i.x]);
function maxX(p)=max([for(i=p)i.x]);
function minY(p)=min([for(i=p)i.y]);
function maxY(p)=max([for(i=p)i.y]);
function minZ(p)=min([for(i=p)i.z]);
function maxZ(p)=max([for(i=p)i.z]);

