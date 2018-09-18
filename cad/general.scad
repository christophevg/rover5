// general
$fn = 25;

print_extra = 0.20;

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
screw_length   = 16 - 3;

// nut size
nut_diameter   = 6.4;
nut_radius     = nut_diameter / 2;
nut_height     = 3; 

module screw_hole(depth=3, print=false) {
  cylinder(h=depth, r=screw_radius+print_extra);
}

// screw_hole();

module tbolt(depth=3,nut_offset=0,print=false) {
	more = print ? 2*print_extra : 0;
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

module wing(length=10, depth=3, print=false)  {
	more = print ? 2*print_extra : 0;
	d = depth + more;
	l = length + more;
  translate([-l/2, -d/2, 0]) {
		cube([l, d, depth]);
	}
}

// wing();
