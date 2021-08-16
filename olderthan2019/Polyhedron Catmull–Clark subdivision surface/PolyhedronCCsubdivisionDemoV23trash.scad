//Select="bunny";//[tet,ico,bunny]
//Sub1=0;//[0,1]
//CurvatureBias=-0.5;//[-1:0.1:2]
//Sub2=0;//[0,1,2,3,4]
//Sub3=2;//[0,1,2,3,4,5]
///* [Hidden] */
/////////////////////////////////////////////////////////////////////////////////
////CC subdivision-ish in that regard this impl don't split edges
//// subdivides any properly watertight manifold polyhedron : point-list and face-list
//// [  [[10,10,10],[10,-10,-10],[-10,10,-10],[-10,-10,10]],    [[2,1,0],[3,2,0],[1,3,0],[2,3,1]]]
//// usage cc([points,faces],iterations(0=off),curvebias)
/////////////////////////////////////////////////////////////////////////////////
//// Demo Code
//S=Select=="ico"?ico():Select=="tet"?tet():bunny();
//in=cc(cc(S,Sub1),Sub2,CurvatureBias); //one regular and the two passes with negative bias for pointyness
include <D:\g\OpenSCAD\attic\GrandCastle\ico7.scad>;
 t=ti(); // more passes
//rotate([0,0,180])trender(cc(tet(),2,-0.5));
//trender(cc(bunny(),2,-0.5));
//trender(t);  // pretty render
  polyhedron(t[0],t[1]); // fast
// End Of Demo Code
echo(t);

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
module trender(t){C0=(un(rndc())+[2,0,0]);C1=(un(rndc())+[2,2,0]);C2=(un(rndc())+[0,2,2]);for(i=[0:max(0,len(t[1])-1)]){ n=un(p2n(t[0][t[1][i][0]],t[0][t[1][i][1]],t[0][t[1][i][2]]));color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4))polyhedron(t[0],[t[1][i]]);}}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
function cc(V,n=1,curve=0.61803398875)=n<=0?V:n==1?let(w=V)let(ed=cccheck(ccQS (ccQS (ccQS (ccQS (ccde(w[1],len(w[0])-1),2),1),0),1)))let(nf=ccnf(ed))ccflip([ccnv(w,nf,curve),nf]):let(w=cc(V,n-1,curve))let(ed=cccheck(ccQS (ccQS (ccQS (ccQS (ccde(w[1],len(w[0])-1),2),1),0),1)))let(nf=ccnf(ed))ccflip([ccnv(w,nf,curve),nf]);
function ccnv(v,nf,curve)=let(nv=[for(i=[0:len(v[1])-1])(v[0][v[1][i][0]]+v[0][v[1][i][1]]+v[0][v[1][i][2]])/3])let(sfv=[for(i=[0:len(v[0])-1])avrg(ccfind(i,v[1],nv))])concat(lerp(v[0],sfv,curve),nv);
function ccnf(hf)=[for(i=[0:1:len(hf)-1])(i%2)==0?[hf[i][4],hf[(i+1)%len(hf)][2],hf[i][2]]:[hf[i][4],hf[(i-1)%len(hf)][2],hf[i][2]]];
function ccde(faces,points)=let(l=len(faces)-1) [for(i=[0:l])  let(f=faces[i])   for(j=[0:len(f)-1])     let(p=f[j],q=f[(j+1)%len(f)])       [min(p,q),max(p,q),i+points+1,p,q] //noduplicates 
];
function cccheck(ed)=concat([for(i=[0:len(ed)-1])if((ed[i][0]==ed[i-1][0]&&ed[i][1]==ed[i-1][1])||(ed[i][0]==ed[i+1][0]&&ed[i][1]==ed[i+1][1]))ed[i]]);
function ccfind(lookfor,faces,nv)=   [for(i=[0:len(faces)-1])if(faces[i][0]==lookfor||faces[i][1]==lookfor||faces[i][2]==lookfor)nv[i]];
function ccQS (arr,o)=!(len(arr)>0)?[]:let(  pivot =arr[floor(len(arr)/2)],  lesser =[for(y=arr)if(y[o] <pivot[o])y],  equal =[for(y=arr)if(y[o]==pivot[o])y],  greater=[for(y=arr)if(y[o] >pivot[o])y])concat(  ccQS (lesser,o),equal,ccQS (greater,o));
function wave(w,a=1,b=1)=[[for(i=[0:len(w[0])-1])let(x=w[0][i][0],y=w[0][i][1],z=w[0][i][2])w[0][i]+[sin((y+z)*b)*a,sin((z+x)*b)*a,sin((x+y)*b)*a]],w[1]];
function ccweld(v)=let(data=v[0])[v[0],[for(i=[0:len(v[1])-1])let(index1=v[1][i][0],index2=v[1][i][1],index3=v[1][i][2])concat(search(data[index1][0],data),search(data[index2][0],data),search(data[index3][0],data,1))]];
function ccflip(w)=[w[0],[for(i=[0:len(w[1])-1])[w[1][i][0],w[1][i][2],w[1][i][1]]]];
///////////////////////////commonfunction s/////////////////////////////
function un(v)=v/max(norm(v),0.000001)*1;
function p2n(pa,pb,pc)=
let(u=pa-pb,v=pa-pc)un([u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]);
function avrg(v)=sumv(v,max(0,len(v)-1))/len(v);
function lerp(start,end,bias)=(end*bias+start*(1-bias));
function len3(v)=len(v)==2?sqrt(pow(v[0],2)+pow(v[1],2)):sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));
function sumv(v,i,s=0)=(i==s?v[i]:v[i]+sumv(v,i-1,s));
function rnd(a=0,b=1)=(rands(min(a,b),max(a,b),1)[0]);
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];
function v3rnd(c=1)=[rands(-1,1,1)[0]*c,rands(-1,1,1)[0]*c,rands(-1,1,1)[0]]*c;
function roundlist(v,r=1)=len(v)==undef?v-(v%r):len(v)==0?[]:[for(i=[0:len(v)-1])roundlist(v[i],r)];
function limlist(v,r=1)= [for(i=[0:len(v)-1])[v[i][0],v[i][1],v[i][2]]];

//////////////////////Make geometry function///////////////////
function ico(a=10)=
let(r=a*1.61803)[[[0,-r,a],[0,r,a],[0,r,-a],[0,-r,-a],[a,0,r],[-a,0,r],[-a,0,-r],[a,0,-r],[r,a,0],[-r,a,0],[-r,-a,0],[r,-a,0]],[[0,5,4],[0,4,11],[11,4,8],[11,8,7],[4,5,1],[4,1,8],[8,1,2],[8,2,7],[1,5,9],[1,9,2],[2,9,6],[2,6,7],[9,5,10],[9,10,6],[6,10,3],[6,3,7],[10,5,0],[10,0,3],[3,0,11],[3,11,7]]];
function tet()=  [[[0, 1.11022e-016, 0], [0, 1.91342, -16.6298], [0, 4.6194, -6.8883], [0, 4.6194, 6.8883], [0, 1.91342, 16.6298], [0, -1.91342, 16.6298], [0, -4.6194, 6.8883], [0, -4.6194, -6.8883], [0, -1.91342, -16.6298], [-5.72538, 1.91342, -16.614], [-5.30046, 4.6194, -6.88175], [-4.69954, 4.6194, 6.88175], [-4.27462, 1.91342, 16.614], [-4.27462, -1.91342, 16.614], [-4.69954, -4.6194, 6.88175], [-5.30046, -4.6194, -6.88175], [-5.72538, -1.91342, -16.614], [-6.99239, 7.65367, -27.5421], [-6.99239, 18.4776, -11.3062], [-6.99239, 18.4776, 11.6548], [-6.99239, 7.65367, 27.8907], [-6.99239, -7.65367, 27.8907], [-6.99239, -18.4776, 11.6548], [-6.99239, -18.4776, -11.3062], [-6.99239, -7.65367, -27.5421], [-21.3173, 9.1844, -26.8242], [-24.5971, 22.1731, -12.0299], [-29.2355, 22.1731, 8.89234], [-32.5153, 9.1844, 23.6866], [-32.5153, -9.1844, 23.6866], [-29.2355, -22.1731, 8.89234], [-24.5971, -22.1731, -12.0299], [-21.3173, -9.1844, -26.8242], [-41.9108, 7.27099, -25.5468], [-44.1364, 17.5537, -15.5078], [-47.2839, 17.5537, -1.31057], [-49.5095, 7.27099, 8.72841], [-49.5095, -7.27099, 8.72841], [-47.2839, -17.5537, -1.31057], [-44.1364, -17.5537, -15.5078], [-41.9108, -7.27099, -25.5468], [-66.0638, 6.8883, -17.5309], [-65.812, 16.6298, -13.2086], [-65.456, 16.6298, -7.09603], [-65.2043, 6.8883, -2.77379], [-65.2043, -6.8883, -2.77379], [-65.456, -16.6298, -7.09603], [-65.812, -16.6298, -13.2086], [-66.0638, -6.8883, -17.5309], [-84.8107, 5.10245, -13.6599], [-83.3299, 12.3184, -9.59146], [-81.2357, 12.3184, -3.83778], [-79.7549, 5.10245, 0.23068], [-79.7549, -5.10245, 0.23068], [-81.2357, -12.3184, -3.83778], [-83.3299, -12.3184, -9.59146], [-84.8107, -5.10245, -13.6599], [-101.66, 3.31659, -4.57494], [-99.0744, 8.00696, -1.10209], [-95.4181, 8.00696, 3.80926], [-92.8326, 3.31659, 7.28211], [-92.8326, -3.31659, 7.28211], [-95.4181, -8.00696, 3.80926], [-99.0744, -8.00696, -1.10209], [-101.66, -3.31659, -4.57494], [-114.859, 1.53073, 8.54169], [-111.583, 3.69552, 11.3726], [-106.951, 3.69552, 15.3762], [-103.675, 1.53073, 18.2071], [-103.675, -1.53073, 18.2071], [-106.951, -3.69552, 15.3762], [-111.583, -3.69552, 11.3726], [-114.859, -1.53073, 8.54169], [-127.444, 1.53073, 25.4457], [-123.792, 3.69552, 27.7719], [-118.628, 3.69552, 31.0618], [-114.977, 1.53073, 33.3881], [-114.977, -1.53073, 33.3881], [-118.628, -3.69552, 31.0618], [-123.792, -3.69552, 27.7719], [-127.444, -1.53073, 25.4457], [-137.446, 1.53073, 43.9951], [-133.495, 3.69552, 45.7675], [-127.909, 3.69552, 48.2742], [-123.959, 1.53073, 50.0467], [-123.959, -1.53073, 50.0467], [-127.909, -3.69552, 48.2742], [-133.495, -3.69552, 45.7675], [-137.446, -1.53073, 43.9951], [-144.488, 1.53073, 63.2869], [-140.419, 3.69552, 64.7677], [-134.666, 3.69552, 66.8618], [-130.597, 1.53073, 68.3426], [-130.597, -1.53073, 68.3426], [-134.666, -3.69552, 66.8618], [-140.419, -3.69552, 64.7677], [-144.488, -1.53073, 63.2869], [-137.543, 1.38778e-016, 65.8147]], [[0, 1, 8], [1, 2, 9], [2, 3, 10], [3, 4, 11], [4, 5, 12], [5, 6, 13], [6, 7, 14], [7, 8, 15], [8, 9, 16], [9, 10, 17], [10, 11, 18], [11, 12, 19], [12, 13, 20], [13, 14, 21], [14, 15, 22], [15, 16, 23], [16, 17, 24], [17, 18, 25], [18, 19, 26], [19, 20, 27], [20, 21, 28], [21, 22, 29], [22, 23, 30], [23, 24, 31], [24, 25, 32], [25, 26, 33], [26, 27, 34], [27, 28, 35], [28, 29, 36], [29, 30, 37], [30, 31, 38], [31, 32, 39], [32, 33, 40], [33, 34, 41], [34, 35, 42], [35, 36, 43], [36, 37, 44], [37, 38, 45], [38, 39, 46], [39, 40, 47], [40, 41, 48], [41, 42, 49], [42, 43, 50], [43, 44, 51], [44, 45, 52], [45, 46, 53], [46, 47, 54], [47, 48, 55], [48, 49, 56], [49, 50, 57], [50, 51, 58], [51, 52, 59], [52, 53, 60], [53, 54, 61], [54, 55, 62], [55, 56, 63], [56, 57, 64], [57, 58, 65], [58, 59, 66], [59, 60, 67], [60, 61, 68], [61, 62, 69], [62, 63, 70], [63, 64, 71], [64, 65, 72], [65, 66, 73], [66, 67, 74], [67, 68, 75], [68, 69, 76], [69, 70, 77], [70, 71, 78], [71, 72, 79], [72, 73, 80], [73, 74, 81], [74, 75, 82], [75, 76, 83], [76, 77, 84], [77, 78, 85], [78, 79, 86], [79, 80, 87], [80, 81, 88], [81, 82, 89], [82, 83, 90], [83, 84, 91], [84, 85, 92], [85, 86, 93], [86, 87, 94], [87, 88, 95], [88, 89, 96], [89, 90, 97], [90, 91, 97], [91, 92, 97], [92, 93, 97], [93, 94, 97], [94, 95, 97], [95, 96, 97], [0, 2, 1], [0, 3, 2], [0, 4, 3], [0, 5, 4], [0, 6, 5], [0, 7, 6], [0, 8, 7], [1, 9, 8], [2, 10, 9], [3, 11, 10], [4, 12, 11], [5, 13, 12], [6, 14, 13], [7, 15, 14], [8, 16, 15], [9, 17, 16], [10, 18, 17], [11, 19, 18], [12, 20, 19], [13, 21, 20], [14, 22, 21], [15, 23, 22], [16, 24, 23], [17, 25, 24], [18, 26, 25], [19, 27, 26], [20, 28, 27], [21, 29, 28], [22, 30, 29], [23, 31, 30], [24, 32, 31], [25, 33, 32], [26, 34, 33], [27, 35, 34], [28, 36, 35], [29, 37, 36], [30, 38, 37], [31, 39, 38], [32, 40, 39], [33, 41, 40], [34, 42, 41], [35, 43, 42], [36, 44, 43], [37, 45, 44], [38, 46, 45], [39, 47, 46], [40, 48, 47], [41, 49, 48], [42, 50, 49], [43, 51, 50], [44, 52, 51], [45, 53, 52], [46, 54, 53], [47, 55, 54], [48, 56, 55], [49, 57, 56], [50, 58, 57], [51, 59, 58], [52, 60, 59], [53, 61, 60], [54, 62, 61], [55, 63, 62], [56, 64, 63], [57, 65, 64], [58, 66, 65], [59, 67, 66], [60, 68, 67], [61, 69, 68], [62, 70, 69], [63, 71, 70], [64, 72, 71], [65, 73, 72], [66, 74, 73], [67, 75, 74], [68, 76, 75], [69, 77, 76], [70, 78, 77], [71, 79, 78], [72, 80, 79], [73, 81, 80], [74, 82, 81], [75, 83, 82], [76, 84, 83], [77, 85, 84], [78, 86, 85], [79, 87, 86], [80, 88, 87], [81, 89, 88], [82, 90, 89], [83, 91, 90], [84, 92, 91], [85, 93, 92], [86, 94, 93], [87, 95, 94], [88, 96, 95], [89, 97, 96]]];
function bunny()=[[[0, -5.55112e-016, 0], [0, 5.74025, -16.6298], [0, 13.8582, -6.8883], [0, 13.8582, 6.8883], [0, 5.74025, 16.6298], [0, -5.74025, 16.6298], [0, -13.8582, 6.8883], [0, -13.8582, -6.8883], [0, -5.74025, -16.6298], [-4.59935, 5.74025, -16.2356], [-2.4909, 13.8582, -6.72502], [0.490901, 13.8582, 6.72502], [2.59935, 5.74025, 16.2356], [2.59935, -5.74025, 16.2356], [0.490901, -13.8582, 6.72502], [-2.4909, -13.8582, -6.72502], [-4.59935, -5.74025, -16.2356], [-14.3672, 6.8883, -11.837], [-11.8459, 16.6298, -2.42741], [-8.28025, 16.6298, 10.8798], [-5.75896, 6.8883, 20.2894], [-5.75896, -6.8883, 20.2894], [-8.28025, -16.6298, 10.8798], [-11.8459, -16.6298, -2.42741], [-14.3672, -6.8883, -11.837], [-26.389, 6.8883, -10.2662], [-22.6611, 16.6298, -1.26622], [-17.389, 16.6298, 11.4617], [-13.6611, 6.8883, 20.4617], [-13.6611, -6.8883, 20.4617], [-17.389, -16.6298, 11.4617], [-22.6611, -16.6298, -1.26622], [-26.389, -6.8883, -10.2662], [-39.7154, 5.74025, 3.31099], [-30.4247, 13.8582, 6.24033], [-17.2858, 13.8582, 10.383], [-7.99509, 5.74025, 13.3124], [-7.99509, -5.74025, 13.3124], [-17.2858, -13.8582, 10.383], [-30.4247, -13.8582, 6.24033], [-39.7154, -5.74025, 3.31099], [-38.6243, 5.74025, 17.4454], [-29.2147, 13.8582, 14.9241], [-15.9076, 13.8582, 11.3585], [-6.49797, 5.74025, 8.83719], [-6.49797, -5.74025, 8.83719], [-15.9076, -13.8582, 11.3585], [-29.2147, -13.8582, 14.9241], [-38.6243, -5.74025, 17.4454], [-32.1522, 3.82683, 23.0468], [-25.7758, 9.2388, 20.0734], [-16.7583, 9.2388, 15.8685], [-10.3819, 3.82683, 12.8951], [-10.3819, -3.82683, 12.8951], [-16.7583, -9.2388, 15.8685], [-25.7758, -9.2388, 20.0734], [-32.1522, -3.82683, 23.0468], [-28.2375, 3.82683, 28.9556], [-22.4744, 9.2388, 24.9202], [-14.324, 9.2388, 19.2132], [-8.5608, 3.82683, 15.1778], [-8.5608, -3.82683, 15.1778], [-14.324, -9.2388, 19.2132], [-22.4744, -9.2388, 24.9202], [-28.2375, -3.82683, 28.9556], [-18.3992, 2.22045e-016, 22.0667]], [[0, 1, 8], [1, 2, 9], [2, 3, 10], [3, 4, 11], [4, 5, 12], [5, 6, 13], [6, 7, 14], [7, 8, 15], [8, 9, 16], [9, 10, 17], [10, 11, 18], [11, 12, 19], [12, 13, 20], [13, 14, 21], [14, 15, 22], [15, 16, 23], [16, 17, 24], [17, 18, 25], [18, 19, 26], [19, 20, 27], [20, 21, 28], [21, 22, 29], [22, 23, 30], [23, 24, 31], [24, 25, 32], [25, 26, 33], [26, 27, 34], [27, 28, 35], [28, 29, 36], [29, 30, 37], [30, 31, 38], [31, 32, 39], [32, 33, 40], [33, 34, 41], [34, 35, 42], [35, 36, 43], [36, 37, 44], [37, 38, 45], [38, 39, 46], [39, 40, 47], [40, 41, 48], [41, 42, 49], [42, 43, 50], [43, 44, 51], [44, 45, 52], [45, 46, 53], [46, 47, 54], [47, 48, 55], [48, 49, 56], [49, 50, 57], [50, 51, 58], [51, 52, 59], [52, 53, 60], [53, 54, 61], [54, 55, 62], [55, 56, 63], [56, 57, 64], [57, 58, 65], [58, 59, 65], [59, 60, 65], [60, 61, 65], [61, 62, 65], [62, 63, 65], [63, 64, 65], [0, 2, 1], [0, 3, 2], [0, 4, 3], [0, 5, 4], [0, 6, 5], [0, 7, 6], [0, 8, 7], [1, 9, 8], [2, 10, 9], [3, 11, 10], [4, 12, 11], [5, 13, 12], [6, 14, 13], [7, 15, 14], [8, 16, 15], [9, 17, 16], [10, 18, 17], [11, 19, 18], [12, 20, 19], [13, 21, 20], [14, 22, 21], [15, 23, 22], [16, 24, 23], [17, 25, 24], [18, 26, 25], [19, 27, 26], [20, 28, 27], [21, 29, 28], [22, 30, 29], [23, 31, 30], [24, 32, 31], [25, 33, 32], [26, 34, 33], [27, 35, 34], [28, 36, 35], [29, 37, 36], [30, 38, 37], [31, 39, 38], [32, 40, 39], [33, 41, 40], [34, 42, 41], [35, 43, 42], [36, 44, 43], [37, 45, 44], [38, 46, 45], [39, 47, 46], [40, 48, 47], [41, 49, 48], [42, 50, 49], [43, 51, 50], [44, 52, 51], [45, 53, 52], [46, 54, 53], [47, 55, 54], [48, 56, 55], [49, 57, 56], [50, 58, 57], [51, 59, 58], [52, 60, 59], [53, 61, 60], [54, 62, 61], [55, 63, 62], [56, 64, 63], [57, 65, 64]]];