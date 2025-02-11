SetFactory("OpenCASCADE");

Macro GenerateMesh
    // Outer
    // a = semi-major axis
    // b = semi-minor axis
    Ellipse(1) = {0, 0, 0, a, b, 0, Pi/2};

    // Inner
    fac = 0.5;
    a = fac * a; // semi-major axis
    b = fac * b;  // semi-minor axis
    Ellipse(2) = {0, 0, 0, a, b, 0, Pi/2};

    // Symmetry lines
    Line(3) = {1, 3};
    Line(4) = {2, 4};

    // Define surface
    Curve Loop(1) = {4, -2, -3, 1};
    Plane Surface(1) = {1};

    // boundaries
    Physical Curve("outer", 1) = {1};
    Physical Curve("inner", 2) = {2};
    Physical Line("symmetry_x", 3) = {3};
    Physical Line("symmetry_y", 4) = {4};
    Physical Surface("fluid") = {1};

    // Assign a mesh size to all the points of all the volumes:
    MeshSize{ PointsOf{ Surface{:}; } } = mesh_size;
    // MeshSize{ PointsOf{ Curve{1}; } } = lc;
    // MeshSize{ PointsOf{ Curve{2}; } } = lc;

    Mesh 2;
Return

a = 1e-3;
b = 1e-3;
mesh_size = b * 0.1;
Call GenerateMesh;
Save "./ecs_100/ecs_100.msh";
Delete Model;

a = 1e-3;
b = 1e-3 * 3/4;
mesh_size = b * 0.125;
Call GenerateMesh;
Save "./ecs_75/ecs_75.msh";
Delete Model;

a = 1e-3;
b = 1e-3 * 2 / 4;
mesh_size = b * 0.15;
Call GenerateMesh;
Save "./ecs_50/ecs_50.msh";
Delete Model;

a = 1e-3;
b = 1e-3 * 1 / 4;
mesh_size = b * 0.2;
Call GenerateMesh;
Save "./ecs_25/ecs_25.msh";
Delete Model;