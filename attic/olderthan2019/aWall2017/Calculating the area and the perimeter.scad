//Calculating perimeter, area and volume 
//perimiters
function Perimeter_Of_A_Triangle_By_Sides(A,B,C)=A+B+C;
function Perimeter_Of_A_Equilateral_Triangle_By_Side(A )=A+A+A ;
function Perimeter_Of_A_Isosceles_Triangle_By_Base_And_Height
    (A,h)= A*sqrt((a/2)*(a/2)+h*h);
function Perimeter_Of_A_Rectangle_By_Sides(A,B)=A+A+B+B;
function Perimeter_Of_A_Circle_By_Radius(r)=2*PI*r;
function Perimeter_Of_A_Ellipse_By_Radius(r1,r2)=
    PI*(3*(r1+r2)-sqrt((3*r1+r2)*(r1+3*r2)));
function Perimeter_Of_A_Regular_Polygon_By_Side_And_N(A,N)= A*N;
function Perimeter_Of_A_Regular_Polygon_By_Radius_And_N(r,N)= 
     2*N*r*sin(180/N);
function Perimeter_Of_A_Regular_Polygon_By_Inradius_And_N(r,N)=   2*N*r*tan(180/N);
function Perimeter_Of_A_Irregular_Polygon_By_Points(points, i=1) =let(   
     Side = (norm(points[i]-points[i-1])))
    i<len(points)?Side +Perimeter_Of_A_Irregular_Polygon_By_Points(points, i+1) :(norm(points[0]-points[i-1])); 

//  Area:
function Area_Of_A_Triangle_By_Sides(a,b,c)=
    let(s=(a+b+c)/2) sqrt(abs(s*(s-a)*(s-b)*(s-c)));
function Area_Of_A_Triangle_By_Base_Heigh(A,h)=(1/2)*A*h;
function Area_Of_A_Equilateral_Triangle_By_Side(A)= sqrt(3)/4 *(A*A);
function Area_Of_A_Rectangle_By_Sides(A,B)=A*B;
function Area_Of_A_Circle_By_Radius(r)=r*r*PI;
function Area_Of_A_Ellipse_By_Radius(r1,r2)=r1*r2*PI;
function Area_Of_A_Regular_Polygon_By_Side_And_N(A,N)=
     A*A*N/(4*tan(180/N));
function Area_Of_A_Regular_Polygon_By_Radius_And_N(r,N)=
    (r*r*N*sin(360/N))/2;
function Area_Of_A_Regular_Polygon_By_Inradius_And_N(r,N)= 
    r*r*N*tan(180/n);
function  Area_Of_A_Irregular_Polygon_By_Points(points, i=1) =
    let(
    area = (points [i-1].x+points[i].x) * (points[i-1].y-points[i].y))
    i<len(points)?
    area/2 +Area_Of_A_Irregular_Polygon_By_Points(points, i+1) 
    :(points [i-1].x+points[0].x) * (points[i-1].y-points[0].y)/2; 


// 3D Area
function Area_Of_A_Cuboid_By_Sides(A,B,C)=2*(A*B+A*C+C*B);
function Area_Of_A_sphere_By_Radius(r1 )=  4 *PI* r*r ;
function Area_Of_A_Ellipsoid_By_Radius(r1,r2,r1 )=  
    4 * PI * pow(((r1*1.6075*r2*1.6075 + r1*1.6075*r3*1.6075
    + r2*1.6075*r3*1.6075)/3),1/1.6075);
function Area_Of_A_Cylinder_By_Radius_And_Height(r,h )= 
    2*(PI*r*r)+ 2*PI*r*h;
function Area_Of_A_Cone_By_Radius_And_Height(r,h )= 
    PI*r*r+ PI*r*sqrt(r*r+h*h);
function Area_Of_A_Pyramid_By_Sides_And_Height(A,B,h )= 
    A*B+ 2*( (1/2)* A* (sqrt(h*h+(B/2)*(B/2))) )
       + 2*( (1/2)* B* (sqrt(h*h+(A/2)*(A/2))) );
function Area_Of_A_Prism_By_Sides_Height(A,B,C,H)=let(s=(a+b+c)/2) 
    2*sqrt(abs(s*(s-a)*(s-b)*(s-c)))+A*H+B*H+C*H;
function Area_Of_A_Equilateral_Prism_By_Side_Height(A,H)=
    sqrt(3)/4 *(A*A) +A*H*3;
function Area_Of_A_Isosceles_Prism_By_Base_Heights(A,h,H)=
    2*((1/2)*A*h)+ A*sqrt((a/2)*(a/2)+h*h)*H;


//  Volumes:
function Volume_Of_A_Prism_By_Sides_Height(A,B,C,H)=
    let(s=(a+b+c)/2) sqrt(abs(s*(s-a)*(s-b)*(s-c)))*H;
function Volume_Of_A_Prism_By_Base_Heights(A,h,H)=
    (1/2)*A*h*H;
function Volume_Of_A_Cuboid_By_Sides(A,B,C)=A*B*C;
function Volume_Of_A_Sphere_By_Radius(r )=(4/3)*PI* r*r*r ;
function Volume_Of_A_Ellipsoid_By_Radius(r1,r2,r1 )=
    (4/3)*Pi* r1* r2* r3 ;
function Volume_Of_A_Cylinder_By_Radius_And_Height(r,h )= 
    PI*r*r*h;
function Volume_Of_A_Cone_By_Radius_And_Height(r,h )= 
    PI*r*r*h*(1/3);
function Volume_Of_A_Pyramid_By_Sides_And_Height(A,B,h )= 
    A*B*h*(1/3);

function Radius_A_Regular_Polygon_By_Side_And_N(A,N)= A/(2*sin/(180/N));
function Radius_A_Regular_Polygon_By_Inradius_And_N(r,N)=r/(cos/(180/N));


function Radius_Of_Equilateral_Triangle_By_Side (A)=A/(2*sin/(180/3));
function Radius_Of_Square_By_Side (A)=A/(2*sin/(180/4));
function Radius_Of_Trigon_By_Side (A)=A/(2*sin/(180/3));
function Radius_Of_Tetragon_By_Side (A)=A/(2*sin/(180/4));
function Radius_Of_Pentagon_By_Side (A)=A/(2*sin/(180/5));
function Radius_Of_Hexagon_By_Side (A)=A/(2*sin/(180/6));
function Radius_Of_Heptagon_By_Side (A)=A/(2*sin/(180/7));
function Radius_Of_Octagon_By_Side (A)=A/(2*sin/(180/8));
function Radius_Of_Enneagon_By_Side (A)=A/(2*sin/(180/9));
function Radius_Of_Decagon_By_Side (A)=A/(2*sin/(180/10));
function Radius_Of_Hendecagon_By_Side (A)=A/(2*sin/(180/11));
function Radius_Of_Dodecagon_By_Side (A)=A/(2*sin/(180/12));
function Radius_Of_Trisdecagon_By_Side (A)=A/(2*sin/(180/13));
function Radius_Of_Tetradecagon_By_Side (A)=A/(2*sin/(180/14));
function Radius_Of_Pentadecagon_By_Side (A)=A/(2*sin/(180/15));
function Radius_Of_Hexadecagon_By_Side (A)=A/(2*sin/(180/16));
function Radius_Of_Heptadecagon_By_Side (A)=A/(2*sin/(180/17));
function Radius_Of_Octadecagon_By_Side (A)=A/(2*sin/(180/18));
function Radius_Of_Enneadecagon_By_Side (A)=A/(2*sin/(180/19));
function Radius_Of_Icosagon_By_Side (A)=A/(2*sin/(180/20));