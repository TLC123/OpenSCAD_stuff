unionRoundSimple.scad

[issue 844](https://github.com/openscad/openscad/issues/884#issuecomment-898877935)

unionRound Module by Torleif Ceder - TLC123 late summer 2021
 Pretty fast Union with radius, But limited to subset of cases
 
 Usage 
 unionRound( radius , detail , epsilon= 0.00001)
  { 
   YourObject1();  
   YourObject2(); 
  } 

limitations:

 0. Only really fast when boolean operands are convex, Minkowski is fast in that case. 
 1. Boolean operands may be concave but can only touch in a single convex area
 2. Radius is of eliptic type and is only aproximate r were operand intersect at perpendicular angle. 
 
[on Youtube](www.youtube.com/watch?v=gVk-Keg_nGQ)

[on GitHub](github.com/TLC123/OpenSCAD_stuff/blob/d6fa00e498313d98a9ea31902600cc8a0af1b9bc/2021/unionRoundSimple.scad)

[on Thingiverse](www.thingiverse.com/thing:4932117/)

[on OpenSCAD Snippet Pad](openscadsnippetpad.blogspot.com/2021/08/openscad-unionround-module.html)

[on r /OpenSCAD](www.reddit.com/r/openscad/comments/p43xqc/unionround_module/)



![unionRound](https://github.com/TLC123/OpenSCAD_stuff/blob/16fd2e915b4b920f4786c256a8ced0462d6f85c5/2021/unionRound/reddit.PNG)

functional_extrude.scad
![functional_extrude](https://user-images.githubusercontent.com/10944617/128231672-ca067748-d0bb-450f-8080-ffd1a68b3b8c.png)

polyround3d.scad 

![image](https://user-images.githubusercontent.com/10944617/127744443-d1815886-49d3-456b-8c8a-7db638b20010.png)! 
