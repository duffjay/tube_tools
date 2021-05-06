include <dovetail.scad>;
include <letter.scad>;

// 180 degree bend




engrave_text = "14mm";
tubing_od = 14;
tool_z = 18.5;
tube_tolerance = 0.2;

inside_bend_radius = 48/2;
center_bend_radius = 48/2 + tubing_od/2;

// designed for drywall screws #6 x 1 1/4
mnt_screw_dia = 3.8;
mnt_screw_head_dia = 9.2 ;
mnt_screw_head_countersink =  3;   // distance to bottom

bearing_id = 8;
bearing_od = 16;
bearing_z = 5;

$fn = 50;



// checklists
// 1. did you set tolerance on dovetails (male = 0, female = 0.2)


        difference () {
            {
            cylinder(r = center_bend_radius, h = tool_z, center = true);
            }
            {
            // tube grove
            rotate_extrude(convexity = 10, $fn = 100)
            translate([center_bend_radius,0,0])
            circle(r = tubing_od/2 + tube_tolerance, $fn = 100);

            // center hub
            // center hole
            cylinder(r = bearing_id/2 + 0.2, h = tool_z, center = true);
            // bearing hole
            bearing_hole_depth = tool_z/2 + bearing_z/2;
            translate([0,0, -(tool_z/2 - bearing_hole_depth/2)])
            #cylinder(r = bearing_od/2 + 0.1, h = bearing_hole_depth, center = true);
                
            // angle lines
            // 0
            for (angle = [0, 45, 90, 135, 180, 225, 270, 315]) {
                rotate([0,0, angle])
                translate([0,0,tool_z/2 - 0.5])
                cube([inside_bend_radius + tubing_od/3, 0.5, 0.5], center=false);
            }
            
            // engraved top
            translate([18,0,tool_z/2 -1])
            letter(engrave_text, 1, 4, "Liberation Sans");
            }

        }