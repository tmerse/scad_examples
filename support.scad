// 5 cm <--->
// 15 cm |
// 156 cm <---->

module ground(height) {
  linear_extrude(height= height) {
    polygon(points=[
        [0,0],
        [13,0],
        [11,18],
        [2,18]
    ], height=1);
  }
}

module nut(height) {
  translate([0, 0, -1]) {
    linear_extrude(height=height+2) {
      polygon(points=[
          [3.9,13],
          [9.1,13],
          [9.1,19],
          [3.9,19]
      ], height=1);
    }
  }
}

module jack(width) {
  // width will become height in child components
  // due to transformation rules
  rotate([90, 0, 90]) {
    difference() {
      ground(width);
      nut(width);
    }
  }
}

jack(30);
