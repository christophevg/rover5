// general
$fn=25;

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

module screw_hole(depth) {
  cylinder(h=depth, r=screw_radius);
}

// screw_hole();

module screw_insert(depth=3,nut_offset=0) {
  translate([0, screw_length/2, depth/2]) { 
    cube([screw_diameter, screw_length, depth], true);
    translate([0, screw_length/2 - screw_length/3 - nut_offset, 0]) {
      cube([  nut_diameter,   nut_height, depth], true);
    }
  }
}

// screw_insert();

module wing(length=10, depth=3)  {
  translate([-length/2, -depth, 0]) { cube([length, depth, depth]); }
}

// wing();
