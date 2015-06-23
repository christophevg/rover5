include <general.scad>
include <rover5.scad>

r5_battery_width     = r5_body_width;
r5_battery_length    = 56;
r5_battery_thickness = 3;

r5_battery_mount_hole_dx = 11;
r5_battery_mount_hole_dy =  7;
r5_battery_wing_side     = 10;
r5_battery_wing_center   = 20;
r5_battery_wing_depth    = r5_battery_thickness; // same thickness for back-plate

module rover5_battery_back_wings() {

  module mount_wing(length=10) { wing(length=length, depth=r5_battery_wing_depth); }

  // side
  translate([ r5_battery_mount_hole_dx, 0, 0 ])                  { mount_wing(); }
  // center
  translate([ r5_battery_width / 2,     0, 0 ])                  { mount_wing(20); }
  // side
  translate([ r5_battery_width - r5_battery_mount_hole_dx, 0, 0 ]) { mount_wing(); }
}

module rover5_battery() {
 
  module mount_hole()          { screw_hole(r5_battery_thickness);   }
  module mount_insert()        { screw_insert(r5_battery_thickness); }

  difference() {
    // main battery
    union() {
      // plate
      cube([r5_battery_width, r5_battery_length, r5_battery_thickness]);

      rover5_battery_back_wings();
    }

    // back inserts, centered across spce between wings
    d1 = r5_battery_mount_hole_dx + r5_battery_wing_side / 2;    // right side wing
    d2 = r5_battery_width / 2     - r5_battery_wing_center / 2;  // left center wing
    d = d1 + (d2-d1)/2;                                      // center
    translate([d, 0, 0])                { mount_insert(); }
    translate([r5_battery_width-d, 0, 0]) { mount_insert(); }
  }
}

// rover5_battery();

