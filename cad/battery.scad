include <general.scad>
include <rover5.scad>
include <back.scad>

r5_battery_width     = r5_body_width;
r5_battery_length    = 56 + 5 + 15;
r5_battery_thickness = 3;

r5_battery_mount_hole_dx = 11;
r5_battery_mount_hole_dy =  7;
r5_battery_wing_side     = 10;
r5_battery_wing_center   = 20;
r5_battery_wing_depth    = r5_battery_thickness; // same thickness for back-plate

module mount_hole(print=false, tolerance=default_tolerance) {
	screw_hole(depth=r5_battery_thickness, print=print, tolerance=tolerance);
}

module mount_insert(nut_offset=0, print=false, tolerance=default_tolerance) {
  tbolt(r5_battery_thickness, nut_offset=nut_offset, print=print, tolerance=tolerance);
}

module mount_wing(length=10, print=false, tolerance=default_tolerance) {
	wing(length=length, depth=r5_battery_wing_depth, print=print, tolerance=tolerance);
}

module rover5_battery_back_wings(print=false, tolerance=default_tolerance) {
  // side
  translate([ r5_battery_mount_hole_dx, 0, 0 ])                    { mount_wing(print=print, tolerance=tolerance);   }
  // center
  translate([ r5_battery_width / 2,     0, 0 ])                    { mount_wing(20, print=print, tolerance=tolerance); }
  // side
  translate([ r5_battery_width - r5_battery_mount_hole_dx, 0, 0 ]) { mount_wing(print=print, tolerance=tolerance);   }
}

module rover5_battery_support_wings(print=false, tolerance=default_tolerance) {
  mount_wing(print=print, tolerance=tolerance);
  translate([ 18,0,0]) { mount_wing(print=print, tolerance=tolerance); }
  translate([-18,0,0]) { mount_wing(print=print, tolerance=tolerance); }
}

r5_battery_support_length = r5_battery_length - 10;

module rover5_battery_support(print=false, tolerance=default_tolerance) {
  more = more(print, tolerance) * 2;
  difference() {
    union() {
      cube([r5_battery_support_length, 5, r5_battery_thickness]);
      cube([20, r5_back_battery_mount_height-more, r5_battery_thickness]);
      translate([20,5,0]) {
        prism(r5_battery_support_length - 20,
              r5_back_battery_mount_height - 5 - more,
              r5_battery_thickness);
      }
    }
    translate([0, r5_back_battery_mount_height/2-more, 0]) {
      rotate([0, 0, -90]) {
        mount_insert(print=print, tolerance=tolerance);
      }
    }
  }
  translate([r5_battery_support_length/2, -thickness/2, 0]) {
    rover5_battery_support_wings();
  }
}

//rover5_battery_support();

module rover5_battery_t_bolt_inserts(nut_offset=0, print=false, tolerance=default_tolerance) {
  d1 = r5_battery_mount_hole_dx + r5_battery_wing_side / 2;  // right side wing
  d2 = r5_battery_width / 2     - r5_battery_wing_center / 2;// left center wing
  d = d1 + (d2-d1)/2;                                        // center
  translate([d, 0, 0])                  { mount_insert(nut_offset=nut_offset, print=print, tolerance=tolerance); }
  translate([r5_battery_width-d, 0, 0]) { mount_insert(nut_offset=nut_offset, print=print, tolerance=tolerance); }
}

module rover5_battery_t_bolt_holes(print=false, tolerance=default_tolerance) {
  d1 = r5_battery_mount_hole_dx + r5_battery_wing_side / 2;  // right side wing
  d2 = r5_battery_width / 2     - r5_battery_wing_center / 2;// left center wing
  d = d1 + (d2-d1)/2;                                        // center
  translate([d, 0, 0])                  { mount_hole(print=print, tolerance=tolerance); }
  translate([r5_battery_width-d, 0, 0]) { mount_hole(print=print, tolerance=tolerance); }
}

r5_battery_border_height = r5_back_height - r5_back_battery_height + 15;

module rover5_battery_border(print=false, tolerance=default_tolerance) {
	more = more(print, tolerance);
  difference() {
    union() {
      // plate
      cube([r5_battery_width, r5_battery_border_height, r5_battery_thickness]);
      translate([0, -thickness/2, 0]) { rover5_battery_back_wings(); }
    }
    // t-bolt inserts
    rover5_battery_t_bolt_inserts(print=print, tolerance=tolerance);
    // cable guide
    translate([r5_battery_width/2 + 8, r5_battery_border_height - 15, 0]) {
      minkowski() {
        union() {
          rotate([0, 0, 0]) cube([5+more, 15+more, r5_battery_thickness]);
          rotate([0, 0,90]) cube([5+more, 20+more, r5_battery_thickness]);
        }
        cylinder(r=1,h=r5_battery_thickness);
      }
    }
  }
}

// rover5_battery_border();

module rover5_battery(print=false, tolerance=default_tolerance) {

	more = more(print, tolerance);

	difference() {
    // main battery
    union() {
      // plate + wings
      cube([r5_battery_width, r5_battery_length, r5_battery_thickness]);
      translate([0, -thickness/2, 0]) { rover5_battery_back_wings(); }
    }

    // back inserts, centered across space between wings
    rover5_battery_t_bolt_inserts(nut_offset=3, print=print, tolerance=tolerance);
 
    // wing holes for support
    translate([r5_battery_width/2, r5_battery_support_length/2, 0])
    {
      rotate([0, 0, 90]) {
        rover5_battery_support_wings(print=print, tolerance=tolerance);
      }
    }
 
     // wing and tbolts holes for border
    translate([0, r5_battery_length - thickness/2 - 5, 0]) {
	    rover5_battery_back_wings(print=print, tolerance=tolerance);
	    rover5_battery_t_bolt_holes(print=print, tolerance=tolerance);
    }
   
  }
}

//rover5_battery();

module rover5_battery_mount() {
  rover5_battery();
  translate([r5_battery_thickness/2 + r5_battery_width/2,0,0]) {
    rotate([-90,0,90]) {
      rover5_battery_support();
    }
  }

  translate([0, r5_battery_length - 5, r5_battery_wing_depth]) {
    rotate([ 90,0,0 ]) {
      rover5_battery_border();
    }
  }
}

//$vpt = [ 44.49, 34.94, 13.30 ];
//$vpr = [ 77.70, 0.00, 36.40 ];
//$vpd = 275.27;
//rover5_battery_mount();
