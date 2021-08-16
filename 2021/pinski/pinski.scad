    pinski(4);
    //
    module pinski ( n , c = [0, 0, 0, 1] ) {
        s=c[3];
        if (n == 0) {
            scale( [ 1, 1, sqrt(1) ] )
            translate( c + [s, s, 0]/ 2 )
            linear_extrude( s, scale = 0 )
            square( s, true );
        } else {
            pinski ( n-1,c + [0, 0, 0 , -s ]/ 2);
            pinski ( n-1,c + [0, s, 0 , -s ]/ 2);
            pinski ( n-1,c + [s, 0, 0 , -s ]/ 2);
            pinski ( n-1,c + [s, s, 0 , -s ]/ 2);
            pinski ( n-1,c + [s/2,s/2,s,-s ]/ 2);
        }
    }
