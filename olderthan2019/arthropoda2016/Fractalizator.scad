// Radial Fractalizator
// By MagoNegro JUL-2016
//
// This script simply takes a model, and iteratively adds to itself radially creating a cool 'fractalization' effect. The iteration is achieved using recursive programming, which simplifies a lot the code.
//
// Warning: The render time could be laaaarge depending on your base model. Choose a simple one to start working.
// Recommended models that print vertically without support.
// IMPORTANT!! The model should have its origin in the geometric center of its base, otherwise it won't print without support. I mean that [0,0,0] should be the geom. center of the base, this implies that the .stl file coordinates are negative and positive values in X and Y coordinates, and only positive values on Z coordinates.
// Parameters:
MODELTOFRACTALIZE="wing.stl";
// (Critical value) MAX dimension of the model. eg. if model is [20mm,30mm,10mm] then we put here 30mm. I couldn't find out a way to obtain the imported stl dimensions. This is used to normalize the model in the calculations.
MODELMAXDIMENSION=3;

// Fractalization LEVEL (Not recommende more than 10), depends on your machine's power and your base model resolution
MAXLEVEL=6;
NUMRADIAL=20; // Radial model count
ANGLE=360/NUMRADIAL;
// Magnification factor:
SCALE=5;
// Factor to gradually increase distance from objects between iterations (between 1 and 1.5 recommended.)
// Dont increment it so much, it could detach some external objects from the fractalization main object.
RATIO=1.0;

module Figure(D)
{
    R=(MAXLEVEL-D);
    scale(v = [SCALE*R/MODELMAXDIMENSION, SCALE*R/MODELMAXDIMENSION, SCALE*R/MODELMAXDIMENSION])
        import (MODELTOFRACTALIZE, convexity = 4); 
}

module Fractalize(D)
{
    if(D<MAXLEVEL)
    {
        union()
            {
            for (i=[0:NUMRADIAL-1])
                {
                XX=SCALE*cos(i*ANGLE)*D*RATIO;
                YY=SCALE*sin(i*ANGLE)*D*RATIO;
                translate([XX,YY,0]) rotate([90,-D*10,i*ANGLE]) Figure(D);
                }
            Fractalize(D+1);
            }
    }
}

union()
    {
    //Figure(0);
    Fractalize(1);
    }
