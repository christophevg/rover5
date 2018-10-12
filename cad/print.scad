include <general.scad>
include <rover5.scad>
include <cover.scad>
include <back.scad>
include <battery.scad>

printing = true;

module insert() {
	difference() {
		union() {
			cube([30, 16, thickness]);
		  translate([  7, -thickness/2, 0 ]) { wing(); }
		  translate([ 23, -thickness/2, 0 ]) { wing(); }
		}
		translate([15, 0, 0]) { tbolt(print=printing); }
	}
}

module hole() {
	difference() {
		cube([30, 8, thickness]);
		translate([7,  4, 0]) { wing(print=printing); }
		translate([15, 4, 0]) { screw_hole(print=printing); }
		translate([23, 4, 0]) { wing(print=printing); }
	}
}

module test() {
	hole();
	translate([0, 13, 0]) { insert(); }
}

// test();

module cover() {
  module servo_mount_hole() {
    w = 4.5;
    l = w;
    translate([0, l/2, 0])     { cylinder(h=thickness, r=w/2); }
    translate([-w/2, -l/2, 0]) { cube([w, l, thickness]); }
    translate([0, -l/2, 0])    { cylinder(h=thickness, r=w/2); }
  }
	difference() {
	  rover5_cover(false, false, print=printing);
	  // custom servo hole
	  servo_width      =  44;
	  servo_length     = 110;
	  servo_from_front =  12.5;
	  translate([(r5_cover_width-servo_width)/2,
	              r5_cover_length - servo_length - servo_from_front,
	              0])
	  {
	    cube([servo_width, servo_length, r5_cover_thickness]);
	  }
    // holes for mounting servo
    servo_mount_from_center = (r5_cover_width - servo_width)/2 + 7;
    translate([r5_cover_width/2-servo_mount_from_center, r5_cover_length-23, 0]) {
      servo_mount_hole();
      translate([0, -40, 0]) { servo_mount_hole(); }
      translate([0, -80, 0]) { servo_mount_hole(); }
    }
    translate([r5_cover_width/2+servo_mount_from_center, r5_cover_length-23, 0]) {
      servo_mount_hole();
      translate([0, -40, 0]) { servo_mount_hole(); }
      translate([0, -80, 0]) { servo_mount_hole(); }
    }
	}
}

// cover();

// rover5_back(print=printing);

// rover5_battery(print=printing);

// rover5_battery_border(print=printing);

// rover5_battery_support(print=printing);
