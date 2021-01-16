difference(){
circle(0.5,$fn=6);
rotate(30)circle(0.25,$fn=6);
rotate(60*1)translate ([0.35,0])rotate(0)circle(0.1,$fn=5);
rotate(60*2)translate ([0.35,0])rotate(0)circle(0.1,$fn=6);
rotate(60*3)translate ([0.25,0])rotate(0)circle(0.15,$fn=6);
rotate(60*4)translate ([0.35,0])rotate(0)circle(0.1,$fn=7);
rotate(60*5)translate ([0.35,0])rotate(0)circle(0.1,$fn=8);
rotate(60*6)translate ([0.37,0])rotate(0)circle(0.2,$fn=6);
}





function roundlist(v,r = 0.01) = len(v) == undef ? v - (v % r) : len(v) == 0 ? [] : [
  for (i = [0: len(v) - 1]) roundlist(v[i],r)];