include <cover.scad>
include <back.scad>
include <battery.scad>

cover_float = 11;                   // spacing between cover and chassis
r5_back_mount_height = 30 + 11;     // position on back where cover is mounted

projection(cut = true) {
  rover5_cover();
  translate([100,100,0]) { rover5_back(); }
  translate([100, 70,0]) { mirror([0,1,0]) { rover5_battery(); } }
}

$vpt = [ 97.72, 83.47, 0.00 ];
$vpr = [ 0.00, 0.00, 0.00 ];
$vpd = 545.96;
