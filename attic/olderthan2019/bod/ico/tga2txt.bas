open "out.txt" for input as #3
 do until eof(3)
 INPUT #3 ,com$
print com$
 
 
if com$ <>""   then

open com$ for binary  as #1
on$=com$ +".scad"
open on$ for output  as #2
n=68-16-32-2
dim a as _unsigned _byte
print left$( com$ ,len(com$)-4);"=["
print #2, left$( com$ ,len(com$)-4);"=["
lines=0
 do until eof(1)
' print "["
 print #2,"["

for l=0 to 31
get #1,n,a
'print a ;",";
print #2 ,  a  ;",";

 n=n+1
next l
'print "],"
print #2,"],"
lines=lines+1
 loop

' print "]"
 print #2,"];"
 close (2)
 close (1)
 print lines ;n
 
 end if
 
 
 loop
 close(3)
  shell "del all.scad"
 shell "copy  *.scad all.scad"