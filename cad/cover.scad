include <general.scad>
include <rover5.scad>

rover5_cover_width    = rover5_body_width;
rover5_cover_length   = rover5_body_length;
rover5_cover_thikness = 3;

module rover5_cover() {

  module mount_hole() {
    cylinder(h=rover5_cover_thikness+2, r1=screw_hole, r2=screw_hole);
  }
  
  module screw_insert() {
    cube([screw_hole*2,screw_length,rover5_cover_thikness+2]);
    translate([-nut_hole/2+screw_hole,screw_length/2,0]) {
      cube([nut_hole, screw_hole*2, rover5_cover_thikness+2]);
    }
  }
  
  module wing(size=10) {
    cube([size,rover5_cover_thikness,rover5_cover_thikness]);
  }

  difference() {
    // main cover
    union() {
      // plate
      cube([rover5_cover_width, rover5_cover_length, rover5_cover_thikness]);
      // back mount wings
      translate([ 5,-rover5_cover_thikness,0]) { wing(); }
      translate([rover5_cover_width/2-10, -rover5_cover_thikness,0]) { wing(20); }
      translate([rover5_cover_width-10-5,-rover5_cover_thikness,0]) { wing(); }
    }

    // mount holes
    translate([11,7,0])                                         { mount_hole(); }
    translate([rover5_cover_width-11,7,0])                      { mount_hole(); }
    translate([11,rover5_cover_length-7,0])                     { mount_hole(); }
    translate([rover5_cover_width-11,rover5_cover_length-7,0])  { mount_hole(); }
    
    // back inserts
    translate([23,0,0])                                 { screw_insert(); }
    translate([rover5_cover_width-23-screw_hole*2,0,0]) { screw_insert(); }
  }
}

// rover5_cover();
