t1=[1,1,1];
r1=[1,29,0];
s1=[1,1,1];

p0=[0,0,34];
translate(p0)sphere();
p1=transform(p0,t1,r1,s1);
p2=invtransform(p1,t1,r1,s1);
echo(1/r1);
translate(p1)sphere(2);
translate(p2)sphere(2);

function transform(p,T,R,S)=
 t([p.x, p.y, p.z, 1]*m_translate(T)*m_rotate(R)*m_scale(S));
function invtransform(p,T,R,S)=
 t([p.x, p.y, p.z,1]*m_scale(1/S)*m_rotate(R*-1)*m_translate(T*-1));
 
function t(v) = [v.x, v.y, v.z];
function m_rotate(v) =  [ [1,  0,         0,        0],
                          [0,  cos(v.x),  sin(v.x), 0],
                          [0, -sin(v.x),  cos(v.x), 0],
                          [0,  0,         0,        1] ]
                      * [ [ cos(v.y), 0,  -sin(v.y), 0],
                          [0,         1,  0,        0],
                          [ sin(v.y), 0,  cos(v.y), 0],
                          [0,         0,  0,        1] ]
                      * [ [ cos(v.z),  sin(v.z), 0, 0],
                          [-sin(v.z),  cos(v.z), 0, 0],
                          [ 0,         0,        1, 0],
                          [ 0,         0,        0, 1] ];
function m_translate(v) = [ [1, 0, 0, 0],
                            [0, 1, 0, 0],
                            [0, 0, 1, 0],
                            [v.x, v.y, v.z, 1  ] ];
function m_scale(v) =    [ [v.x, 0, 0, 0],
                            [0, v.y, 0, 0],
                            [0, 0, v.z, 0],
                            [0, 0, 0, 1 ] ];