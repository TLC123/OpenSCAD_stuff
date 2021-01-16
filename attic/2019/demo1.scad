    a = [[0,0],[1,1],[[1,2]], [[2,3],[[3,4]]]];
    echo(1,makePointListvec2(a));
    echo(ismytypevec2([1,1]));
    echo(ismytypevec2([1,1,1]));
    echo(ismytypevec3([1,1]));
    echo(ismytypevec3([1,1,1]));
    // ECHO : [ [0,0], [1,1], [1,2], [2,3],[[3,4] ]

    //
    //b = [["x",0],[1,1],[[1,2]], [[2,3],[[3,4]]]];
    //echo(makePointListvec2(b));
    // Recursion stack overflow

    c0 = [[0,0],[1,1],[[1,2]], [0, [2,3],[[3,4]]]];
    echo(makePointListvec2(c0));
    c1 = [[1,0,0],[1,1,1],[[1,2,2]], [1,0, [2,3],[[3,4]]]];
    echo(makePointListvec3(c1));
    c2 = [[0,0],[1,1,1],[[1,2,1]], [0, [2,3],[[3,4]]]];
    echo(makePointListvec3(c2));

    function makePointListvec2(a,c=0,result=[])= c<len(a) ?
    makePointListvec2(a,c+1,concat(result,ismytypevec2(a[c])?[a[c]]:
    makePointListvec2(a[c],0,[]) ) ) :result;
    function ismytypevec2(d)= len(d)==2&&len(d[0])==undef&&len(d[1])==undef ; 


    function makePointListvec3(a,c=0,result=[])= c<len(a) ?
    makePointListvec3(a,c+1,concat(result,ismytypevec3(a[c])?[a[c]]:
    makePointListvec3(a[c],0,[]) ) ) :result;
    function ismytypevec3(d)= len(d)==3&&len(d[0])==undef&&len(d[1])==undef&&len(d[2])==undef ; 