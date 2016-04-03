// RANGES:
// [<start>:<end>]
// [<start>:<increment>:<end>]
r1 = [0:1:10];

include<threads.scad>

module bumper(height) {
  rotate([90,0,90]) {
    translate([0, height, 0])
      linear_extrude(height=4) {
        polygon(points=[
            [0,0],
            [-3,1],
            /* [-1,6], */
            [0,6]
        ], height=1);
      }
  }
}

module element(scale) {
  union() {
    cube([4,2,60]);
    bumper(0);
    /* bumper(10); */
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


/*
difference() {
    cube(30, center=true);
    sphere(20);
}
translate([0, 0, 30]) {
    cylinder(h=40, r=10);
}
*/

// 3D OBJECTS
// cube
/* cube([10,20,15], center = true); */

// sphere(r, d) r=radius, d=diameter
/* sphere(r=10); */

// cylinder(h = height, r1 = BottomRadius, r2 = TopRadius, center = true/false);

/* cylinder(h = 50, r1 = 10, r2 = 20, center = true); */
/* cylinder(h=10, r1=10, r2=10, center=true); */
/* cylinder(h=5, r1=50, r2=60, center=true); */
/* sphere(d=40, center=true); */
