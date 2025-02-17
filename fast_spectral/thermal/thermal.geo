 /*
Profile of the axisymmetric stenosis following a cosine
function dependent on the axial coordinate x [1].

    f(x) = R * (1 - f0/2 *(1 + Cos(2.0*Pi * (x-x0)/L) )
    -- x0 maximum stenosis position.
    -- L stenosis length.
    -- R vessel radius
    -- f0 obstruction fraction, ranging 0--1.

References:

[1] Varghese, S. S., Frankel, S. H., Fischer, P. F., 'Direct numerical simulation of steotic flows. Part 1. Steady flow', Journal of Fluid Mechanics, vol. 582, pp. 253 - 280.
*/

ls = 2e-7;
f = ls * 0.4;

H0 = 1e-6; // Channel height

Xi = 0.75*H0; // length of input section
Xo = 0.75*H0; // length of output section
L = H0;    // length of bump section
H = H0;     // Height of the inlet and outlet

R = 0.5*H0;  // radius of bump
x0 = Xi + L/2.0; // center of bump

Macro GenerateMesh
    Point(1) = {0, 0, 0, ls};
    Point(2) = {Xi + L + Xo, 0, 0, ls};
    Point(3) = {Xi + L + Xo, H, 0, ls};
    Point(4) = {Xi + L, H, 0, ls};
    Point(5) = {Xi + L, R, 0, ls};
    Point(6) = {Xi, R, 0, ls};
    Point(7) = {Xi, H, 0, ls};
    Point(8) = {0, H, 0, ls};

    Line(1) = {1, 2};
    Line(2) = {2, 3};
    Line(3) = {3, 4};
    Line(4) = {4, 5};

    pList[0] = 6; // First point label
    nPoints = 21; // Number of discretization points (top-right point of the inlet region)
    For i In {1 : nPoints}
        x = Xi + L*i/(nPoints + 1);
        pList[i] = newp;
        Point(pList[i]) = {x,
                    ( R * (1 - f0/2 *(1 + Cos(2.0*Pi * (x-x0)/L) ) )),
                    0,
                    ls};
    EndFor
    pList[nPoints+1] = 5; // Last point label (top-left point of the outlet region)
    Spline(5) = pList[];

    Line(6) = {6, 7};
    Line(7) = {7, 8};
    Line(8) = {8, 1};

    MeshSize{ PointsOf{ Curve{4,5,6}; } } = f;

    Curve Loop(1) = {1, 2, 3, 4, -5, 6, 7, 8};
    Plane Surface(1) = {1};

    Physical Curve("symmetry") = {1};
    Physical Curve("outlet", 9) = {2, 3};
    Physical Curve("wall_right", 10) = {4};
    Physical Curve("wall_middle", 11) = {5};
    Physical Curve("wall_left", 12) = {6};
    Physical Curve("inlet", 13) = {7, 8};
    Physical Surface("fluid") = {1};
Return

f0 = 0;
Call GenerateMesh;
Mesh 2;
Save "thermal_f00/thermal_f00.msh";
RefineMesh;
Save "thermal_f00_refine2x/thermal_f00.msh";
Delete Model;

f0 = 0.2;
Call GenerateMesh;
Mesh 2;
Save "thermal_f20/thermal_f20.msh";
RefineMesh;
Save "thermal_f20_refine2x/thermal_f20.msh";
Delete Model;

f0 = 0.4;
Call GenerateMesh;
Mesh 2;
Save "thermal_f40/thermal_f40.msh";
RefineMesh;
Save "thermal_f40_refine2x/thermal_f40.msh";
Delete Model;

f0 = 0.6;
Call GenerateMesh;
Mesh 2;
Save "thermal_f60/thermal_f60.msh";
RefineMesh;
Save "thermal_f60_refine2x/thermal_f60.msh";
Delete Model;

f0 = 0.8;
Call GenerateMesh;
Mesh 2;
Save "thermal_f80/thermal_f80.msh";
RefineMesh;
Save "thermal_f80_refine2x/thermal_f80.msh";
Delete Model;
