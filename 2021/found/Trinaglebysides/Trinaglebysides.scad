//pub
polygon(TrinagleBySides(rands(5, 30, 1)[
  0], rands(5, 30, 1)[0], rands(5,
  30, 1)[0]));

function TrinagleBySides(A, B, C) =
isValidTriangle(A, B, C) ? [
 [0, 0], [A, 0], CCintersection(A, B, C)
  ] : [];

function isValidTriangle(a, b, c) = (a >
  max(b, c)) ? (a < b + c) : (b > max(a,
  c)) ? (b < a + c) : /*else*/ (c < a +
  b);

function CCintersection(A, r0, r1) =
let (p0 = [0, 0], p1 = [A, 0], d = norm(
  p1 - p0), a = (r0 * r0 - r1 * r1 +
  d * d) / (2 * d), h = sqrt(r0 * r0 -
  a * a), p2 = [p0.x + a *
  (p1.x - p0.x) / d, p0.y + a * (p1.y -
    p0.y) / d], p3 = [p2.x + h *
  (p1.y - p0.y) / d, p2.y + h * (p1.x -
    p0.x) / d])
p3;