// general
$fn=25;

// screw size
screw_diameter = 3;
screw_radius   = screw_diameter / 2;
screw_length   = 15;

// nut size
nut_diameter   = 8;
// from one flat side to the other
//    ___
//   /   \
//  |<-d->|
//   \___/
nut_radius     = nut_diameter / 2;
nut_height     = 3; 

module screw_hole(depth) {
  cylinder(h=depth, r=screw_radius);
}

// screw_hole();

module screw_insert(depth=3) {
  translate([0, screw_length/2, depth/2]) { 
    cube([screw_diameter, screw_length, depth], true);
    cube([  nut_diameter,   nut_height, depth], true);
  }
}

// screw_insert();

module wing(length=10, depth=3)  {
  translate([-length/2, -depth, 0]) { cube([length, depth, depth]); }
}

// wing();
