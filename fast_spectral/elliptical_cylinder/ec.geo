SetFactory("OpenCASCADE");

Macro GenerateMesh
    // Outer
    // a = semi-major axis
    // b = semi-minor axis
    Ellipse(1) = {0, 0, 0, a, b, 0, 2*Pi};

    // Inner
    fac = 0.5;
    a = fac * a; // semi-major axis
    b = fac * b;  // semi-minor axis
    Ellipse(2) = {0, 0, 0, a, b, 0, 2*Pi};

    // Define surface
    Curve Loop(1) = {2};
    Curve Loop(2) = {1};
    Plane Surface(1) = {1, 2};

    // boundaries
    Physical Curve("outer", 1) = {1};
    Physical Curve("inner", 2) = {2};
    Physical Surface("fluid") = {1};

    // Assign a mesh size to all the points of all the volumes:
    MeshSize{ PointsOf{ Surface{:}; } } = mesh_size;
    // MeshSize{ PointsOf{ Curve{1}; } } = lc;
    // MeshSize{ PointsOf{ Curve{2}; } } = lc;

    Mesh 2;
Return

a = 1e-3;
b = 1e-3;
mesh_size = b * 0.2;
Call GenerateMesh;
Save "./ec_100/ec_100.msh";
Delete Model;

a = 1e-3;
b = 1e-3 * 3/4;
mesh_size = b * 0.25;
Call GenerateMesh;
Save "./ec_75/ec_75.msh";
Delete Model;

a = 1e-3;
b = 1e-3 * 2 / 4;
mesh_size = b * 0.3;
Call GenerateMesh;
Save "./ec_50/ec_50.msh";
Delete Model;

a = 1e-3;
b = 1e-3 * 1 / 4;
mesh_size = b * 0.4;
Call GenerateMesh;
Save "./ec_25/ec_25.msh";
Delete Model;
