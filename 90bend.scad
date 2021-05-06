include <dovetail.scad>;
include <letter.scad>;

// 180 degree bend




engrave_text = "14mm 180";
tubing_od = 14;
tool_z = 18.5;

inside_bend_radius = 48/2;
center_bend_radius = 48/2 + tubing_od/2;

// designed for drywall screws #6 x 1 1/4
mnt_screw_dia = 3.8;
mnt_screw_head_dia = 9.2 ;
mnt_screw_head_countersink =  3;   // distance to bottom

$fn = 50;

// TODO
// 1. put in some measuring lines
// 2. put in some holes
// 3. dove tails
// 4. stamp dimensions:  14mm 

// checklists
// 1. did you set tolerance on dovetails (male = 0, female = 0.2)

union () {
{
    intersection () {
        {
        // keep 180
        translate([center_bend_radius,0,0])
        cube([center_bend_radius * 2, center_bend_radius * 2, tool_z], center = true);
        }
        // 360 deg bend
        {
        difference () {
            {
            cylinder(r = center_bend_radius, h = tool_z, center = true);
            }
            {
            // o-ring grove
            rotate_extrude(convexity = 10, $fn = 100)
            translate([center_bend_radius,0,0])
            circle(r = tubing_od/2, $fn = 100);
            // female dovetail
            translate([0,-10,0.2])
            rotate([0,0,-90])
            dovetail(3,tool_z, 0);
            // mounting holes
            hole_set = [[8,8], [8,18], [18,8], [8,-8], [8,-18], [18,-8]];
            for ( i = hole_set ) {
                union () {
                translate([i[0],i[1],0])
                cylinder(r = mnt_screw_dia/2, h = tool_z, center = true);
                
                translate([i[0],i[1],(tool_z/2 - mnt_screw_head_countersink/2)])
                #cylinder(r = mnt_screw_head_dia/2, 
                    h = mnt_screw_head_countersink, 
                    center = true);
                }
            }
                
            // angle lines
            // 0
            translate([0,0,tool_z/2 - 0.5])
            cube([inside_bend_radius + tubing_od/3, 0.5, 0.5], center=false);

            rotate([0,0,45])
            translate([0,0,tool_z/2 - 0.5])
            cube([inside_bend_radius + tubing_od/3, 0.5, 0.5], center=false);

            rotate([0,0,-45])
            translate([0,0,tool_z/2 - 0.5])
            cube([inside_bend_radius + tubing_od/3, 0.5, 0.5], center=false);
            }
                
            // engraved top
            translate([14,0,tool_z/2 -1])
            letter(engrave_text, 1, 4, "Liberation Sans");
            }
        }
    }   
}   // end of main shape
{
    // male dovetail
    translate([0,10,0])
    rotate([0,0,90])
    dovetail(3,tool_z, 0);    
    

}
}