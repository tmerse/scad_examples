include<vendor/threads.scad>

module bumper(height) {
  rotate([90,0,90]) {
    translate([0, height, 0])
      linear_extrude(height=4) {
        polygon(points=[
            [0,0],
            [-3,1],
            [0,6]
        ], height=1);
      }
  }
}

module element(scale) {
  union() {
    cube([4,2,60]);
    bumper(0);
  }
}

module extended_bumper(height) {
  // TODO: diff of union doesn't work
  union() {
    difference() {
      bumper(height);
      bumper_thread_inner(height);
    }
    difference() {
      translate([0, 0, height]) {
        cube([4, 2, 6]);
      }
      bumper_thread_inner(height);
    }
  }
}

/* for (i = [0:4]) { */
for (i = [0:2]) {
  translate([0, 0, i * 12 + 6]) {
    difference() {
      cube([4, 2, 6]);
      thread_inner();
    }
  }
  extended_bumper(i * 12);
}

/* metric_thread (diameter, pitch, length) */
module bumper_thread_inner(height) {
  translate([2, 1, height + 1.5]) {
  rotate([65,0,0])
    metric_thread(3, 0.9, 4, internal=true);
  }
}

module thread_inner() {
  translate([2, 2, 2]) {
    rotate([90, 0, 0]) {
      scale(0.1) {
        metric_thread(
            length=30,
            center=false
        );
      }
    }
  }
}

//metric_thread(3, 0.9, 4, internal=false);
//translate([0, 0, 4]) {
//  cylinder(h=20, r1=1.8, r2=1.8, center=false, $fn=20);
//}
