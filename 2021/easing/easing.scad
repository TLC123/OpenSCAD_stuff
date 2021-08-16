PI = acos(-1.);
function easeInSine(x) = 1. - cos((x * PI) / 2.);
function easeInSineVec2(uv) = uv.y - easeInSine(uv.x);
function easeOutSine(x) = sin((x * PI) / 2.);
function easeOutSineVec2(uv) = uv.y - easeOutSine(uv.x);
function easeInOutSine(x) = -(cos(PI * x) - 1.) / 2.;
function easeInOutSineVec2(uv) = uv.y - easeInOutSine(uv.x);
function easeInCubic(x) = x * x * x;
function easeInCubicVec2(uv) = uv.y - easeInCubic(uv.x);
function easeOutCubic(x) = 1. - pow(1. - x, 3.);
function easeOutCubicVec2(uv) = uv.y - easeOutCubic(uv.x);
function easeInOutCubic(x) = x < .5 ? 4. * x * x * x : 1. - pow(-2. * x + 2., 3.) / 2.;
function easeInOutCubicVec2(uv) = uv.y - easeInOutCubic(uv.x);
function easeInQuint(x) = x * x * x * x * x;
function easeInQuintVec2(uv) = uv.y - easeInQuint(uv.x);
function easeOutQuint(x) = 1. - pow(1. - x, 5.);
function easeOutQuintVec2(uv) = uv.y - easeOutQuint(uv.x);
function easeInOutQuint(x) = x < .5 ? 16. * x * x * x * x * x : 1. - pow(-2. * x + 2., 5.) / 2.;
function easeInOutQuintVec2(uv) = uv.y - easeInOutQuint(uv.x);
function easeInCirc(x) = 1. - sqrt(abs(1. - pow(x, 2.)));
function easeInCircVec2(uv) = uv.y - easeInCirc(uv.x);
function easeOutCirc(x) = sqrt(abs(1. - pow(x - 1., 2.)));
function easeOutCircVec2(uv) = uv.y - easeOutCirc(uv.x);
function easeInOutCirc(x) = x < .5 ? (1. - sqrt(1. - pow(2. * x, 2.))) / 2. : (sqrt(1. - pow(-2. * x + 2., 2.)) + 1.) / 2.;
function easeInOutCircVec2(uv) = uv.y - easeInOutCirc(uv.x);
function easeInElastic(x) =
let (c4 = (2. * PI) / 3.)
x == 0. ? 0. : x == 1. ? 1. : -pow(2., 10. * x - 10.) * sin((x * 10. - 10.75) * c4);
function easeInElasticVec2(uv) = uv.y - easeInElastic(uv.x);
function easeOutElastic(x) =
let (c4 = (2. * PI) / 3.)
x == 0. ? 0. : x == 1. ? 1. : pow(2., -10. * x) * sin((x * 10. - .75) * c4) + 1.;
function easeOutElasticVec2(uv) = uv.y - easeOutElastic(uv.x);
function easeInOutElastic(x) =
let (c5 = (2. * PI) / 4.5)
x == 0. ? 0. : x == 1. ? 1. : x < .5 ? -(pow(2., 20. * x - 10.) * sin((20. * x - 11.125) * c5)) / 2. : (pow(2., -20. * x + 10.) * sin((20. * x - 11.125) * c5)) / 2. + 1.;
function easeInOutElasticVec2(uv) = uv.y - easeInOutElastic(uv.x);
function easeInQuad(x) = x * x;
function easeInQuadVec2(uv) = uv.y - easeInQuad(uv.x);
function easeOutQuad(x) = 1. - (1. - x) * (1. - x);
function easeOutQuadVec2(uv) = uv.y - easeOutQuad(uv.x);
function easeInOutQuad(x) = x < .5 ? 2. * x * x : 1. - pow(-2. * x + 2., 2.) / 2.;
function easeInOutQuadVec2(uv) = uv.y - easeInOutQuad(uv.x);
function easeInQuart(x) = x * x * x * x;
function easeInQuartVec2(uv) = uv.y - easeInQuart(uv.x);
function easeOutQuart(x) = 1. - pow(1. - x, 4.);
function easeOutQuartVec2(uv) = uv.y - easeOutQuart(uv.x);
function easeInOutQuart(x) = x < .5 ? 8. * x * x * x * x : 1. - pow(-2. * x + 2., 4.) / 2.;
function easeInOutQuartVec2(uv) = uv.y - easeInOutQuart(uv.x);
function easeInExpo(x) = x == 0. ? 0. : pow(2., 10. * x - 10.);
function easeInExpoVec2(uv) = uv.y - easeInExpo(uv.x);
function easeOutExpo(x) = x == 1. ? 1. : 1. - pow(2., -10. * x);
function easeOutExpoVec2(uv) = uv.y - easeOutExpo(uv.x);
function easeInOutExpo(x) = x == 0. ? 0. : x == 1. ? 1. : x < .5 ? pow(2., 20. * x - 10.) / 2. : (2. - pow(2., -20. * x + 10.)) / 2.;
function easeInOutExpoVec2(uv) = uv.y - easeInOutExpo(uv.x);
function easeInBack(x) =
let (c1 = 1.70158)
let (c3 = c1 + 1.)
c3 * x * x * x - c1 * x * x;
function easeInBackVec2(uv) = uv.y - easeInBack(uv.x);
function easeOutBack(x) =
let (c1 = 1.70158)
let (c3 = c1 + 1.)
1. + c3 * pow(x - 1., 3.) + c1 * pow(x - 1., 2.);
function easeOutBackVec2(uv) = uv.y - easeOutBack(uv.x);
function easeInOutBack(x) =
let (c1 = 1.70158)
let (c2 = c1 * 1.525)
x < .5 ? (pow(2. * x, 2.) * ((c2 + 1.) * 2. * x - c2)) / 2. : (pow(2. * x - 2., 2.) * ((c2 + 1.) * (x * 2. - 2.) + c2) + 2.) / 2.;
function easeInOutBackVec2(uv) = uv.y - easeInOutBack(uv.x);
function easeOutBounce(x) =
let (n1 = 7.5625)
let (d1 = 2.75)
(x < 1. / d1) ? n1 * x * x: (x < 2. / d1) ? 
    let (x = x - 1.5 / d1) n1 * (x) * x + 0.75 : (x < 2.5 / d1) ?
    let (x = x - 2.25 / d1) n1 * (x) * x + 0.9375 : let (x = x - 2.625 / d1) n1 * (x) * x + 0.984375;
function easeOutBounceVec2(uv) = uv.y - easeOutBounce(uv.x);
function easeInBounce(x) = 1. - easeOutBounce(1. - x);
function easeInBounceVec2(uv) = uv.y - easeInBounce(uv.x);
function easeInOutBounce(x) = x < .5 ? (1. - easeOutBounce(1. - 2. * x)) / 2. : (1. + easeOutBounce(2. * x - 1.)) / 2.;
function easeInOutBounceVec2(uv) = uv.y - easeInOutBounce(uv.x);