include <general.scad>
include <rover5.scad>
include <cover.scad>

r5_back_width                = r5_body_width;
r5_back_height               = 120 - 63 + 15;    // max - top rover (TODO: extract)
r5_back_thickness            = r5_cover_thickness;
r5_back_mount_height         = 30 + 11 + 1.5;
r5_back_battery_height       = 25;
r5_back_battery_mount_height = r5_back_mount_height - r5_back_battery_height;

module rover5_back(print=false, tolerance=default_tolerance) {
	more = more(print, tolerance);
 
  module mount_hole() { screw_hole(depth=r5_cover_thickness, print=print, tolerance=tolerance);   }

  module holes_and_wings() {
    // back inserts, centered across space between wings
    d1 = r5_cover_mount_hole_dx + r5_cover_wing_side / 2;    // right side wing
    d2 = r5_cover_width / 2     - r5_cover_wing_center / 2;  // left center wing
    d = d1 + (d2-d1)/2;                                      // center

    // mount holes for screw insets
    translate([d, 0, 0])                  { mount_hole(); }
    translate([r5_cover_width - d, 0, 0]) { mount_hole(); }

    // wing insets
    rover5_cover_back_wings(print=print, tolerance=tolerance);
  }

	module hook_hole() {
		more = more(print, tolerance/2);
    cylinder(h=r5_cover_thickness, r=(4.1/2)+more);
	}

	more = more(print, tolerance);

  difference() {
    cube([r5_back_width, r5_back_height + 15, r5_back_thickness]);

    // holes + wing insets for cover plate
    translate([0, r5_back_mount_height, 0]) {
      holes_and_wings();
    }

    // holes + wing insets for battery plate
    translate([0, r5_back_battery_mount_height, 0]) {
      holes_and_wings();
    }
    
    // hole for battery support
    translate([r5_back_width / 2, r5_back_battery_mount_height / 2, 0]) {
      mount_hole();
    }
    
    // holes for withdrawl hooks (4mm)
    translate([r5_back_width / 4, r5_back_battery_mount_height / 2, 0]) {
			hook_hole();
    }
    translate([r5_back_width / 4 * 3, r5_back_battery_mount_height / 2, 0]) {
			hook_hole();
    }

    // cable guide
    translate([r5_back_width/2 + 8, r5_back_height + 15 - 15, 0]) {
      minkowski() {
        union() {
          rotate([0, 0,  0]) cube([5+more, 15+more, r5_back_thickness]);
          rotate([0, 0, 90]) cube([5+more, 20+more, r5_back_thickness]);
        }
        cylinder(r=1, h=r5_back_thickness);
      }
    }

  }
}

//$vpt = [ 44.24, 39.22, 0.00 ];
//$vpr = [ 0.00, 0.00, 0.00 ];
//$vpd = 255.69;
//rover5_back();
