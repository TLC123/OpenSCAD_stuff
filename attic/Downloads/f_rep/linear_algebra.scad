use <lists.scad>

// true iff p is a d dimension point or vector
function isPoint(p,d) =
    d==undef? 0*p==[0,0]||0*p==[0,0,0] 
    : 0*p==[for(i=[1:d]) 0];
/*
echo([0],isPoint([0])); // false
echo([0,0],isPoint([0,0])); // true
echo([0,0],isPoint([0,0],3)); // false
echo([0,0,0],isPoint([0,0,0])); // true
echo([0,0,0],isPoint([0,0,0],2)); // false
echo([0],isPoint([0],1)); // true
*/
// true is p is a list of objects with same structure
function isUniform(p,b) =
    let( c = b==undef? 0*p[0] : 0*b )
    len(p)>=0 && 0*p==[for(q=p) c];
/*
echo(isUniform(1)); // false
echo(isUniform([]));// true
echo(isUniform([1,2]));// true
echo(isUniform([1,[2]]));// false
echo(isUniform([[1,[2]]]));//true
echo(isUniform([1,2],0));// true
echo(isUniform([[1],[2]]));// true
echo(isUniform([[1],[2]],0));// false
echo(isUniform([[1],[2]],[1]));// true
*/
// linear combination
// this is more general than v*coeff
function linearComb(v,coeff) = 
    !isPoint(coeff) || len(v)!=len(coeff)? undef :
    g_sum([for(i=[0:len(v)-1]) v[i]*coeff[i]]);

/*
echo(linearComb([[1,2],[10,20]],[1,2])); // [21,42]
echo(linearComb([[1,2],[10,20]],[[1,2]]));// undef
echo(linearComb([[1,2],[10,20]],[1,2,3]));// undef
echo(linearComb([[1,2],[10,20]],[1])); // undef
echo(linearComb([[1,[2]],[10,[20]]],[1,2]));// [21,[42]]
*/

function unit(v) = norm(v)>0 ? v/norm(v) : [ for(c=v) 0 ]; 
// m is a retangular matrix of any kind of objects
function transpose(m) = 
    [ for(i=[0:len(m[0])-1]) [ for(j=[0:len(m)-1]) m[j][i] ] ];

function trace(M) = sum_vectors([ for(i=[0:len(M)-1]) M[i][i] ]);

function identity(n=3) =
    [ for(i=[0:n-1]) [ for(j=[0:n-1]) i==j? 1 : 0 ] ];
// determinant of 3x3 or 4x4 matrices of floats
function determin(M) = 
    len(M)==3 && len(M[0])==3 ? M[0]*cross(M[1],M[2])
    : len(M)==4 && len(M[0])==4 ? M[0]*[ for(i=[0:3]) cofactor_4(M, 0, i) ]
    : undef;

function cofactor_4(M,i,j) = 
    determin(
        [ for(l=[0:3]) if( l!= i) [ for(k=[0:3]) if (k != j) M[l][k] ] ] )*pow(-1,i+j);

function invMatrix(M) = 
    len(M)==3 && len(M[0])==3 ?
        let( det = determin(M) )
        abs(det)<1e-32 ? undef :
            transpose( [ cross(M[1],M[2]), cross(M[2],M[0]) ,cross(M[0],M[1])] )/det
    : len(M)==4 && len(M[0])==4 ?
        let( M2 = M*M, M3 = M2*M, 
             tM = trace(M), tM2 = trace(M2), tM3 = trace(M3),
             d  = determin(M) )
        abs(d) < 1e-32 ? undef :
            ( identity(4)*(pow(tM,3)-3*tM*tM2+2*tM3)/6 - M*(tM*tM - tM2)/2 + M2*tM - M3 )/d 
    : undef ;

// sort a list of 3 numbers
function _sort_3(a) = 
    a[0]<=a[1]? 
        a[0]<=a[2]? 
            a[1]<=a[2]? 
                a :
                [ a[0], a[2], a[1] ] :
            [ a[2], a[0], a[1] ] :
        // a[1]<a[0]
        a[0]<=a[2]? 
            [ a[1], a[0], a[2] ] :
            a[1]<=a[2]?
                [ a[1], a[2], a[0] ] :
                [ a[2], a[1], a[0] ];
// check if M is 3x3 symetrical
function _isS3(M) = 
    len(M)==3 && len(M[0])== 3 &&
    is_empty([ for(i=[0:2]) for(j=[0:2]) if( (i!=j) && abs(M[i][j]-M[j][i]) > 1e-16 ) 0 ]);

// Eigenvalue computation for 3x3 symmetrical matrices
// Based on: https://en.wikipedia.org/wiki/Eigenvalue_algorithm
function eigenvalS3(M) =
    !_isS3(M)? [] :
    let( p1 = pow(M[0][1],2) + pow(M[0][2],2) + pow(M[1][2],2) )
    (p1==0) ?  
        _sort_3([ M[0][0], M[1][1], M[2][2] ]) : // diagonal matrix
        let(  q  = trace(M)/3,
              p2 = pow(M[0][0]-q, 2) + pow(M[1][1]-q, 2) + pow(M[2][2]-q, 2) + 2*p1,
              p  = sqrt(p2/6),
              M2 = (M - q*identity())/p,
              r  = determin(M2)/2,
              ph = r<=-1? 60: r>=1? 0 : acos(r)/3,
              e1 = q + 2*p*cos(ph),
              e3 = q + 2*p*cos(ph+120),
              e2 = 3*q - e1 - e3 )
         [ e3, e2, e1 ];

// i-th normalized eigenvector of M from its eigenvalues
function __eigvec(M,eigenvals,i=0) = 
    let(  A  = transpose( (M - eigenvals[(i+1)%3]*identity()) * (M - eigenvals[(i+2)%3]*identity()) ),
          n0 = norm(A[0]), n1 = norm(A[1]), n2 = norm(A[2]) )
    n0 > n1 ? // choose the column of A with the greatest norm
        n0 > n2 ?
            n0 == 0 ? A[0] : A[0]/n0 :
            n2 == 0 ? A[2] : A[2]/n2 :
        n1 > n2 ?
            n1 == 0 ? A[1] : A[1]/n1 :
            n2 == 0 ? A[2] : A[2]/n2 ;

// All eigenvectors and eigenvalues of a 3x3 symmetrical matrix
function eigenvvS3(M) =
    !_isS3(M)? [] :
       let( evals = eigenvalS3(M) )
       [ evals, [ for(i=[0:2]) __eigvec(M, evals, i) ] ];
            
// i-th eigenvector of a 3x3 symmetrical matrix
function eigenvecS3(M,i=0) =
    !_isS3(M)? [] :
      __eigvec(M, eigenvalS3(M), i);
            
// Least square adjustment of a plane to a set of 3D points
// Return a list with two values:
//   pm    - a point the adustment plane pass through
//   evvs  - a orthonormal reference system where:
//           evvs[0] and evvs[1] is a reference for the plane
//           evvs[2] is a normal to the plane
// If no solution is found, returns [].
function least_square_adjust_3(p) =
    let(  pm   = sum_vectors(p)/len(p), // mean point
          Y    = [ for(i=[0:len(p)-1]) p[i] - pm ],
          M    = transpose(Y)*Y ,     // covariance matrix
          evvs = eigenvvS3(M) )
      [ pm, evvs[1] ];
        