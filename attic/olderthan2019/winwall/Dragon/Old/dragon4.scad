////////////////////
//Dragon Pose generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]
//RandomSeed

seed=1789;//[1111:9999]
part=0;//[1,2,3,4,5,6,7,8,9,10]
Base=[0,0,0];

BackFootBase=Base+[-6,rnd(2),0];
FrontFootBase=BackFootBase+[10+rnd(2),0,3+rnd(2.9)];

CPelvis=BackFootBase+lim3(15,[-4,0,6+rnd(2)]);
CThorax=CPelvis+lim3(14,[15+rnd(5),FrontFootBase[1]+rnd(4),FrontFootBase[2]/2+18+rnd(5)]);

bll=flip3((CThorax-CPelvis)/len3(CThorax-CPelvis));
bellyik=-IK(15,CThorax-CPelvis);
Belly=CPelvis+lim3(5,CThorax-CPelvis)/2+[ bellyik*bll [0],bellyik*bll[1],bellyik*bll[2]];


head=CThorax+ lim31(15,[10+rnd(10),rnd(5),10+rnd(10)]);
Tail=CPelvis+ lim31(30,[-15+rnd(10),rnd(5),10+rnd(8)]+[-abs(FrontFootBase[2])*3,0,0]);
Tailtip=Tail+ lim31(30,[rnd(15),rnd(15),5+rnd(15)]+[-abs(FrontFootBase[2])*1,0,0]);
Thorax=bez2(0.30,[CPelvis+lim31(2,Tail-CPelvis),CPelvis,Belly,CThorax,head])+[0,0,-4];
Pelvis=bez2(0.4,[CThorax,Belly,CPelvis,Tail]);


WingBase=Thorax+[-18+rnd(10),0,15+rnd(10)];
nose=head+ lim31(10,[5,rnd(5),-5+rnd(5)]);
jaw=head+((nose-head)*0.7+[-1,0,-2]);



RightHip=Pelvis+[4,-6,2];
LeftHip=Pelvis+[4,6,2];
RightSholder=Thorax+[-1,-5,3+rnd(1)];
LeftSholder=Thorax+[-1,5,3+rnd(1)];
RightWingSholder=Thorax+[-4,-3,10.5];
LeftWingSholder=Thorax+[-4,3,10.5];

paw=rnd(1);
rightpaw=paw-abs(paw);
leftpaw=-paw-abs(paw);

BackRightFoot=RightHip+lim3(25,BackFootBase+[-4+rnd(1)+abs(FrontFootBase[2]),-6+rnd(2),3]-RightHip);
BackLeftFoot=LeftHip+lim3(25,BackFootBase+[+rnd(1),6+rnd(2),3]-LeftHip);

FrontRightFoot=RightSholder+lim32(10,FrontFootBase+[rnd(3),-9+rnd(4)-rightpaw,min(-rightpaw*3+1,Thorax[2])]-RightSholder);

FrontLeftFoot=LeftSholder+lim32(10,FrontFootBase+[rnd(3),9+rnd(4)+leftpaw,min(-leftpaw*3+1,Thorax[2])]-LeftSholder);

FrontRightWing=RightWingSholder+lim3(30,WingBase+[+rnd(3),-18,0]-RightWingSholder);
FrontLeftWing=LeftWingSholder+lim3(30,WingBase+[+rnd(3),18,0]-LeftWingSholder);
function rnd(r)=rands(-r,r,10)[part];
function IK (l,v)=sqrt(pow(l/2,2)-pow(min(len3(v),l)/2,2));
function len3(v)=sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));
function flip3(v)=[-v[2],-v[1],v[0]];
function lim3(l,v)=v/len3(v)*max(min(len3(v),l),5);
function q(v,i)=[v[0],v[1],v[2],i];

function lim31(l,v)=v/len3(v)*l;
//FrontRightleg
frk=flip3((FrontRightFoot-RightSholder)/len3(FrontRightFoot-RightSholder));
frkik=-IK(12,FrontRightFoot-RightSholder);
FrontRightknee=RightSholder+lim3(5,FrontRightFoot-RightSholder)/2+[ frkik*frk [0],frkik*frk[1],frkik*frk[2]];

//FrontLeftleg
flk=flip3((FrontLeftFoot-LeftSholder)/len3(FrontLeftFoot-LeftSholder));
flkik=-IK(12,FrontLeftFoot-LeftSholder);
FrontLeftknee=LeftSholder+lim3(5,FrontLeftFoot-LeftSholder)/2+[flkik*flk [0],flkik*flk[1],flkik*flk[2]];

//BackRightleg
brk=flip3((BackRightFoot-RightHip)/len3(BackRightFoot-RightHip));
brkik=-IK(14,BackRightFoot-RightHip);
BackRightknee=RightHip+lim3(7,BackRightFoot-RightHip)/2+[ brkik*brk [0],brkik*brk[1],brkik*brk[2]];

//BackLeftleg
blk=flip3((BackLeftFoot-LeftHip)/len3(BackLeftFoot-LeftHip));
blkik=-IK(14,BackLeftFoot-LeftHip);
BackLeftknee=LeftHip+lim3(7,BackLeftFoot-LeftHip)/2+[ blkik*blk [0],blkik*blk[1],blkik*blk[2]];


//FrontRightWing
frj=flip3((FrontRightWing-RightWingSholder)/len3(FrontRightWing-RightWingSholder));

frjik= 
IK(40,FrontRightWing-RightWingSholder);
FrontRightjoint=RightWingSholder+lim3(40,FrontRightWing-RightWingSholder)/2+
[ -frjik*frj[0],-frjik*frj[1]*0.5,-frjik*frj[2]];
//FrontLeftWing
flj=flip3((FrontLeftWing-LeftWingSholder)/len3(FrontLeftWing-LeftWingSholder));

fljik=
IK(40,FrontLeftWing-LeftWingSholder);
FrontLeftjoint=LeftWingSholder+lim3(40,FrontLeftWing-LeftWingSholder)/2+
[ -fljik*flj[0],-fljik*flj[1]*0.5,-fljik*flj[2]];
//////
bodyvector=[q(Tailtip,0.01),q(Tailtip,0.01),q(Tail,1),q(Tail,1),q(Tail,1),q(Pelvis,0),q(Pelvis,0),q(Belly,15),q(Thorax,6),q(Thorax,0),q(head,0.5),q(head,1),q(head,2),q(nose,0.5)];

fn = 10; //[8:30]
rad=8;//[1:0.5:12]
tang=1;//[1:10]


///////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////


module yourmodule(i,v){
    //anything in this module will be copeid and rotatdet along curve (v) at (detail) intevall
    if ((floor(i*10)%10)>1){translate([0,0, bez2(i, v)[3]])scale([0.3,0.1,0.5])sphere(bez2(i, v)[3]); ;}
    
    
    for (j=[rands(0,bez2(i, v)[3]*2,1)[0]:360/rad/bez2(i, v)[3]:360]){
    rotate([j,0,0])translate([0,0, bez2(i, v)[3]])
        
        // anything here//////////////
        rotate([0,20,0])scale(0.5)scale([2,1,0.5])rotate([0,90, rands(0,90,1)[0]])sphere( [bez2(i, v)[3]/2*tang,bez2(i, v)[3]/2,bez2(i, v)[3]/2], $fn= 8,center=true);
    //////////////////
        }
    } 



  module headcase(){
//head trunk      
headv1=[[0,0,0,5],[3,0,1,5],[6,0,0.2,3.6],[9,0,-0.50,3.3],[12,0,-1,3.1],[13,0,-2.7,2.7],[14.9,0,-4.5,0.8],[14.9,0,-4.5,1.2],[14.9,0,-4.5,1.2]];
//upper tooth
      headv12=[[9,0,-1.3,2],[13.8,0,-4.0,1.1]];

//nose ridge
headv2=[[0,0,0,5],[-0.5,0,2,4.5],[4.1,0,2,5.3],[4.1,0,2,5.3],[8,0,2,0],[8,0,2,0],[11,0,1.1,2],[12.5,0,0,2],[13.5,0,-1.5,2],[14.5,0,-3.5,1.5]];
//eye ridge-nostrils
headv3=[[0,0,0,5],[0,0,0,5],[-1.7,2.2,4.2,2],[1.5,3.3,3.7,2],[4.9,3.7,4.3,1],[7.3,2.9,6.8,1],[4,-0.5,1.1,0],[10.5,2.4,-4,1],[12.5,3.7,5,1],[14.5,1.0,-2.5,0.2]];
      
headv4=[[0,0,0,5],[0,0,0,5],[-1.7,-2.2,4.2,2],[1.5,-3.3,3.7,2],[4.9,-3.7,4.3,1],[7.3,-2.9,6.8,1],[4,0.5,1.1,0],[10.5,-2.4,-4,1],[12.5,-3.7,5,1],[14.5,-1.0,-2.5,0.2]];
//Jaw
headv5=[[0,0,0,5],[0,2.0,0.5,4],[3,2.5,-0.2,3.5],[9,1,0.8,2.6],[9,1,0.8,2.6],[3,0,-6.55,2.2],[8,2,-3.5,1.6],[10,2,-4.6,1.4],[11.9,1,-5.5,1.0],[11.9,-0,-5.5,1.0]];
      
headv6=[[0,0,0,5],[0,-2.0,0.5,4],[3,-2.5,-0.2,3.5],[9,-1,0.8,2.6],[9,-1,0.8,2.6],[3,-0,-6.55,2.2],[8,-2,-3.5,1.6],[10,-2,-4.6,1.4],[11.9,-1,-5.5,1.0],[11.9,-0,-5.5,1.0]];
headv7=[[0,0,0,5],[0,0.0,0.5,4],[3,0,-0.2,3.5],[6,-0,0.2,2.6],[4,-0,-6.55,2.2],[8,-0,-3.5,1.6],[10,-0,-4.6,1.4],[11.9,-0,-5.5,1.0],[11.9,-0,-5.5,1.0]];
      
      bline(headv1,20);
      bline(headv12,20){
union(){   translate([0,0.6,-0.1])rotate([-40,180,15])cylinder(d=1,d2=0,h=1.3);
           translate([0,-0.6,-0.1])rotate([40,180,15])cylinder(d=1,d2=0,h=1.3);}
          };
      bline(headv2,20){union(){
          rotate([0,30,0])cylinder(d=1,d2=0,h=1.8);
          }};
      bline(headv3,20){translate([0,0,0.3])rotate([-65,60,0])cylinder(d=1,d2=0,h=1.5);};
      bline(headv4,20){translate([0,0,0.3])rotate([65,60,0])cylinder(d=1,d2=0,h=1.5);};
      bline(headv5,20){translate([0,0.1,0.3])rotate([-75,60,0])cylinder(d=1,d2=0,h=1.1);};
      bline(headv6,20){translate([0,-0.1,0.3])rotate([75,60,0])cylinder(d=1,d2=0,h=1.1);};
      bline(headv7,20)rotate([0,150,0])cylinder(d=1,d2=0,h=2);
      
      }
  
  



union(){rotate([0,0,180]){


// legs

//draw(FrontRightknee,FrontRightFoot,1);
//draw(RightSholder,FrontRightknee,2);
//draw(Thorax,RightSholder,2);
FrontRightLeg=[q(Thorax,2),q(RightSholder,2),q(RightSholder,2),q(FrontRightknee,3),q(FrontRightknee,0),q(FrontRightknee,1),q(FrontRightknee,2),q(FrontRightFoot,0),q(FrontRightFoot,1)];
    bline(FrontRightLeg,20);
    
//draw(FrontLeftknee,FrontLeftFoot,1);
//draw(LeftSholder,FrontLeftknee,2);
//draw(Thorax,LeftSholder,2);
FrontLeftLeg=[q(Thorax,2),q(LeftSholder,2),q(LeftSholder,2),q(FrontLeftknee,3),q(FrontLeftknee,0),q(FrontLeftknee,1),q(FrontLeftknee,2),q(FrontLeftFoot,0),q(FrontLeftFoot,1)];
    bline(FrontLeftLeg,20);

//draw(BackRightknee,BackRightFoot,1);
//draw(RightHip,BackRightknee,2);
//draw(Pelvis,RightHip,2);
//draw(BackLeftknee,BackLeftFoot,1);
//draw(LeftHip,BackLeftknee,2);
//draw(Pelvis,LeftHip,2);
BackRightLeg=[q(Pelvis,2),q(RightHip,1),q(RightHip,3),q(RightHip,1),q(BackRightknee,5),q(BackRightknee,0),q(BackRightknee,1),q(BackRightFoot,0),q(BackRightFoot,1)];
    bline(BackRightLeg,20);
BackLeftLeg=[q(Pelvis,3),q(LeftHip,1),q(LeftHip,3),q(LeftHip,1),q(BackLeftknee,5),q(BackLeftknee,0),q(BackLeftknee,1),q(BackLeftFoot,0),q(BackLeftFoot,1)];
    bline(BackLeftLeg,20);
// wings
*hull(){
color("green")draw(FrontRightjoint,FrontRightWing,0.5);
color("green")draw(FrontRightjoint,FrontRightjoint+[-15,0,0],0.5);    
color("green")draw(RightWingSholder,FrontRightjoint,0.5);
    
}
*draw(RightWingSholder,Thorax,1);

*color("darkgreen")hull(){
color("green")draw(FrontLeftjoint,FrontLeftWing,0.5);
    color("green")draw(FrontLeftjoint,FrontLeftjoint+[-15,0,0],0.5);
*       draw(LeftWingSholder,FrontLeftjoint,0.5);


}
//draw(LeftWingSholder,Thorax,1);
//Neck Torso Tail


//draw(head,nose,3);
//draw(head,jaw,2);
;

bline(bodyvector,30);{
    headcase();
    }




 translate( [1,0,-1])translate(BackRightFoot) scale([0.5,0.5,0.5]) translate([-2,0,-0.5]) rotate([0,20,leftpaw*30])foot()  ;
 translate( [1,0,-1])  translate(BackLeftFoot) scale([0.5,0.5,0.5]) translate([-2,0,-0.5])rotate([0,20,-rightpaw*30]) foot()  ;
 translate( [2,0,-1]) translate(FrontRightFoot)   translate([-1.5,0,0])rotate([rands(-rightpaw*30,rightpaw*30,1)[0],rands(-rightpaw*50,rightpaw*50,1)[0],-30]) scale([0.5,0.5,0.5])foot()  ;
   translate( [2,0,-1])translate(FrontLeftFoot)   translate([-1.5,0,0])rotate([0,leftpaw*30,30])scale([0.5,0.5,0.5])foot() ;
  
  *color([1-2/FrontRightFoot[2],0,0])  translate([FrontRightFoot[0],FrontRightFoot[1],0.011]) scale([1,0.5,1]) cylinder(r=3+FrontRightFoot[2]*0.2);

 *color([1-2/FrontLeftFoot[2],0,0])  translate([FrontLeftFoot[0],FrontLeftFoot[1],0.011]) scale([1,0.5,1]) cylinder(r=3+FrontLeftFoot[2]*0.2);
  
  * color([max(1-4/Thorax[2],0.5),0,0])  translate([Thorax[0],Thorax[1],0.01-0.01*(1-1/Thorax[2])])scale([1,0.7,1])cylinder(r=3+Thorax[2]*0.5);

 * color([max(1-4/Pelvis[2],0.5),0,0])  translate([Pelvis[0],Pelvis[1],0.01-0.01*(1-1/Pelvis[2])])scale([1,0.7,1])cylinder(r=3+Pelvis[2]*0.5);

   * color("Red")  translate(Base)cylinder(r=25);
}}
module draw(s,f,h)
{
hull(){
   translate(s)  sphere(h);
 
 translate(f)  sphere(h/2);} 
  for(i=[0:0.2:1]){
    
  
 //  translate(s*i+f*(1-i))  sphere(h*(0.3+i*0.7),$fn=20);
  
  
 }  
    }
    
    
    module bez(t,v){
    unt=1-t;
    if (len(v)>2){
        ;
   v2 = [ for (i = [0 : 1 : len(v)-2])v[i]*t+v[i+1]*unt ];
    bez(t,v2);
    
    
    }else{
        //echo (v[0]);
        p=v[0]*t+v[1]*unt;
       translate([p[0],p[1],p[2],]) sphere(r=p[3],$fn=10);}
    }


// Bline module
module bline(v,d) {
    detail=1/floor(d);
  // head pos 
 translate(t(bez2(1 , v))) rotate( t(bez2euler(1, v)))rotate([0,0,180])scale(bez2(1  , v)[3] )children(1);
   // head pos 
 translate(t(bez2(0 , v))) rotate( t(bez2euler(0, v)))rotate([0,0,0])scale(bez2(1  , v)[3] )children(2);
    translate(t(bez2(0 , v)))rotate(bez2euler (0,v))  scale(bez2(0  , v)[3] )  children(0);
     
    for(i = [detail: detail: 1]) {
      
translate(t(bez2(i  , v)))rotate(bez2euler (i,v))  scale(bez2(i  , v)[3] ) children(0);
        
      hull() {
        translate([bez2(i, v)[0], bez2(i, v)[1], bez2(i, v)[2]]) rotate(bez2euler(i, v)) rotate([0, 90, 0]) {
          sphere(r = bez2(i, v)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v)) rotate([0, 90, 0]) sphere(r = bez2(i - detail, v)[3], $fn = fn);
      }
    }
  }
  //The recusive
function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);

//
function lim32(l, v) = v / len3(v) * max(l,1);

//function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
// unit normal to euler angles
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];

module foot(){
   {
    v=[[-3,0,2,1],[0,0,-1,1],[0,0,3,4],[0,0,3,4],[4,0,0,2],[8,0,-4,1],[8,0,10,0],[12,0,7,1],[15,0,-3,0],[15,0,-3,0]];
v2=[[-3,0,0,0],[2,5,3,5],[0,0,1,1],[10,5,-5,1],[6,5,8,1],[9,6,5,1],[11,6,-2,0],[11,6,-2,0]];
v3=[[-3,0,0,0],[2,-5,3,5],[0,0,1,1],[10,-5,-5,1],[6,-5,8,1],[9,-6,5,1],[11,-6,-2,0],[11,-6,-2,0]];

bline(v,15);
bline(v2,15);
bline(v3,15);}
    }

/*module bline(v){
    union(){for (i=[0.05:0.05:1])
    {
        hull(){
            bez(i,v);
            bez(i-0.05,v);
        }
        
        }  }  
    
    
    }
    
    function bez2(t,v)=(len(v)>2)?bez2(t,[ for (i = [0 : len(v)-2])v[i]*t+v[i+1]*(1-t) ]):v[0]*t+v[1]*(1-t);


    /*You can post it in 3D coordinates. You must think of a sphere, rather than just a circle.
Let r = radius, t = angle on x-y plane, & p = angle off of z-axis. Then you get:

x = r * sin(p) * cos(t)
y = r * sin(p) * sin(t)
z = r * cos(p)

If you already have x,y,z and want to switch it back, this is the conversion:

r = sqrt(x*x + y*y + z*z)
t = arctan(y/x)
p = arccos(z/r)
*For computing p, it's easier to compute r first, then use it as the denominator (assuming ![x = y = z = 0]).*/
    