Knot_name = "Minimal stick candidate for 8.8";
Knot_number = "23";
Depth = 0;
Paths = [
[
[0.116017,-2.973696,0.706200],
[1.314895,2.809620,-1.675366],
[-2.573863,0.210586,1.506218],
[0.577139,-2.762524,-0.856759],
[1.047856,-2.290208,1.338119],
[-3.381977,2.080160,-0.207050],
[3.014171,1.377483,1.227686],
[0.568644,0.765052,-2.867048],
[0.465606,2.809620,2.026305],
[-1.148322,-2.025967,-1.198253]
]
];
Colours = ["red","green","blue","yellow","pink","purple","white","black"];

module knot_path(path,r) {
    for (i = [0 : 1 : len(path) - 1 ]) {
        hull() {
            translate(path[i]) sphere(r);
            translate(path[(i + 1) % len(path)]) sphere(r);
        }
    }
};

module knot(paths,r) {
   for (p = [0 : 1 : len(paths) - 1])
     color(Colours[p])
        knot_path(paths[p],r);
};

Scale=20;
Radius =0.2;
$fn=20;

echo (Knot_name,Knot_number);
scale(Scale)  knot(Paths,Radius);
