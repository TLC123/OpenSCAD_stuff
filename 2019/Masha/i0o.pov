#version 3.7; // 3.6
global_settings { assumed_gamma 1.0 }
#default { finish { ambient 0.2 diffuse 0.9 } }
#default { pigment { rgb <0.800, 0.800, 0.800> } }

//------------------------------------------
#include "colors.inc"
#include "textures.inc"

#include "rad_def.inc"
global_settings {
	radiosity {
		Rad_Settings(Radiosity_IndoorHQ, off, off)
	}
}
#default { finish{ ambient 0 } }

//------------------------------------------
#include "i0o_textures.inc"
#include "i0o_meshes.inc"

//------------------------------------------
// Camera ----------------------------------
#declare CamUp = <0, 0, 1>;
#declare CamRight = <1.33, 0, 0>;
#declare CamRotation = <-17.866065631210788, 1.009315517520273e-05, 38.11448411392628>;
#declare CamPosition = <118.72801971435547, -170.6322784423828, 171.0760955810547>;
camera {
	location <0, 0, 0>
	direction <0, 1, 0>
	up CamUp
	right CamRight
	rotate CamRotation
	translate CamPosition
	angle 57.82
}

// FreeCAD Light -------------------------------------
light_source { CamPosition color rgb <0.5, 0.5, 0.5> }

// Background ------------------------------
sky_sphere {
	pigment {
		gradient z
		color_map {
			[ 0.00  color rgb<0.592, 0.592, 0.667> ]
			[ 0.30  color rgb<0.592, 0.592, 0.667> ]
			[ 0.70  color rgb<0.200, 0.200, 0.396> ]
			[ 1.00  color rgb<0.200, 0.200, 0.396> ]
		}
		scale 2
		translate -1
		rotate<-17.866065631210788, 1.009315517520273e-05, 38.11448411392628>
	}
}

//------------------------------------------

#include "i0o_user.inc"

// Objects in Scene ------------------------

//----- masha -----
object { masha_mesh
}

//----- PovProject -----