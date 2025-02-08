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

ls = 2e-4;

Xi = 0.5e-3;
Xo = 0.5e-3;
L = 1e-3;

x0 = Xi + L/2.0;
R = 0.5e-3;
f0 = 0.5;

Z = 5e-3;
f = ls * 0.5;

Point(1) = {0, 0, 0, ls};
Point(2) = {Xi, R, 0, f};
Point(3) = {0, R, 0, f};

Point(4) = {Xi + L + Xo, 0, 0, ls};
Point(5) = {Xi + L + Xo, R, 0, f};
Point(6) = {Xi + L, R, 0, f};

Line(1) = {1, 4};
Line(2) = {4, 5};
Line(3) = {5, 6};
Line(4) = {2, 3};
Line(5) = {3, 1};

pList[0] = 2; // First point label
nPoints = 21; // Number of discretization points (top-right point of the inlet region)
For i In {1 : nPoints}
    x = Xi + L*i/(nPoints + 1);
    pList[i] = newp;
    Point(pList[i]) = {x,
                ( R * (1 - f0/2 *(1 + Cos(2.0*Pi * (x-x0)/L) ) )),
                0,
                f};
EndFor
pList[nPoints+1] = 6; // Last point label (top-left point of the outlet region)
Spline(newl) = pList[];

Curve Loop(1) = {1, 2, 3, -6, 4, 5};
Plane Surface(1) = {1};

Physical Curve("bottom") = {1};
Physical Curve("right") = {2};
Physical Curve("left") = {5};
Physical Curve("top_left") = {4};
Physical Curve("top_right") = {3};
Physical Curve("top_center") = {6};
Physical Surface("fluid") = {1};

Mesh 2;
Save "contriction.msh";

