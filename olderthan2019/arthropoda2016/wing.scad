//// Wings generate a wing from data at[0,0,0]
//// data type 
//[[scale-vector][rotation-vector],[[overprofilelist],[underprofilelis]],[[frontedgelist],[backedgelist]]]
// all list are list of 3vector
//Specilaty Wing Functions wing1(),wing2() return default wingdata
//,blur(),sanitycheck(),roundlist(),deepmutate()
//Main module Makewing()

wing=(sanitycheck(blur(lerp(wing1(),wing2(),rnd()),0)));

echo(str("   wings=",wing,";   "));
Makewing(wing);




module Makewing(wings) {
  ////////////////////////////////module wing(wings) ///////////////////////////////////
  ///////////////////////////////////////////////////////////////////
  overskin = concat([
      let (ws = wings[2], wp = wings[1], p1 = ws[0][0], p2 = ws[1][0], d = len3(p1 - p2))[
        for (j = [0: len(wings[1][0]) - 1])[lerp(p1, p2, wp[0][j][0])[0], lerp(p1, p2, wp[0][j][0])[1], wp[0][j][2] * d*4]]
    ],
[
      let (ws = wings[2], wp = wings[1], p1 = ws[0][1], p2 = ws[1][1], d = len3(p1 - p2))[
        for (j = [0: len(wings[1][0]) - 1])[lerp(p1, p2, wp[0][j][0])[0], lerp(p1, p2, wp[0][j][0])[1], wp[0][j][2] * d*4]]
    ],
    //mid
    [
      for (i = [2: len(wings[2][0]) - 2]) let (ws = wings[2], wp = wings[1], p1 = ws[0][i], p2 = ws[1][i], d = len3(p1 - p2))[
        for (j = [0: len(wings[1][0]) - 1])[lerp(p1, p2, wp[0][j][0])[0], lerp(p1, p2, wp[0][j][0])[1] + wp[0][j][1] * d, lerp(p1, p2, wp[0][j][0])[2] + wp[0][j][2] * d]]
    ], [
      let (i = len(wings[2][0]) - 1, ws = wings[2], wp = wings[1], p1 = ws[0][i], p2 = ws[1][i], d = len3(p1 - p2))[
        for (j = [0: len(wings[1][0]) - 1])[lerp(p1, p2, wp[0][j][0])[0], lerp(p1, p2, wp[0][j][0])[1] + wp[0][j][1] * d, lerp(p1, p2, wp[0][j][0])[2]]]
    ]);
 ////////////////////////////////module wing(wings) ///////////////////////////////////
 ///////////////////////////////////////////////////////////////////
  underskin = concat([
      let (ws = wings[2], wp = wings[1], p1 = ws[0][0], p2 = ws[1][0], d = len3(p1 - p2))[
        for (j = [0: len(wp[1]) - 1])[lerp(p1, p2, wp[1][j][0])[0], lerp(p1, p2, wp[1][j][0])[1], -wp[0][j][2] * d*4]]
    ],
[
      let (ws = wings[2], wp = wings[1], p1 = ws[0][1], p2 = ws[1][1], d = len3(p1 - p2))[
        for (j = [0: len(wp[1]) - 1])[lerp(p1, p2, wp[1][j][0])[0], lerp(p1, p2, wp[1][j][0])[1], -wp[0][j][2] * d*4]]
    ],

    //mid
    [
      for (i = [2: len(wings[2][0]) - 2]) let (ws = wings[2], wp = wings[1], p1 = ws[0][i], p2 = ws[1][i], d = len3(p1 - p2))[
        for (j = [0: len(wp[1]) - 1])[lerp(p1, p2, wp[1][j][0])[0], lerp(p1, p2, wp[1][j][0])[1] + wp[1][j][1] * d, lerp(p1, p2, wp[1][j][0])[2] + wp[1][j][2] * d]]
    ], [
      let (i = len(wings[2][0]) - 1, ws = wings[2], wp = wings[1], p1 = ws[0][i], p2 = ws[1][i], d = len3(p1 - p2))[
        for (j = [0: len(wings[1][1]) - 1])[lerp(p1, p2, wp[0][j][0])[0], lerp(p1, p2, wp[0][j][0])[1] + wp[0][j][1] * d, lerp(p1, p2, wp[0][j][0])[2]]]
    ]);
  ////////////////////////////////module wing(wings) ///////////////////////////////////
  ///////////////////////////////////////////////////////////////////
  rotate(wings[0][1]) scale(wings[0][0]) {union(){
    for (i = [0: len(overskin) - 2]) {
      wingringbridge(overskin[i], overskin[i + 1]);
   color("Red")   wingringbridge(underskin[i + 1],underskin[i]);
    }

    polyhedron(overskin[0], [
      [
        for (i = [0: len(overskin[0]) - 1]) i
      ]
    ]);
    polyhedron(underskin[0], [
      [
        for (i = [0: len(underskin[0]) - 1]) (len(underskin[0]) - 1)-i
      ]
    ]);}
  }
  module wingringbridge(r1, r2) {
    n = len(r1);
    
  for (i = [0: 1])
{ 
polyhedron([r1[i],r2[i],r2[i+1],r1[i+1] ],[[0,1,3],[1,2,3]]);
}
 for (i = [2: n - 2])
{ 
polyhedron([r1[i],r2[i],r2[i+1],r1[i+1] ],[[0,1,2],[0,2,3]]);
}
  };

  /////////////end of/module wing(wings)///////////////////////////////////
}


//////////////////////// Specilaty Wing Functions  /////////////////
/*definedefaultwing1*/function wing1()=[[[1.15,0.95,0.95],[39.6,10.249,-0.3]],[[[0,0,0],[0.1,0.15,0.1],[0.349,0.35,0.1],[0.65,0.3,0.1],[1,0.1,0]],[[0,0,0],[0.1,0.15,-0.032],[0.349,0.35,0.032],[0.65,0.3,0.03264],[1,0.1,0]]],[[[0,-0.2,0],[0,0.7,0],[-0.059375,1.5875,0],[-0.2125,2.50619,0],[-0.412438,3.44975,0],[-0.49975,4.40587,0.003125],[-0.384,5.38413,0.015625],[-0.1185,6.38744,0.034375],[0.2,7.4,0.05]],[[0.45,-0.2,0],[0.55,0.7,0],[1.69687,0.98125,0],[2.62188,1.55625,0],[3.16875,2.41875,0],[3.35625,3.43125,0],[3.22187,4.5875,0],[2.3375,5.93125,0],[0.5,7.4,0]]]];/*//definedefaultwing2*/function wing2()=[[[1,1,1],[0,0,0]],[[[0,0,0],[0.1,0.15,0.1],[0.349,0.35,0.1],[0.65,0.3,0.05],[1,0.1,0]],[[0,0,0],[0.05,0.15,-0.02],[0.2049,0.35,0.05],[0.65,0.3,0.05],[1,0.05,0]]],[[[0,-0.089,0],[0,0.54,0],[-0.179,1.619,0],[-0.359,2.609,0],[-0.54,3.419,0],[-0.54,4.32,0],[-0.449,5.219,0],[-0.27,6.209,0],[0,7.199,0]],[[0.359,-0.089,0],[0.359,0.54,0],[0.719,1.709,0],[1.289,2.879,0],[1.349,3.509,0],[1.439,4.229,0],[1.349,5.219,0],[1.169,6.209,0],[0.809,7.199,0]]]];/*/blurlengthprofile*/function blur(inwing,c=1)=c<=0?inwing:let(wing=blur(inwing,c-1))[wing[0],wing[1],[concat([wing[2][0][0]],[wing[2][0][1]],[for(i=[2:len(wing[2][0])-2])(wing[2][0][max(i-1,0)]*0.5+wing[2][0][i]+wing[2][0][min(i+1,len(wing[2][0])-1)]*0.5)/2],[wing[2][0][len(wing[2][0])-1]]),concat([wing[2][1][0]],[wing[2][1][1]],[for(i=[2:len(wing[2][1])-2])(wing[2][1][max(i-1,0)]*0.5+wing[2][1][i]+wing[2][1][min(i+1,len(wing[2][1])-1)]*0.5)/2],[wing[2][1][len(wing[2][1])-1]])]];/*/randsvector*0.1inZ*/function w3rnd(c)=[rands(-1,1,1)[0]*c,rands(-1,1,1)[0]*c*0.1,rands(-1,1,1)[0]]*c;/*/checkcross-profilesounderskinislowerthaoverskin*/function sanitycheck(v)=[v[0],[v[1][0],[let(l=len(v[1][1])-1)for(i=[0:l])[i==0||i==l?v[1][0][i][0]:v[1][1][i][0],i==0||i==l?v[1][0][i][1]:v[1][1][i][1],i==0||i==l?v[1][0][i][2]:min(v[1][1][i][2],v[1][0][i][2])*0.8]]],v[2]];/*roundeveryiteminanestedlisttoselectedprecition*/function roundlist(v,r=1)=len(v)==undef?v-(v%r):len(v)==0?[]:[for(i=[0:len(v)-1])roundlist(v[i],r)];/*multiplyeveryiteminanestedlistbyselecteddeviance*/function deepmutate(v,r=0.01)=len(v)==undef?v*rnd(1-r,1+r):len(v)==0?[]:[for(i=[0:len(v)-1])roundlist(v[i],r)];

///////////////// Common functions //////////////////////////////
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function len3(v) = len(v) == 2 ? sqrt(pow(v[0], 2) + pow(v[1], 2)) : sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];
function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);