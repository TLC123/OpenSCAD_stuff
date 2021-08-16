refinemesh.scad

POSTdeform-PREsplit.

ReachBackAfterTheFactAdaptiveSubdivision

// Naive adaptive subdivision scheme for general mesh deformations.
// How it works is define a deformation function in a function litteral.
// Define target edge-lenght and a inittial larger multiple edge-length
// Then in recursion apply deformation to a copy of the mesh.
// For each DEFORMED triangle take note of what edegs are above larger treshold length.
// !! Split the ORIGINAL undeformed triangle !! by corresponding affected edges. Discard deformed copy. 
// Clean up results to a neat point,face form.
// Divide the treshold by two and repeat recurively until the larger threshold is less than target treshold.
// Apply a final deformation  of the subdivided original to obtain a defromed mesh with adaptve subdivision where it counts. 

![Image of MC](https://github.com/TLC123/OpenSCAD_stuff/blob/master/2021/refinemesh.PNG)
![Image of MC](https://github.com/TLC123/OpenSCAD_stuff/blob/master/2021/refinemesh2.PNG)
![Image of MC](https://github.com/TLC123/OpenSCAD_stuff/blob/master/2021/refinemesh3.PNG)
![Image of MC](https://github.com/TLC123/OpenSCAD_stuff/blob/master/2021/refinemesh4.PNG)
