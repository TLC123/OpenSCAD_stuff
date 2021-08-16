function norm(v)=sqrt(dot(v,v));
function normalized(v)=v/norm(v);
function dot(u,v)=u[0]*v[0]+u[1]*v[1]+u[2]*v[2];
function cross(u,v)=[u[1]*v[2]-u[2]*v[1],v[0]*u[2]-v[2]*u[0],u[0]*v[1]-u[1]*v[0]];

function ztwist(theta) =
	[
		[cos(theta)	,-sin(theta),0],
		[sin(theta)	, cos(theta),0],
		[0	,0,	1]
	];

function vtozturn(v)=
	(v[0]*v[0]+v[1]*v[1])?
	[
			[v[2]/sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]),0,-sqrt(v[0]*v[0]+v[1]*v[1])/sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2])],
			[0,1,0],
			[sqrt(v[0]*v[0]+v[1]*v[1])/sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]),0,v[2]/sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2])]
		]
	*
		[
			[v[0]/sqrt(v[0]*v[0]+v[1]*v[1]),v[1]/sqrt(v[0]*v[0]+v[1]*v[1]),0],
			[-v[1]/sqrt(v[0]*v[0]+v[1]*v[1]),v[0]/sqrt(v[0]*v[0]+v[1]*v[1]),0],
			[0,0,1]
		]

        :
				v[2]>0?
                [[1,0,0],
                [0,1,0],
                [0,0,1]]
				:
                [[1,0,0],
                [0,-1,0],
                [0,0,-1]]
;

function ztovturn(v)=
	(v[0]*v[0]+v[1]*v[1])?
		[
			[v[0]/sqrt(v[0]*v[0]+v[1]*v[1]),-v[1]/sqrt(v[0]*v[0]+v[1]*v[1]),0],
			[v[1]/sqrt(v[0]*v[0]+v[1]*v[1]),v[0]/sqrt(v[0]*v[0]+v[1]*v[1]),0],
			[0,0,1]
		]
		*
		[	
			[v[2]/sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]),0,sqrt(v[0]*v[0]+v[1]*v[1])/sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2])],
			[0,1,0],
			[-sqrt(v[0]*v[0]+v[1]*v[1])/sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]),0,v[2]/sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2])]
		]
        :
				v[2]>0?
                [[1,0,0],
                [0,1,0],
                [0,0,1]]
				:
                [[1,0,0],
                [0,-1,0],
                [0,0,-1]]
;


function translate_path(v,path,i=0) =
	i>=len(path)? [] :
	concat([path[i]+v],translate_path(v,path,i+1));

function turn_path(m,p,i=0) =
	i>=len(p)? [] :
	concat([m*p[i]],turn_path(m,p,i+1));

function extend_path(p) =
	concat(p,[2*p[len(p)-1]-p[len(p)-2]]);

//fpath -
//	point,
//	parralel,
//	mirror plane normal, 
//	mirror plane distance
function futz_path(p,index=1) =
	index>=len(p)-1? [] :
	concat(
		[[
			p[index],
			normalized(p[index]-p[index-1]),
			normalized(conormal(p[index]-p[index-1],p[index+1]-p[index])),
			dot(p[index],normalized(conormal(p[index]-p[index-1],p[index+1]-p[index])))
		]]		
		,futz_path(p,index+1));

//Interpolating planes to support twisting into bias cuts.

function futz_path_interpolate(p,n,index=1) =
	index>=len(p)? [p[index-1]] :
		concat((index==1)?[]:[p[index-1]],
			concat(
				futz_path_interpolate_helper (
					p[index-1][0],
					p[index][0]-p[index-1][0],
					normalized(p[index][0]-p[index-1][0]),
					p[index-1][2],
					normalized(p[index][2]-p[index-1][2]*dot(p[index-1][2],p[index][2])),
					acos(dot(p[index-1][2],p[index][2])),
					n
				) ,futz_path_interpolate(p,n,index+1)
			)
		);

function futz_path_interpolate_helper (from,along,normalized_along,from_normal,along_normal,theta,n,i=1) =
	i>=n?[]:
	concat(
		[[
			from+along*(i/n),
			normalized_along,
			cos(theta*(i/n))*from_normal+sin(theta*(i/n))*along_normal,
			dot(from+along*(i/n),cos(theta*(i/n))*from_normal+sin(theta*(i/n))*along_normal)
		]],futz_path_interpolate_helper (from,along,normalized_along,from_normal,along_normal,theta,n,i+1));


function conormal(u,v) =
	dot(u,v)*dot(u,v)==dot(u,u)*dot(v,v) ?
		u
	:
		-cross(
			normalized(u)-normalized(v),
			cross(u,v)
		);

function project_point(point,along_vector,to_plane,d)=
	(
		d-
		dot(point,to_plane)
	) *
		along_vector / dot(along_vector,to_plane)
	+
		point;

function project_profile(profile,along_vector,to_plane,d,index=0) =
	index >= len(profile) ? [] :
	concat([project_point(profile[index],along_vector,to_plane,d)],project_profile(profile,along_vector,to_plane,d,index+1));


function transform_profile(profile,transform,i=0) =
	i>=len(profile)?[]:
	concat([transform*profile[i]],transform_profile(profile,transform,i+1));


function twist_profile_along(center,profile,twist,axis,i=0) =
	i>=len(profile)?[]:
	concat(
		[(ztovturn(axis)*ztwist(twist)*vtozturn(axis)*(profile[i]-center))+center],twist_profile_along(center,profile,twist,axis,i+1));
	;

function project_along_fpath(profile,fpath,twist=0,i=0) =
	concat(
		profile,
		project_along_fpath_helper(profile,fpath,twist,i)
	);

function project_along_fpath_helper(profile,fpath,twist=0,i=0) =
	i>=len(fpath)? []:
	project_along_fpath(
		project_profile(
			twist_profile_along(
				fpath[i][0],
				profile,
				(i>0)?norm(fpath[i][0]-fpath[i-1][0])*twist:0,
				fpath[i][1]),
			fpath[i][1],
			fpath[i][2],
			fpath[i][3]
		),
		fpath,
		twist,
		i+1
	);

function start_cap (profile,i=0) = 
	(i+2)>=len(profile) ? [] :
	concat(
		[[0,i+1,i+2]],
		start_cap(profile,i+1)
	);

function quads (profile,offset,i=0) =
	i>=len(profile) ? [] : 
	concat(
		[
			[offset+i,offset+len(profile)+i,offset+(i+1)%len(profile)],
			[offset+len(profile)+(i+1)%len(profile),offset+(i+1)%len(profile),offset+len(profile)+i]
		],
		quads(profile,offset,i+1));

function sheath (profile,path,i=0) =
	i>=len(path)-1 ? [] :
	concat(quads(profile,len(profile)*i),sheath(profile,path,i+1));

function end_cap (profile,path,i=0) =
	(i+2)>=len(profile) ? [] :
	concat(
		[[((len(path)-1)*len(profile)),((len(path)-1)*len(profile))+i+2,(len(path)-1)*len(profile)+i+1]],
		end_cap(profile,path,i+1)
	);

function caps (profile,path) =
	concat(start_cap(profile),end_cap(profile,path));

function skin (profile,path) =
	concat(caps(profile,path),sheath(profile,path));

function extendm (m) =
	[
		concat(m[0],[0]),
		concat(m[1],[0]),
		concat(m[2],[0]),
		[0,0,0,1]];

function extendfpath (p) =
	concat([[[0,0,0],[0,0,1],[0,0,1],0]],p);

/*
profile=[
		[0.5,0,0],
		[1,1,0],
		[0,0.5,0],
		[-1,1,0],
		[-0.5,0,0],
		[-1,-1,0],
		[0,-0.5,0],
		[1,-1,0]
];
*/

profile=[[1,1,0],[-1,1,0],[-1,-1,0],[1,-1,0]];

function torusknot (p=2,q=3,i=0,step=2) =
	i>360?[]:
	concat([4*[cos(q*i)*(3+cos(p*i)),sin(q*i)*(3+cos(p*i)),sin(p*i)]],torusknot(p,q,i+step,step));

function wallacetrefoil (p=2,q=1,i=0,step=5) =
	i>360?[]:
	concat([4*[sin(q*i)+sin(p*i),cos(q*i)-cos(p*i),-sin((p+q)*i)]],wallacetrefoil(p,q,i+step,step));

path=torusknot();
//path=wallacetrefoil();
//path=[[0,0,3],[0,-3,3],[0,-3,-3],[0,3,-3],[0,3,3],[3,0,3]];
//path=[[0,0,0],[10,0,0],[10,10,0],[10,10,10]];
//path=[[10,10,0],[10,-10,0],[-10,-10,0],[-10,10,0],[10,10,0]];

//path=[[-5*sqrt(2),0,0],[-5,-5,0],[0,-5*sqrt(2),0],[5,-5,0],[5*sqrt(2),0,0],[10*sqrt(2),0,0],[10*sqrt(2),-4*sqrt(2),0],[15*sqrt(2),-5*sqrt(2),0]];
p=					turn_path(
						vtozturn(path[1]-path[0]),
						translate_path(
							-path[0],path
						)
					);
fpath=			futz_path(
				extend_path(
					concat(p)
				)
			);
ifpath=futz_path_interpolate(
			extendfpath(fpath)
			,2);

points=project_along_fpath(profile,ifpath,12);
faces=skin(profile,ifpath);

//cube([14,14,1],center=true);
translate(path[0]) multmatrix(extendm(ztovturn(path[1]-path[0])))
polyhedron(
	points=points,
	faces=faces
);


