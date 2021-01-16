// Triggler Sled for Rubber Band Gun Barrel Module
// 2017 Chris Morrison


difference() {
translate ([0, 0.1, 0]) {cube ([120, 13, 5]);}  //main body
translate ([0, 4, 0]) rotate ([0, 0, 45]) {cube ([20, 20, 7]); } //Front wedge shape
translate ([10, 6.5, -1]) {cube ([120, 5, 7]); }  //Inner void

notch ();
translate ([5*1, 0, 0]) notch();
translate ([5*2, 0, 0]) notch();
translate ([5*3, 0, 0]) notch();
translate ([5*4, 0, 0]) notch();
translate ([5*5, 0, 0]) notch();
translate ([5*6, 0, 0]) notch();
translate ([5*7, 0, 0]) notch();
translate ([5*8, 0, 0]) notch();
translate ([5*9, 0, 0]) notch();
translate ([5*10, 0, 0]) notch();
translate ([5*11, 0, 0]) notch();
translate ([5*12, 0, 0]) notch();
translate ([5*13, 0, 0]) notch();
translate ([5*14, 0, 0]) notch();
translate ([5*15, 0, 0]) notch();
translate ([5*16, 0, 0]) notch();
translate ([5*17, 0, 0]) notch();
translate ([5*18, 0, 0]) notch();
translate ([5*19, 0, 0]) notch();
translate ([5*20, 0, 0]) notch();
translate ([5*21, 0, 0]) notch();
translate ([5*22, 0, 0]) notch();
}

module notch() {  //Use this module for Trigger Sled, Sub Frame, and Trigger
translate ([0, 0, 0]) {
translate ([7, -5, -1]) rotate([0,0,18]){  //Rotate the entire notch
difference() {
translate ([0, 0, 0]) {cube ([5, 10, 7]); }  //main vertical
translate ([0, 10, -1]) rotate ([0, 0, -55]) {cube ([9, 9, 9]); }  //back bevel
translate ([-2, 10, -1]) rotate ([0, 0, -18]) {cube ([5, 3, 9]); }  //trim top level
}
}
}
}