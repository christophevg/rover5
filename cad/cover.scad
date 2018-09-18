include <general.scad>
include <rover5.scad>

r5_cover_width     = r5_body_width;
r5_cover_length    = r5_body_length;
r5_cover_thickness = 3;

r5_cover_mount_hole_dx = 11;
r5_cover_mount_hole_dy =  7;
r5_cover_wing_side     = 10;
r5_cover_wing_center   = 20;
r5_cover_wing_depth    = r5_cover_thickness; // same thickness for back-plate

module rover5_cover_back_wings() {

  module mount_wing(length=10) { wing(length=length, depth=r5_cover_wing_depth); }

  // side
  translate([ r5_cover_mount_hole_dx, 0, 0 ])                  { mount_wing(); }
  // center
  translate([ r5_cover_width / 2,     0, 0 ])                  { mount_wing(20); }
  // side
  translate([ r5_cover_width - r5_cover_mount_hole_dx, 0, 0 ]) { mount_wing(); }
}

module rover5_cover(with_tbolts=true, with_back_holes=true) {
 
  module mount_hole()          { screw_hole(r5_cover_thickness);   }
  module mount_insert()        { tbolt(r5_cover_thickness); }

  difference() {
    // main cover
    union() {
      // plate
      cube([r5_cover_width, r5_cover_length, r5_cover_thickness]);

      rover5_cover_back_wings();
    }

    // mount holes
    if(with_back_holes) {
        // bottom-left
        translate([ r5_cover_mount_hole_dx,
                    r5_cover_mount_hole_dy,
                    0 ])
        {
          mount_hole();
        }
        // bottom-right
        translate([ r5_cover_width - r5_cover_mount_hole_dx,
                    r5_cover_mount_hole_dy,
                    0 ])
        {
        mount_hole();
        }
    }
    // top-left
    translate([ r5_cover_mount_hole_dx,
                r5_cover_length - r5_cover_mount_hole_dy,
                0 ])
    {
      mount_hole();
    }
    // top-right
    translate([ r5_cover_width - r5_cover_mount_hole_dx,
                r5_cover_length - r5_cover_mount_hole_dy,
                0 ])
    {
      mount_hole();
    }
    
    if(with_tbolts) {
        // back inserts, centered across spce between wings
        d1 = r5_cover_mount_hole_dx + r5_cover_wing_side / 2;    // right side wing
        d2 = r5_cover_width / 2     - r5_cover_wing_center / 2;  // left center wing
        d = d1 + (d2-d1)/2;                                      // center
        translate([d, 0, 0])                { mount_insert(); }
        translate([r5_cover_width-d, 0, 0]) { mount_insert(); }
    }
  }
}

// rover5_cover();
