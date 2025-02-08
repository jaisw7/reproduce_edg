lc = 1e-4;

p1 = newp; Point(p1) = {0, 0, 0, lc};
p2 = newp; Point(p2) = {1e-3, 0, 0, lc};
p3 = newp; Point(p3) = {1e-3, 1e-4, 0, lc};
p4 = newp; Point(p4) = {0, 1e-4, 0, lc};

l1 = newc; Line(l1) = {p1, p2};
l2 = newc; Line(l2) = {p2, p3};
l3 = newc; Line(l3) = {p3, p4};
l4 = newc; Line(l4) = {p4, p1};

Transfinite Curve{l1} = 11;
Transfinite Curve{l2} = 2;
Transfinite Curve{l3} = 11;
Transfinite Curve{l4} = 2;

Physical Curve("left", 5) = {l4};
Physical Curve("right", 6) = {l2};
Physical Curve("periodic-ydir-l", 7) = {l3};
Physical Curve("periodic-ydir-r", 8) = {l1};

// periodic mesh
Periodic Line {l3} = {l1} Translate {0, 1e-4, 0};

Curve Loop(1) = {l1, l2, l3, l4};
Plane Surface(1) = {1};
Physical Surface("fluid") = {1};
Transfinite Surface{1} = {l1, l2, l3, l4};

Mesh 2;
Save "couette.msh";
