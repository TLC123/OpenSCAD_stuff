convexity=128;
Nombre_de_tours=3;
TOUR_Diametre_base=100;
TOUR_Hauteur_base=40;
TOUR_Hauteur_raccord=10;
TOUR_Diametre_apres_raccord=90;
TOUR_Nombre_de_briques_horizontalement=16;
TOUR_Nombre_de_briques_verticalement=10;
TOUR_Hauteur_des_briques=12;
TOUR_Taille_des_joints=2;
TOUR_Fenetres="oui";//[oui,non]
TOUR_Partie_haute_diametre=70;
TOUR_Partie_haute_nombre_de_briques_verticalement=8;
BALCON_Diametre=120;
BALCON_Nombre_de_briques_verticalement=4;
TOUR_TOIT_Hauteur_du_toit=100;
TOUR_TOIT_Diametre_du_toit=100;
MUR_Nombre_de_briques_verticalement=TOUR_Nombre_de_briques_verticalement;
MUR_Nombre_de_briques_horizontalement=10;
MUR_Largeur_des_briques=25;
MUR_Epaissseur_du_mur=20;
EPAIS_RACMUR=TOUR_Diametre_base-TOUR_Diametre_apres_raccord;
TOUR_HP2=TOUR_Hauteur_base+TOUR_Hauteur_raccord+(TOUR_Nombre_de_briques_verticalement*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)+TOUR_Hauteur_des_briques);
TOUR_TOIT=TOUR_Hauteur_base+TOUR_Hauteur_raccord+(TOUR_Nombre_de_briques_verticalement*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)+TOUR_Hauteur_des_briques)+(TOUR_Partie_haute_nombre_de_briques_verticalement*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints));
MUR_TAILLE=MUR_Nombre_de_briques_horizontalement*(MUR_Largeur_des_briques+TOUR_Taille_des_joints);
MaTourEtMonMur(it=1,mit=Nombre_de_tours);
module MaTourEtMonMur()
{
    tour();
    rotate([0,0,360/Nombre_de_tours])
    mur();
    
    if(it<=mit)
    {
        rotate([0,0,360/Nombre_de_tours])
        translate([0,MUR_TAILLE,0])
        MaTourEtMonMur(it=it+1,mit=mit);
    }
 
}
module mur()
{
    color([0.9,0.1,0.1,1])
    {
        translate([-MUR_Epaissseur_du_mur/2,0,TOUR_Hauteur_base+TOUR_Hauteur_raccord])        
        for(j=[0:MUR_Nombre_de_briques_verticalement-1])
        {
            translate([0,0,(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)*j])
            
            if((j/2)==floor(j/2))
            {
                translate([0,(MUR_Largeur_des_briques+TOUR_Taille_des_joints)/2,0])
                for(i=[0:MUR_Nombre_de_briques_horizontalement-1])
                {
                    translate([0,i*(MUR_Largeur_des_briques+TOUR_Taille_des_joints),0])
                    cube([MUR_Epaissseur_du_mur,MUR_Largeur_des_briques,TOUR_Hauteur_des_briques]);
                }
            }
            else
            {
                translate([0,(MUR_Largeur_des_briques+TOUR_Taille_des_joints),0])
                for(i=[0:MUR_Nombre_de_briques_horizontalement-1])
                {
                    translate([0,i*(MUR_Largeur_des_briques+TOUR_Taille_des_joints),0])
                    cube([MUR_Epaissseur_du_mur,MUR_Largeur_des_briques,TOUR_Hauteur_des_briques]);
                }
            }
            
            
            }
        
        
         hull()
        {
            rotate([0,0,90])
            translate([0,-(MUR_Epaissseur_du_mur+EPAIS_RACMUR)/2,0])        
            cube([MUR_TAILLE,(MUR_Epaissseur_du_mur+EPAIS_RACMUR),TOUR_Hauteur_base]);
            rotate([0,0,90])
            translate([0,-(MUR_Epaissseur_du_mur)/2,0])        
            cube([MUR_TAILLE,(MUR_Epaissseur_du_mur),TOUR_Hauteur_base+TOUR_Hauteur_raccord]);
        }
        rotate([0,0,90])        
        translate([0,-BALCON_Diametre/4,TOUR_HP2-TOUR_Hauteur_des_briques])
        cube([MUR_TAILLE,BALCON_Diametre/2,TOUR_Hauteur_des_briques]);
        difference()
        {
            
            HautRouge();
            translate([0,0,TOUR_HP2])
            cylinder(d=BALCON_Diametre,h=BALCON_Nombre_de_briques_verticalement*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints));        
            
            rotate([0,0,90])
            translate([MUR_TAILLE,0,TOUR_HP2])
            cylinder(d=BALCON_Diametre,h=BALCON_Nombre_de_briques_verticalement*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints));        
            rotate([0,0,90])        
            translate([0,-(BALCON_Diametre/2-(TOUR_Taille_des_joints*2)-TOUR_Taille_des_joints)/2,TOUR_HP2-TOUR_Hauteur_des_briques])
            cube([MUR_TAILLE,BALCON_Diametre/2-(TOUR_Taille_des_joints*2)-TOUR_Taille_des_joints,TOUR_Hauteur_des_briques*(BALCON_Nombre_de_briques_verticalement+TOUR_Taille_des_joints)]);
            }
    }
    color([00,0,0,1])
    {
        rotate([0,0,90])
        translate([0,-(MUR_Epaissseur_du_mur-TOUR_Taille_des_joints)/2,0])
        cube([MUR_TAILLE,(MUR_Epaissseur_du_mur-TOUR_Taille_des_joints),TOUR_HP2-1]);
        difference()
        {
            rotate([0,0,90])        
            translate([0,-(BALCON_Diametre/2-TOUR_Taille_des_joints)/2,TOUR_HP2])
            cube([MUR_TAILLE,BALCON_Diametre/2-TOUR_Taille_des_joints,(BALCON_Nombre_de_briques_verticalement-1)*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)]);
            rotate([0,0,90])        
            translate([0,-(BALCON_Diametre/2-TOUR_Taille_des_joints*2)/2,TOUR_HP2-5])
            cube([MUR_TAILLE,BALCON_Diametre/2-TOUR_Taille_des_joints*2,(BALCON_Nombre_de_briques_verticalement-1)*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints*2)+10]);
            
            translate([0,0,TOUR_HP2-5])
            cylinder(d=BALCON_Diametre-TOUR_Taille_des_joints,h=100);
            rotate([0,0,90])
            translate([MUR_TAILLE,0,TOUR_HP2-5])
            cylinder(d=BALCON_Diametre-TOUR_Taille_des_joints,h=100);
        }
    }
}
module tour()
{
    color([0.9,0.1,0.1,1])
    {
        if(TOUR_Fenetres=="non")
        {
            TourRouge();
        }
        else
        {
            difference()
            {
                TourRouge();
                //rotate([0,0,360/Nombre_de_tours/2-(360/TOUR_Nombre_de_briques_horizontalement/2)])
                rotate([0,0,-(360/TOUR_Nombre_de_briques_horizontalement/2)])
                for(i=[0:Nombre_de_tours-1])
                {
                rotate([0,0,360/Nombre_de_tours*i])
                translate([0,0,TOUR_HP2*2/3])
                brique(
                    aa=TOUR_Diametre_apres_raccord*2,
                    bb=TOUR_Diametre_base,
                    cc=TOUR_Nombre_de_briques_horizontalement,
                    dd=((TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)*3)-TOUR_Taille_des_joints*2,
                    ee=TOUR_Taille_des_joints);
                }
                rotate([0,0,-(360/TOUR_Nombre_de_briques_horizontalement/2)])
                for(i=[0:Nombre_de_tours-1])
                {
                rotate([0,0,360/Nombre_de_tours*i])
                translate([0,0,TOUR_HP2+(TOUR_TOIT-TOUR_HP2)*2/3])
                brique(
                    aa=TOUR_Diametre_apres_raccord*2,
                    bb=TOUR_Diametre_base,
                    cc=TOUR_Nombre_de_briques_horizontalement,
                    dd=((TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)*2)-TOUR_Taille_des_joints*2,
                    ee=TOUR_Taille_des_joints);
                }                
            }
        }
        
    }
    color([0,0,0,1])
    {
        cylinder(d=TOUR_Diametre_apres_raccord-TOUR_Taille_des_joints,h=TOUR_Hauteur_base+TOUR_Hauteur_raccord+(TOUR_Nombre_de_briques_verticalement*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)));
                translate([0,0,TOUR_Hauteur_base+TOUR_Hauteur_raccord+(TOUR_Nombre_de_briques_verticalement*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)+TOUR_Hauteur_des_briques)])
        
        linear_extrude(height=(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)*(BALCON_Nombre_de_briques_verticalement-1))
        difference()
        {
            circle(d=BALCON_Diametre-TOUR_Taille_des_joints,h=((TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)*BALCON_Nombre_de_briques_verticalement));
            circle(d=BALCON_Diametre-TOUR_Hauteur_des_briques+TOUR_Taille_des_joints,h=((TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)*BALCON_Nombre_de_briques_verticalement));
        }
        
        translate([0,0,TOUR_HP2])
        cylinder(d=TOUR_Partie_haute_diametre-TOUR_Taille_des_joints,h=TOUR_Partie_haute_nombre_de_briques_verticalement*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints));
    }
    color([0.2,0.6,0.8,1])
    {
        translate([0,0,TOUR_TOIT])
        MonToit();
    }
}
module brique()
{
    linear_extrude(height=dd)
    intersection()
    {
        circle(d=aa);
        offset(-ee/2)
        polygon([[0,0],[bb*1.1,0],[cos(360/cc)*bb*2,sin(360/cc)*bb*2]], paths=[[0,1,2]]);
    }
}
module TourRouge()
{
    cylinder(d=TOUR_Diametre_base,h=TOUR_Hauteur_base,$fn=64);    
        translate([0,0,TOUR_Hauteur_base])
        cylinder(d1=TOUR_Diametre_base,d2=TOUR_Diametre_apres_raccord,h=TOUR_Hauteur_raccord,$fn=64);
        translate([0,0,TOUR_Hauteur_base+TOUR_Hauteur_raccord])
        for(j=[0:TOUR_Nombre_de_briques_verticalement-1])
        {
            translate([0,0,j*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)])
            for(i=[1:TOUR_Nombre_de_briques_horizontalement])
            {
                    if((j/2)==floor(j/2))
                    {
                        rotate([0,0,360/TOUR_Nombre_de_briques_horizontalement*i])
                        brique(
                            aa=TOUR_Diametre_apres_raccord,
                            bb=TOUR_Diametre_base,
                            cc=TOUR_Nombre_de_briques_horizontalement,
                            dd=TOUR_Hauteur_des_briques,
                            ee=TOUR_Taille_des_joints);
                    }
                    else
                    {
                        rotate([0,0,360/TOUR_Nombre_de_briques_horizontalement*i+(360/TOUR_Nombre_de_briques_horizontalement/2)])
                        brique(
                            aa=TOUR_Diametre_apres_raccord,
                            bb=TOUR_Diametre_base,
                            cc=TOUR_Nombre_de_briques_horizontalement,
                            dd=TOUR_Hauteur_des_briques,
                            ee=TOUR_Taille_des_joints);                      
                    }
            }
        }
        translate([0,0,TOUR_Hauteur_base+TOUR_Hauteur_raccord+(TOUR_Nombre_de_briques_verticalement*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints))])
        cylinder(d=BALCON_Diametre,h=TOUR_Hauteur_des_briques);
        difference()
        {
            translate([0,0,TOUR_Hauteur_base+TOUR_Hauteur_raccord+(TOUR_Nombre_de_briques_verticalement*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)+TOUR_Hauteur_des_briques)])
            for(j=[0:BALCON_Nombre_de_briques_verticalement-1])
            {
                translate([0,0,j*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)])
                for(i=[1:TOUR_Nombre_de_briques_horizontalement])
                {
                    if((j/2)==floor(j/2))
                    {
                        if(j<BALCON_Nombre_de_briques_verticalement-1)
                        {
                            rotate([0,0,360/TOUR_Nombre_de_briques_horizontalement*i])
                            brique(
                                aa=BALCON_Diametre,
                                bb=TOUR_Diametre_base,
                                cc=TOUR_Nombre_de_briques_horizontalement,
                                dd=TOUR_Hauteur_des_briques,
                                ee=TOUR_Taille_des_joints);
                        }
                        else
                        {
                            rotate([0,0,(360/TOUR_Nombre_de_briques_horizontalement*i)*2])
                            brique(
                                aa=BALCON_Diametre,
                                bb=TOUR_Diametre_base,
                                cc=TOUR_Nombre_de_briques_horizontalement,
                                dd=TOUR_Hauteur_des_briques,
                                ee=TOUR_Taille_des_joints);
                        }
                    }
                    else
                    {
                        if(j<BALCON_Nombre_de_briques_verticalement-1)
                        {
                            rotate([0,0,360/TOUR_Nombre_de_briques_horizontalement*i+(360/TOUR_Nombre_de_briques_horizontalement/2)])
                            brique(
                                aa=BALCON_Diametre,
                                bb=TOUR_Diametre_base,
                                cc=TOUR_Nombre_de_briques_horizontalement,
                                dd=TOUR_Hauteur_des_briques,
                                ee=TOUR_Taille_des_joints);
                        }
                        else
                        {
                            rotate([0,0,720/TOUR_Nombre_de_briques_horizontalement*i+(360/TOUR_Nombre_de_briques_horizontalement/2)])
                            brique(
                                aa=BALCON_Diametre,
                                bb=TOUR_Diametre_base,
                                cc=TOUR_Nombre_de_briques_horizontalement,
                                dd=TOUR_Hauteur_des_briques,
                                ee=TOUR_Taille_des_joints);
                        }
                    }
                }
            }        
        translate([0,0,TOUR_Hauteur_base+TOUR_Hauteur_raccord+(TOUR_Nombre_de_briques_verticalement*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)+TOUR_Hauteur_des_briques)])
        cylinder(d=BALCON_Diametre-TOUR_Hauteur_des_briques,h=((TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)*BALCON_Nombre_de_briques_verticalement));
        
            
        }
        translate([0,0,TOUR_HP2])
        for(j=[0:TOUR_Partie_haute_nombre_de_briques_verticalement-1])
        {
            translate([0,0,j*(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)])
            for(i=[1:TOUR_Nombre_de_briques_horizontalement])
            {
                if((j/2)==floor(j/2))
                {
                    rotate([0,0,360/TOUR_Nombre_de_briques_horizontalement*i])
                    brique(
                        aa=TOUR_Partie_haute_diametre,
                        bb=TOUR_Diametre_base,cc=TOUR_Nombre_de_briques_horizontalement,
                        dd=TOUR_Hauteur_des_briques,
                        ee=TOUR_Taille_des_joints);
                }
                else
                {
                    rotate([0,0,360/TOUR_Nombre_de_briques_horizontalement*i+(360/TOUR_Nombre_de_briques_horizontalement/2)])
                    brique(
                        aa=TOUR_Partie_haute_diametre,
                        bb=TOUR_Diametre_base,
                        cc=TOUR_Nombre_de_briques_horizontalement,
                        dd=TOUR_Hauteur_des_briques,
                        ee=TOUR_Taille_des_joints);                      
                }
            }
        }
    }
module HautRouge()
    {
        union(){translate([0,-BALCON_Diametre/4,TOUR_HP2-TOUR_Hauteur_des_briques-TOUR_Taille_des_joints])
        for(j=[0:BALCON_Nombre_de_briques_verticalement-1])
        {
            translate([0,0,(TOUR_Hauteur_des_briques+TOUR_Taille_des_joints)*j])
            
            if((j/2)==floor(j/2))
            {
                translate([0,(MUR_Largeur_des_briques+TOUR_Taille_des_joints)/2,0])
                for(i=[0:MUR_Nombre_de_briques_horizontalement-1])
                {
                    translate([-BALCON_Diametre/2/2,i*(MUR_Largeur_des_briques+TOUR_Taille_des_joints),0])
                    cube([BALCON_Diametre/2,MUR_Largeur_des_briques,TOUR_Hauteur_des_briques]);
                }
            }
            else
            {
                translate([-BALCON_Diametre/2/2,(MUR_Largeur_des_briques+TOUR_Taille_des_joints),0])
                for(i=[0:MUR_Nombre_de_briques_horizontalement-1])
                {
                    translate([0,i*(MUR_Largeur_des_briques+TOUR_Taille_des_joints),0])
                    cube([BALCON_Diametre/2,MUR_Largeur_des_briques,TOUR_Hauteur_des_briques]);
                }
            }
            
            
    }
}
   
}
module MonToit()
{
    cylinder(d1=TOUR_TOIT_Diametre_du_toit,d2=0,h=TOUR_TOIT_Hauteur_du_toit);
    translate([0,0,TOUR_TOIT_Hauteur_du_toit])
    sphere(d=10);
    
}