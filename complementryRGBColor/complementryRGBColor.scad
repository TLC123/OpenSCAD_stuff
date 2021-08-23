
for(i=[0:360/20:180]){
c=rands(0,1,3,i);
rotate(i,[0,.1,1])
 {
  color(c)render()translate([5,5])square(10);
  color(complementryRGBColor(c))render()translate([13,13])square(10);
}
echo(c,complementryRGBColor(c));
}
function complementryRGBColor(c) =
let (r = c[0], g = c[1], b = c[2])
(max(r, g, b) == min(r, g, b)) ? 
  [1 - r, 1 - g, 1 - b] : 
let (mx = max(r, g, b),
     mn = min(r, g, b), 
     h = (mx + mn) / 2, 
     s = (mx + mn) / 2, 
     l = (mx + mn) / 2, 
     d = mx - mn)
let (s = l > 0.5 ? d / (2 - mx - mn) : d / (mx + mn), 
     h = mx == r ? (g - b) / d + (g < b ? 6 : 0) : 
     mx == g ? (b - r) / d + 2 :
    /*mx== b?*/     (r - g) / d + 4)
let (h = round((h * 60) + 180) % 360)
let (h = h / 360)
let (hue2rgb = function(p, q, t) 
     let (t = t - floor(t))
     (t < 1 / 6) ? p + (q - p) * 6 * t : 
     (t < 1 / 2) ? q : 
     (t < 2 / 3) ? p + (q - p) * (2 / 3 - t) * 6 : 
     p)
let (q = l < 0.5 ?  l * (1 + s) :  l + s - l * s)
let (p = 2 * l - q)
let (r = hue2rgb(p, q, h + 1 / 3))
let (g = hue2rgb(p, q, h))
let (b = hue2rgb(p, q, h - 1 / 3))[r, g, b];