// create a dovetail
// male = set tolerance = 0
// female = set tolerance = 0.2

module dovetail (base_dim, base_z, tolerance) {

    $fn = 50;


    linear_extrude(height = base_z, center = true, convexity = 10)
    polygon([[-(base_dim + tolerance),0],[(base_dim + tolerance),0],
        [(base_dim * 2 + tolerance),(base_dim + tolerance)],
        [-(base_dim * 2 + tolerance),(base_dim + tolerance)]],
        [[3,2,1,0]]);
    
}

// dovetail (5, 18, 0);