/***** General list processing *****/

    // a temporary assert function
    // usage:
    //
    //  function sqrt2(x) =
    //      ! assert_(x>=0,"sqrt") ? "Error in sqrt: x<0" :
    //      sqrt(x);
    //
    function assert_(test=false,msg) =
        test ?
            true :
            assert(test,msg)!= undef;
        
    function flatten(l) = [ for (li = l, lij = li) lij ];

    // full flatten:  fflatten([1,2,[3,[4]]]) == [1,2,3,4]
    // note: fflatten(0) == [0]
    function fflatten(l) =
    l==flatten(l) ?
        l :
        fflatten(flatten(l));

    function each_(L) = [for(a=L, v = (a[0][0]!=undef ? a: [a]) ) v ];
      
    //  Creates a list from a range
    function range(r) = [ for(x=r) x ];

    // Long ranges lesser than 9000*9000 
    function Lrange(ini,end) = 
        let( n = floor((end-ini+1)/9000))
        [ for( k = [0:n],
           j = [0:1:k<n? 8999 : (end-ini+1)%9000-1 ] ,
           i = ini+k*9000 + j ) i];


    function irange(l,i=0,f=0) = [i:len(l)-1+f];

    function is_empty(l) = len(l)==0;
      
    function transpose(m) = // m is any rectangular matrix of objects
      [ for(i=[0:len(m[0])-1]) [ for(j=[0:len(m)-1]) m[j][i] ] ];

    // rotates the circular list l such that it starts at l[n%len(l)]
    function circulate(l,n=0) =
        n>0 ?
            [for(i=[0:1:len(l)-1]) l[(i+n)%len(l)] ]:
        n<0 ?
            [for(i=[0:1:len(l)-1]) l[(-n-i)%len(l)] ]:
            l ;

    // select from l the elements with indices are in the list 'inds'
    // keeping them in the order of the indices in 'inds'
    function select(l, inds) = [ for(i=inds) l[i] ];

    function sublist(l, from=0, to) =
        from > to ? [] :
            select(l,[from : (to==undef? len(l)-1 : to)]);

    function reverse(l) = len(l)>0 ? 
                            [ for(i=[len(l)-1:-1:0]) l[i] ] :
                            len(l)==0 ? [] : undef; 

    function is_in(t, l) = search(t,l)!=[];
    
    function append (l,e) = concat(l, [e]);
    function prepend(e,l) = concat([e], l);

    // Remove the elements of l with indices equal to or in ilist 
    function remove_from(ilist,l) =
        len(l) > 0 ?
            len(ilist) > 0 ?
                [ for(i=[0:len(l)-1]) if( ! is_in(i,ilist) ) l[i] ] :
                abs(ilist) < len(l) ?
                    [ for(i=[0:len(l)-1]) if( i != ilist ) l[i] ] :
                    l :
            l ;
/*
echo(remove_from([1,3,5],["a","b","c","d","e","f","g","h"]));
// ECHO: ["a", "c", "e", "g", "h"]
*/

/***** Lists of floats, vectors and points *****/
      
     // The index of the minimum (max) value in list l
    function index_min(l) = search(min(l), l)[0];
    function index_max(l) = search(max(l), l)[0];
/*
echo(index_min([1,2,-1,4,5,6])); // ECHO: 2
*/
    // clip the values of list v with the bounds minv and maxv
    // if v is a float, clamp it
    // returns undef if v is a empty list or both minv and maxv are undef
    function clamp(v,minv,maxv) =
        minv==undef ?
            len(v)>0 ? 
                clampMax(v,maxv):
                min(v,maxv) :
        maxv==undef ? 
            len(v)>0 ?
                clampMin(v,minv) :
                max(v,minv) :
        minv>maxv ?
            undef:
        len(v)>0 ? 
            clampMin(clampMax(v,minv),maxv) : 
            min(max(v,minv),maxv);
                    
    function clampMin(v,lim) = [for(vi=v) max(vi,lim) ];
    function clampMax(v,lim) = [for(vi=v) min(vi,lim) ];
    

/*
echo(clamp([1,-2,3,4,[2],undef],minv=2,maxv=3));
echo(clamp( [-45, -35, -25], minv=0));
echo(clamp( [-45, -35, -25], minv=-40,maxv=-30));
echo(clamp( [-45, -35, -25], minv=-30,maxv=-40));
echo(clamp( -1, minv=0));
echo(clamp( -1, maxv=0));
echo(clampMax( [-45, -35, -25], -30));
echo(clampMin( [-45, -35, -25], -30));
*/
                    
    // check if the elements of v has the same pattern pat
    function is_list_of(v,pat) = [for(vi=v) if(0*vi!=0*pat) 1 ]==[];

/*
    echo(is_list_of([[1,2],[1,1],[2,3]], [0,1,2]));
    echo(is_list_of([[1,[2]],[1,[1]],[2,[3]]], [0,[1]]));
    echo(is_list_of([[1]], 2));
    echo(is_list_of([1], 2));
    echo(is_list_of([1,undef],2));
    echo(is_list_of([1,1/0],2));
    echo(is_list_of(1, 2));
*/
                
    // The sum of the elements of a list of numbers or vectors
    // This works with uniform list of numbers or vectors.
    function sum_vectors(l) = len(l) > 0 ? [ for(li=l) 1 ] * l : undef;
    // This is more general and works with uniform lists
    function g_sum(l) = _gsum(l,0,0*l[0]);
    function _gsum(l, i=0, sum) = 
        i==len(l) ? 
            sum :
            _gsum(l, i + 1, sum + l[i]);
/*
echo(sum_vectors([[1,0],[2,0],[3,0],[4,1]])); // [10, 1]
echo(sum_vectors([ [1,[2],[[3]]], [10,[20],[[30]]] ])); // undef
echo(g_sum([[1,0],[2,0],[3,0],[4,1]])); // [10, 1]
echo(g_sum([ [1,[2],[[3]]], [10,[20],[[30]]] ])); //  [11, [22], [[33]]]
*/

    // The accumulated sum of a list
    // Generates the list of partial sums of list l, that is, the i-th element
    // of the list accum_sum(l) is the sum of all elements of l with indices less
    // than or equal to i. The offset offs is added to each element of the list.
    // It works with uniform lists of numbers, vectors, matrices, etc.
    function accum_sum(l, offs=0) = len(l) > 0 ? _accum_sum(l, offs): undef;
    function _accum_sum(l, offs=0, res=[]) =
        len(res) == len(l) ?
            res :
            _accum_sum(l, offs+l[len(res)], concat(res, [ offs+l[len(res)] ] ));
/*
echo(accum_sum([1,1,1,1,2], offs=1));
//ECHO: [2, 3, 4, 5, 7]
*/
    function mean_value(p) = 
        !(len(p) > 0) ? 
            undef : 
            ([ for(pi=p) 1 ] * p )/len(p);

/*
echo(mean_value([[1,0],[2,0],[3,0],[4,1]]));
//ECHO: [2.5, 0.25]
*/

    // The length of a polygonal: p is supposed to be a list of points
    function length(p) =
        !(len(p) > 1) ?
            0:
            sum_vectors([ for(i=[0:len(p)-2]) norm(p[i+1]-p[i]) ] );
/*
echo(length([[3,0],[4,1]]));
echo(length([[1,0],[2,0],[3,0],[4,1]]));
//ECHO: 1.41421
//ECHO: 3.41421
*/

    function is_equal(a, b, d=1e-16) = (a==b) || (abs(a-b)<d) || (norm(a-b)<d);
    
    // the output list is composed of each distinct element of the input list l
    // repetitions are discarded
    function remove_repetitions(l, d=1e-16) = 
        (len(l)==undef) || (len(l)<=1)? l : 
            concat( [ l[0] ], 
                    [ for(i=[1:len(l)-1]) let(li=l[i]) 
                        if( len([ for(j=[0:i-1]) if( is_equal(li,l[j],d) ) 0 ])==0 ) li ]
                  );

/*
echo(remove_repetitions([[4,1],[2,0],[3,0],[4,1],[2,5],[3,0],[4,1]]));
// ECHO: [[4, 1], [2, 0], [3, 0], [2, 5]]
*/
     
    // Remove points of a polygonal that are too close.
    // Formally: remove from the closed polygonal p the minimum number of 
    // points such that if
    //      q = remove_null_segments(p, trsh) 
    // then
    //      norm(q[i]-q[(i+1)%len(q)]) > trsh  for i=[0:len(q)-1]
    //
    function remove_null_segments(p, trsh) =
        _collect_different(concat(p, [ p[0] ]), trsh);

    function _collect_different(p, trsh, j=0, from=1, clct=[]) =
        let(i=_first_different_from(p, j, from, trsh)) 
        i >= len(p) ?
            clct :
            _collect_different(p, trsh, j=i, from=(i+1), clct=concat( clct, [ p[j] ]));

    function _first_different_from(p, j, from, trsh) =
        from >= len(p) || norm( p[from] - p[j] ) >= trsh ?
            from :
            _first_different_from(p, j, from+1, trsh);

/*
echo(remove_null_segments([[1,0],[2,0],[2.05,0],[3,0],[4,1]], 1.1));
//ECHO: [[1, 0], [3, 0], [4, 1]]
*/

    // Display a matrix from indices 'from' to 'to' one line at a time
    // 'string' is a identifier of the matrix
    module echo_matrix(m,s="", from=0, to=undef){ 
      lm  = len(m);
      til = to== undef ? lm : to;
      if(lm > 0) {
          echo(str("\n\nMatrix ",s,"[",lm,"x",len(m[0]),"]\n",_display_matrix(m, from=from, to=til),"\n"));
      } else {
          echo(str("Matrix ",s,"[]"));
      }
    }

    function _display_matrix(a, from, to, string="") =
        from >= to ? 
            string :
            _display_matrix(a, from+1, to, str(string, str("\n>>",from,"/ ",a[from]) ));


/* *************************  Quicksort ************************* */

    // Sort the array 'arr' in ascending (ascend=true) or descending (ascend=false) order
    // either of the arr[] values if keypos==undef or of the key arr[][keypos] otherwise
    // if keypos==undef, arr is supposed to be an array of numbers
    // otherwise, arr[i] is dealed as an array of length greater or equal to keypos+1
    function quick_sort(arr, keypos=undef, ascend=true) = 
        !(len(arr)>0) ? [] : 
            let( pivot   = keypos==undef? arr[floor(len(arr)/2)] : arr[floor(len(arr)/2)][keypos],
                lesser  = [ for (y = arr) if ( (keypos==undef? y : y[keypos])  < pivot) y ],
                equal   = [ for (y = arr) if ( (keypos==undef? y : y[keypos]) == pivot) y ],
                greater = [ for (y = arr) if ( (keypos==undef? y : y[keypos])  > pivot) y ] )
            ascend ? 
                concat( quick_sort(lesser,  keypos, ascend), 
                        equal, 
                        quick_sort(greater, keypos, ascend) ) :    
                concat( quick_sort(greater, keypos, ascend), 
                        equal, 
                        quick_sort(lesser,  keypos, ascend) ); 
/*
echo(quick_sort([[1,2],[2,1],[3,5],[4,-1],[5,10]], 1, true));
// ECHO: [[4, -1], [2, 1], [1, 2], [3, 5], [5, 10]]
/*