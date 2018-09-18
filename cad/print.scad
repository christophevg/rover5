include <general.scad>
include <rover5.scad>

thickness = 3;
printing  = true;

module insert() {
	difference() {
		union() {
			cube([30, 16, thickness]);
		  translate([  7, -thickness/2, 0 ]) { wing(length=10, depth=thickness); }
		  translate([ 23, -thickness/2, 0 ]) { wing(length=10, depth=thickness); }
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

// insert();
hole();
