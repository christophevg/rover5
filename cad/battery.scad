include <general.scad>
include <rover5.scad>
include <back.scad>

r5_battery_width     = r5_body_width;
r5_battery_length    = 56 + 5;
r5_battery_thickness = 3;

r5_battery_mount_hole_dx = 11;
r5_battery_mount_hole_dy =  7;
r5_battery_wing_side     = 10;
r5_battery_wing_center   = 20;
r5_battery_wing_depth    = r5_battery_thickness; // same thickness for back-plate

module mount_hole()          { screw_hole(r5_battery_thickness);   }
module mount_insert(nut_offset=0) {
  screw_insert(r5_battery_thickness, nut_offset=nut_offset);
}
module mount_wing(length=10) { wing(length=length, depth=r5_battery_wing_depth); }

module rover5_battery_back_wings() {
  // side
  translate([ r5_battery_mount_hole_dx, 0, 0 ])                    { mount_wing();   }
  // center
  translate([ r5_battery_width / 2,     0, 0 ])                    { mount_wing(20); }
  // side
  translate([ r5_battery_width - r5_battery_mount_hole_dx, 0, 0 ]) { mount_wing();   }
}

module rover5_battery_support_wings() {
  mount_wing();
  translate([ 18,0,0]) { mount_wing(); }
  translate([-18,0,0]) { mount_wing(); }
}

r5_battery_support_length = r5_battery_length - 10;

module rover5_battery_support() {
  difference() {
    union() {
      cube([r5_battery_support_length, 5, r5_battery_thickness]);
      cube([20, r5_back_battery_mount_height, r5_battery_thickness]);
      translate([20,5,0]) {
        prism(r5_battery_support_length - 20,
              r5_back_battery_mount_height - 5,
              r5_battery_thickness);
      }
    }
    translate([0, r5_back_battery_mount_height/2, 0]) {
      rotate([0, 0, -90]) {
        mount_insert();
      }
    }
  }
  translate([r5_battery_support_length/2, 0, 0]) {
    rover5_battery_support_wings();
  }
}

//rover5_battery_support();

module rover5_battery_t_bolt_inserts(nut_offset=0) {
  d1 = r5_battery_mount_hole_dx + r5_battery_wing_side / 2;    // right side wing
  d2 = r5_battery_width / 2     - r5_battery_wing_center / 2;  // left center wing
  d = d1 + (d2-d1)/2;                                          // center
  translate([d, 0, 0])                  { mount_insert(nut_offset=nut_offset); }
  translate([r5_battery_width-d, 0, 0]) { mount_insert(nut_offset=nut_offset); }
}

module rover5_battery_t_bolt_holes() {
  d1 = r5_battery_mount_hole_dx + r5_battery_wing_side / 2;    // right side wing
  d2 = r5_battery_width / 2     - r5_battery_wing_center / 2;  // left center wing
  d = d1 + (d2-d1)/2;                                          // center
  translate([d, 0, 0])                  { mount_hole(); }
  translate([r5_battery_width-d, 0, 0]) { mount_hole(); }
}

module rover5_battery_border() {
  difference() {
    union() {
      // plate
      cube([r5_battery_width, r5_back_battery_height + 15, r5_battery_thickness]);
      rover5_battery_back_wings();
    }
    // t-bolt inserts
    rover5_battery_t_bolt_inserts();
    // cable guide
    translate([r5_battery_width/2 + 8, r5_back_battery_height, 0]) {
      minkowski() {
        union() {
          rotate([0,0,0]) cube([5,15,r5_battery_thickness]);
          rotate([0,0,90]) cube([5,20,r5_battery_thickness]);
        }
        cylinder(r=1,h=r5_battery_thickness);
      }
    }
  }
}

// rover5_battery_border();

module rover5_battery() {

  difference() {
    // main battery
    union() {
      // plate + wings
      cube([r5_battery_width, r5_battery_length, r5_battery_thickness]);
      rover5_battery_back_wings();
    }

    // back inserts, centered across space between wings
    rover5_battery_t_bolt_inserts(nut_offset=3);
 
    // wing holes for support
    translate([r5_battery_width/2 - r5_battery_thickness/2,
              (r5_battery_length-10)/2,
               0])
    {
      rotate([0,0,90]) {
        rover5_battery_support_wings();
      }
    }
 
     // wing holes for border
    translate([0, r5_battery_length - 5, 0]) {
      rover5_battery_back_wings();
    }
   
    // t-bolt screw holes for border
    translate([0, r5_battery_length - 5 - screw_radius, 0]) { 
      rover5_battery_t_bolt_holes();
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
