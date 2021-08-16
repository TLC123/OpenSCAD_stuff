 
rows = [[40, 16, 54, 36, 36, 42, 67, 17, 40] ,
        [76, 20, 60, 51, 58, 73, 11  ] ,
        [50, 72, 11, 57,  3, 94, 33, 93, 13] ];
cols=rows_to_columns(rows);
echo ( rows);echo (  cols);

function rows_to_columns(l)= let(longest_list=max( [for(i=[0:len(l)-1])len(l[i])-1]))
[for( i=[0:longest_list])[for( j=[0:len(l)-1]) l[j][i]]];