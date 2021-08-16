// returns the numeric value of the leftmost character of the string.		
function ascii(char)=search(char,chr([0:255]))[0]+1;
echo( ascii("1"),ascii(" "),ascii("A"),ascii("Ape"));


function val(s)=let(l=len(s)-1)
([for(i=[0:l])(min(9,max(0,ascii(s[i])-48))*pow(10,l-i))]*[for(i=[0:l])1])*(s[0]=="-"?-1:1);
echo(val("a141"));

e=[0:255];
echo([for(i=e)1]);