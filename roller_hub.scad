// roller hub

hub_major_dia = 15;
hub_minor_dia = 7.9;

tool_z = 18.5;
m4_pilot = 3.2;

bearing_id = 8;
bearing_od = 16;
bearing_z = 5;

$fn = 50;

difference () {
    {
    union () {
        cylinder (r = hub_major_dia/2, h = tool_z/2 - bearing_z, center = true);
        translate([0,0, (tool_z/2 - bearing_z)/2 + (tool_z + 2)/2])
        cylinder (r = hub_minor_dia/2, h = tool_z + 2, center = true);
        }
    }
    {
        translate([0,0,8])
        cylinder(r = m4_pilot/2, h = 30, center = true);
    }
}