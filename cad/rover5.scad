// the Rover 5 Robot Platform

r5_body_width  =  89;
r5_body_length = 168;
r5_body_height =  49;

module rover5() {
  // body
  difference() {
    union() {
        translate([-r5_body_width/2,-r5_body_length/2]) {
            cube([r5_body_width,r5_body_length,r5_body_height]);
        }
        translate([r5_body_width/2, 45,13]) {
            rotate([0,90,0]) { cylinder(h=8, r1=30, r2=22); }
        }

        translate([r5_body_width/2, -45,13]) {
            rotate([0,90,0]) {
                cylinder(h=8, r1=30, r2=22); 
                translate([0,0,8]) { cylinder(h=5, r=15); }
            }
        }

        translate([-r5_body_width/2, 45,13]) {
            rotate([0,-90,0]) {
                cylinder(h=8, r1=30, r2=22);
                translate([0,0,8]) { cylinder(h=5, r=15); }
            }
        }

        translate([-r5_body_width/2, -45,13]) {
            rotate([0,-90,0]) {
                cylinder(h=8, r1=30, r2=22);
                translate([0,0,8]) { cylinder(h=5, r=15); }
            }
        }
    }
    translate([-106/2,-r5_body_length/2,-r5_body_height])    { cube([106,r5_body_length,r5_body_height]); }
    translate([-109/2,-r5_body_length/2,-22]) { rotate([45,0,0]) { cube([109,30,30]); } }
    translate([-109/2, r5_body_length/2,-22]) { rotate([45,0,0]) { cube([109,30,30]); } }
  }

  module arm(i=0, o="right", wh=36, wr=30) {

    module inner_arm(uj_y, f, ll_y) {
      translate([0,0,-25]) {
        rotate([0,0,i]) {
          cylinder(h=38, r=15);                                 // motor
          translate([0,0,38]) {
            cylinder(h=20, r=17);                               // upper joint
            translate([-17,uj_y,0]) { cube([34,30,20]); }       // upper leg
            translate([2.5,58*f,0]) {
              rotate([0,0,-5*f]) {
                cylinder(h=35, r=17);                           // lower joint
                translate([-17,ll_y,0]) { cube([34,30,20]); }   // lower leg
                translate([0,0,36]) {
                  cylinder(h=20, r=2);                          // ax
                  translate([0,0,-(wh-20)]) {
                    cylinder(h=wh, r=wr);                       // wheel
                  }
                }
              }
            }
          }
        }
      }
    }
    
    if(o=="right") {
      inner_arm(0, 1, -30) { children(); }
    } else {
      inner_arm(-30, -1, 0) { children(); }
    }
  }

  // arms
  translate([ r5_body_width/2,  45, 13]) { rotate([  0,90,0]) { arm(-10 ); } }
  translate([-r5_body_width/2, -45, 13]) { rotate([180,90,0]) { arm(-10); } }
  translate([ r5_body_width/2, -45, 13]) { rotate([  0,90,0]) { arm( 10, o="left"); } }
  translate([-r5_body_width/2,  45, 13]) { rotate([180,90,0]) { arm( 10, o="left"); } }
}

// rover5();
