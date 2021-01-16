 l="skara";
 
 lk=[for(i=l)if(isConsonant(i) )i];
 abb=(str(l[0],l[1],   lk[len(lk)-1]));
 echo(l,lk,abb);
 
 function isvowel(ch) =(ch=="a" || ch=="e" || ch=="i" || ch=="o" || ch=="u");
 function isConsonant(ch) =!isvowel(ch);
