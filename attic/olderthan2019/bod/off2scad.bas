 DEFSNG A-Z
' $INCLUDE: 'log.inc'
 seconds! = TIMER
 


IF Exist%(COMMAND$) THEN 
print "-"; COMMAND$;"-"
c$= left$( COMMAND$ ,len(COMMAND$)-4) 
do
h2=instr(c$,"\")
c$=RIGHT$(c$,len(c$)-h2)
loop until h2=0
print  c$+".scad"

 

OPEN COMMAND$ FOR INPUT  AS #1
input #1, solid$

close
 
if LEFT$ (lTRIM$(solid$),3)="OFF" then
'read ascii stl
first = instr(solid$," ")+1
secnd = instr(first,solid$," ")+1
third = instr(secnd,solid$," ")+1

 points= val (mid$(solid$, first ,secnd-first)) 
 faces= val (mid$(solid$, secnd ,third-secnd))

end if


OPEN COMMAND$ FOR INPUT  AS #2
open c$+".scad" for output as #1
print #1, "//polyhedron(";c$;"()[0],";c$;"()[1]);"
print #1, "function ";c$;"()=[
print #1, "["

input #2, b1,b2,b3,b3
 

for pt=1 to points 

input #2, x 
input #2, y 
input #2, z

if pt >1 then print #1,","; 
print #1,"[";x;",";y;",";z;"]"


next pt
print #1, "],"
print #1, "["

for n=1 to faces  
if n >1 then print #1, ",";

input #2, nm 
input #2, p1 
input #2, p2
input #2, p3
if nm=4 then
	input #2, p4
	print #1, "[";p1;",";p2;",";p3;",";p4;"]"
ELSE
	print #1, "[";p1;",";p2;",";p3;"]"
end if

next n

print #1, "]"
print #1, "];"

print faces;" Faces" 
print points;" Vertices" 




 
close




end if

print  TIMER-seconds! ; " Seconds"
sleep  5
system  
' functions
 
FUNCTION Min(a,b) 
if a<b then min=a else min=b 
END FUNCTION  
FUNCTION Max(a,b)
 if a>b then max=a else max=b 
END FUNCTION    
 
FUNCTION Exist% (filename$)
f% = FREEFILE
if filename$<>"" then
OPEN filename$ FOR APPEND AS #f%
IF LOF(f%) THEN Exist% = -1 ELSE Exist% = 0: CLOSE #f%: KILL filename$ 'delete empty files
CLOSE #f% 
ELSE
Exist% = 0
end if

END FUNCTION  

function Trim$(v)
Trim$=rtrim$(ltrim$(str$(v)))
end function