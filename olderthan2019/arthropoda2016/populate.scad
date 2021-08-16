T=[["unit1",[0,0,1],[0]],["unit2",[0,-1,1],[0]],["unit3",[0,1,1],[0]],["unit4",[0,3,1],[0]]]
;
echo(populate(T));

function populate(fdna, state = [0,1], i = 0) =
let (l = len(fdna) - 1, nextstate = popadd(state, fdna[i][1]))(i == l) ? [
  [fdna[i][0], fdna[i][1], nextstate]
] : concat([[fdna[i][0], fdna[i][1], nextstate]], populate(fdna, nextstate, i + 1));

function popadd(a, b) = a + [sin(b[1]),cos(b[1])];
