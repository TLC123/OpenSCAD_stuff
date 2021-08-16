function L_Spiral (a,radius = 50,heigth,turns =  4,xpnt=0.685,start_angle=45)
= let( fx = xpnt<0?
pow(max(0,1-a),1/abs(min(-1,xpnt-1) )): pow(max(0,1-a),max(1,xpnt+1))   ) 
[(radius * fx ) * cos(start_angle+ a* turns*360*sign(turns)),
 (radius * fx ) * sin(start_angle+ a* turns*360*sign(turns)),a*heigth];

for(j=[0:1/160:1]){hull(){
 translate(L_Spiral (j, 50,50,  4, 1.685, 0 ))sphere();
 translate(L_Spiral (j+1/160, 50,50, 4, 1.685, 0 ))sphere();
}}
 