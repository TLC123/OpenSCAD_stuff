

echo(ReFramePlaneToOriginType([0,-2,1],un([0,1,1]))
);

function ReFramePlaneToOriginType(point,normal)=
dot(point,normal);
function dot(a,b)=a*b;
function un(vector)=vector/norm(vector);