//pub
function Area_Circle_Sector_By_Angle(radius,central_angle)=PI*radius*radius*(central_angle/360);


function Perimeter_Of_A_Circle_Sector_By_Angle(radius,central_angle)=
central_angle<360?
2*PI*radius*(central_angle/360)+(2*r)
:2*PI*radius*(central_angle/360);

function Area_Circle_Sector_By_Arc_Lenght(radius,lenght)=(radius*lenght)/2;

function Arc_Length_By_Angle(radius,central_angle)=2*PI*radius*(central_angle/360);

function Area_Of_A_Circle_Segment_By_Height(r,h)=
    (r*r)*acos((r-h)/r)*((2*PI)/360)-(r-h)*sqrt((2*r*h)-(h*h));

function Area_Of_A_Circle_Segment_By_Angle(r,c)=(r*r)/2*(PI/180*c-sin(c));
function Radius_Of_An_Arc_By_Chord_And_Height(C,h)=h/2+(C*C)/(8*h);