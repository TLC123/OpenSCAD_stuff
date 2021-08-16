circle=[rnd(100),rnd(100.150),rnd(1,45)];
point=[rnd(100),rnd(100)];
line=[[rnd(100),rnd(100)],[rnd(100),rnd(100)]];
line2=[[rnd(100),rnd(10)],[rnd(10),rnd(100)]];
echo(circle, featurecenter(circle)   ) ; 
echo(point, featurecenter(point)   ) ; 
echo(line, featurecenter(line)   ) ; 

function featurecenter(feat)=
len(feat)==2&&len(feat[0])==undef?feat:
len(feat)==3&&len(feat[0])==undef?[feat.x,feat.y]:
len(feat)==2&&len(feat[0])==2?(feat[0]+feat[1])/2:
[0,0];




 function rnd(a = 1, b = 0, s = []) =
s == [] ?
  (rands(min(a, b), max(
    a, b), 1)[0]) :
  (rands(min(a, b), max(a, b), 1, s)[0]);