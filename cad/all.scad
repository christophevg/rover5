include <general.scad>
include <rover5.scad>
include <mount.scad>

cover_float = 11;
r5_back_mount_height = 30 + 11;

// chassis
rover5();

// mount = back plate + cover + battery + (battery) border
translate([-r5_cover_width/2, -r5_cover_length/2, r5_body_height + 11]) {
  color("red") { rover5_mount(); }
}

$vpt = [ 41.55, -43.69, 36.02 ];
$vpr = [ 69.70, 0.00, 47.50 ];
$vpd = 604.50;
