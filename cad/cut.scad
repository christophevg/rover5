include <cover.scad>
include <back.scad>
include <battery.scad>

cover_float = 11;                   // spacing between cover and chassis
r5_back_mount_height = 30 + 11;     // position on back where cover is mounted

projection(cut = true) {
  translate([0, 3, 0]) {
    difference() {
      rover5_cover();
      // custom servo hole
      servo_width      =  44;
      servo_length     = 110;
      servo_from_front =  15.5;
      translate([(r5_cover_width-servo_width)/2,
                  r5_cover_length - servo_length - servo_from_front,
                  0])
      {
        cube([servo_width, servo_length, r5_cover_thickness]);
      }
    }
  }
  translate([r5_body_width +10, 120, 0]) { rover5_back(); }
  translate([r5_body_width +10, 110, 0]) { mirror([0,1,0]) { rover5_battery(); }}
  translate([r5_body_width +10,  40, 0]) { mirror([0,1,0]) { rover5_battery_border();}}

  translate([r5_cover_width/2+5,r5_cover_length/2-5,0]) {
    rotate([0, 0, 90]) {
      rover5_battery_support();
    }
  }
}

$vpt = [ 95.74, 95.75, -0.00 ];
$vpr = [ 0.00, 0.00, 0.00 ];
$vpd = 585.69;
