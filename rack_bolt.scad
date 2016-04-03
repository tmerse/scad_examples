include<vendor/threads.scad>

metric_thread(3, 0.9, 4, internal=false);
translate([0, 0, 4]) {
  cylinder(h=20, r1=1.8, r2=1.8, center=false, $fn=20);
}
