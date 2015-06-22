include <general.scad>
include <rover5.scad>

rover5_cover_width    = rover5_body_width;
rover5_cover_length   = rover5_body_length;
rover5_cover_thikness = 3;

module rover5_cover() {

  module mount_hole() {
    cylinder(h=rover5_cover_thikness+2, r1=screw_hole, r2=screw_hole);
  }

  difference() {
    // main cover
    cube([rover5_cover_width, rover5_cover_length, rover5_cover_thikness]);

    // mount holes
    translate([11,7,0])                                         { mount_hole(); }
    translate([rover5_cover_width-11,7,0])                      { mount_hole(); }
    translate([11,rover5_cover_length-7,0])                     { mount_hole(); }
    translate([rover5_cover_width-11,rover5_cover_length-7,0])  { mount_hole(); }
  }
}

// rover5_cover();
