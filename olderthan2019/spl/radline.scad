
function v2rad(v, r = 0.3) =let ( L = len(v) - 1)[  
 for (i = [0:0.5: L - 0.5]) 
let ( 
next = min(L, floor(i) + 1),
prev = max(0, floor(i) - 1)
)
floor(i)!=i?
[v[i], v[next]]:
[1]];