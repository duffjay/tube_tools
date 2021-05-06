// straight


include <dovetail.scad>;
include <letter.scad>;

engrave_text = "14 x 40mm";
tubing_od = 14;
tool_z = 18.5;
tube_tolerance = 0.2;

inside_bend_radius = 48/2;
center_bend_radius = 48/2 + tubing_od/2;

// str = straight section
str_x = 40;

// designed for drywall screws #6 x 1 1/4
mnt_screw_dia = 3.8;
mnt_screw_head_dia = 9.2 ;
mnt_screw_head_countersink =  3;   // distance to bottom

$fn = 50;

// TODO


difference () {
    {
    union () {
        cube([str_x, center_bend_radius, tool_z],center = true);
        
        // female dovetail
        translate([-str_x/2, -center_bend_radius/2 + 10,0])
        rotate([0,0,90])
        dovetail(3,tool_z, 0.2);
        }
    }
    // substract
    {
    // tube grove
    translate([0,center_bend_radius/2,0])
    rotate([0,90,0])
    cylinder(r = tubing_od/2 + tube_tolerance, h = str_x, center = true);
        
    // female dovetail
    translate([str_x/2, -center_bend_radius/2 + 10,0])
    rotate([0,0,90])
    dovetail(3,tool_z, 0.2);
        
    // mounting holes
    y_base = -center_bend_radius/2;
    hole_set = [[8, y_base + 8], [-8,y_base + 18],
        [8, y_base + 18], [-8,y_base + 8]];
    for ( i = hole_set ) {
        union () {
        translate([i[0],i[1],0])
        cylinder(r = mnt_screw_dia/2, h = tool_z, center = true);
        
        translate([i[0],i[1],(tool_z/2 - mnt_screw_head_countersink/2)])
        cylinder(r = mnt_screw_head_dia/2, 
            h = mnt_screw_head_countersink, 
            center = true);
        }
    }
    
    // angle lines
    // 0
    translate([0, center_bend_radius/2 - center_bend_radius/10,tool_z/2 - 0.5])
    rotate([0,0, 90])
    cube([center_bend_radius/4, 0.5, 0.5], center=false);
    
    translate([10, center_bend_radius/2 - center_bend_radius/10,tool_z/2 - 0.5])
    rotate([0,0, 90])
    cube([center_bend_radius/10, 0.5, 0.5], center=false);
    
    translate([-10, center_bend_radius/2 - center_bend_radius/10,tool_z/2 - 0.5])
    rotate([0,0, 90])
    cube([center_bend_radius/4, 0.5, 0.5], center=false);
    
    // engraved top
    translate([0,10,tool_z/2 -1])
    letter(engrave_text, 1, 4, "Liberation Sans");
    }
}