//function CalculateCubeQEF(  normals,  positions,   meanPoint)
//    {
////        var A = DenseMatrix.OfRowArrays(normals.Select(e => new[] { e.X, e.Y, e.Z }).ToArray());
////        var b = DenseVector.OfArray(normals.Zip(positions.Select(p => p - meanPoint), Vector3.Dot).ToArray());
////
////        var pseudo =  matrix_invert(A);
////          leastsquares = pseud*b;
////
////          leastsquares + DenseVector.OfArray(new[] { meanPoint.X, meanPoint.Y, meanPoint.Z });
//    }


function un(v) = v / max(norm(v), 1e-64) * 1;
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);

function det(m) = let(r=[for(i=[0:1:len(m)-1]) i]) det_help(m, 0, r);
function det_help(m, i, r) = len(r) == 0 ? 1 :
m[len(m)-len(r)][r[i]]*det_help(m,0,remove(r,i)) - (i+1<len(r)?
det_help(m, i+1, r) : 0);

function matrix_invert(m) = let(r=[for(i=[0:len(m)-1]) i]) [for(i=r)
[for(j=r)
((i+j)%2==0 ? 1:-1) * matrix_minor(m,0,remove(r,j),remove(r,i))]] / det(m);
function matrix_minor(m,k,ri, rj) = let(len_r=len(ri)) len_r == 0 ? 1 :
m[ri[0]][rj[k]]*matrix_minor(m,0,remove(ri,0),remove(rj,k)) -
(k+1<len_r?matrix_minor(m,k+1,ri,rj) : 0);

function transpose(m)=[for(i=[0:len(m[0])-1])[for(j=[0:len(m)-1])m[j][i]]];



m=[un(rands(-1,1,4)),un(rands(0,1,4)),un(rands(0,1,4)),un(rands(0,1,4))];
n=un(rands(0,1,4));
mecho(m);
im=transpose(m);
mecho(im);
mecho(m*im);
echo(im*n);
function remove(list, i) = [for (i_=[0:1:len(list)-2]) list[i_ < i ? i_ : i_ + 1]];
    

module mecho(m)
{ cr=chr(13);
  tab=chr(9);
    stgr=str(cr,cr,"[",cr,p(m[0]),cr,p(m[1]),cr,p(m[2]),cr,p(m[3]),cr,"]",cr,cr);
      echo(stgr);
    }

function p (i)=let(tab=chr(9))
    str("[ ",(decround(i[0])),", ",pp(i[1]),", ",pp(i[2]),", ",pp(i[3]),",",tab," ]");

function pp(i)= let(i=decround(i)) sign(i)==-1? 
         (str(chr(9),i))
    :
     (str(chr(9)," ",str(i)));
    function decround(i)=round(i*1000)/1000;