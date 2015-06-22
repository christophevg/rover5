include <general.scad>
include <rover5.scad>
include <cover.scad>

// chassis
rover5();

// cover
translate([-rover5_cover_width/2,-rover5_cover_length/2,rover5_body_height]) {
  color("red") { rover5_cover(); }
}
