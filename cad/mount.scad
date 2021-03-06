include <general.scad>
include <rover5.scad>
include <cover.scad>
include <back.scad>
include <battery.scad>

module rover5_mount() {
 
  rover5_cover();

  translate([0,0,-r5_back_mount_height]) {
    rotate([90,0,0]) {
      rover5_back();
    }
  }
  
  translate([0, -r5_battery_wing_depth, -r5_back_battery_height]) {
    mirror([0,1,0]) {
      rover5_battery_mount();
    }
  }
}

//$vpt = [ 27.06, 37.84, -1.37 ];
//$vpr = [ 85.80, 0.00, 62.80 ];
//$vpd = 458.04;
//rover5_mount();
