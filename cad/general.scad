// general
$fn = 250;

default_tolerance = 0.30;

thickness = 3;

function more(print=false, tolerance=default_tolerance) = print ? 2*tolerance : 0;

// additional shapes

module prism(w, l, h) {
  linear_extrude(height = h) {
    polygon(points = [ [0, 0], [w, 0], [0, l] ], paths= [ [0, 1, 2, 0] ] );
  }
}

// prism(25, 10, 3);

// screw size
screw_diameter = 3.1;
screw_radius   = screw_diameter / 2;
screw_length   = 16 - 2;

// nut size
nut_diameter   = 6.4;
nut_radius     = nut_diameter / 2;
nut_height     = 3; 

module screw_hole(depth=thickness, print=false, tolerance=default_tolerance) {
	more = more(print, tolerance/2);
  cylinder(h=depth, r=screw_radius+more);
}

// screw_hole();

module tbolt(depth=thickness,nut_offset=0,print=false, tolerance=default_tolerance) {
	more = more(print, tolerance);
	sl = screw_length + more;
	sd = screw_diameter + more;
	nd = nut_diameter + more;
	nh = nut_height + more;
  translate([0, sl/2-0.01, depth/2]) { 
    cube([sd, sl, depth], true);
    translate([0, sl/2 - sl/3 - nut_offset, 0]) {
      cube([nd, nh, depth], true);
    }
  }
}

// tbolt();

module wing(length=10, depth=thickness, print=false, tolerance=default_tolerance)  {
	more = more(print, tolerance);
	d = depth + more;
	l = length + more;
  translate([-l/2, -d/2, 0]) {
		cube([l, d, depth]);
	}
}

// wing();
