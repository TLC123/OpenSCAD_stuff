 DEFSNG A-Z
' $INCLUDE: 'log.inc'
dim header as STRING * 80
seconds! = TIMER
TYPE vertex
    x AS SINGLE
    y AS SINGLE
    z AS SINGLE
END TYPE
TYPE facetype
    n AS vertex
    p1 AS vertex
    p2 AS vertex
    p3 AS vertex
    i AS INTEGER
END TYPE


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
 
if LEFT$ (lTRIM$(solid$),5)="solid" then
'read ascii stl
 
OPEN COMMAND$ FOR INPUT  AS #2
open c$+".scad" for output as #1
print #1, "//polyhedron(";c$;"()[0],";c$;"()[1]);"
print #1, "function ";c$;"()=[
print #1, "["


m=0
do until eof(2)

input #2, line$

if LEFT$(lTRIM$(line$),6)="vertex" then

	h$=rtrim$(lTRIM$(line$))+" "
 	if m>0 then print #1,",";
	m=m+1
	h=instr(0,h$," ")+1
 	h2=instr(h,h$," ")

	print  #1, "[ ";
		do 
		h2=instr(h,h$," ")
  		p$=mid$(h$,h,h2-h)
		h=h2+1
		print  #1, p$;
		if p$<>"" and h2<len(h$) then print #1, ",";
	loop until h2=0
	 
     '	p$=mid$(h$,h3,len(h$)-h3)
	 print  #1,   "],"
end if




loop
print #1, "],"
print #1, "["
for n=0 to (m-1)  step 3
if n >0 then print #1, ",";
print #1, "[";n+1;",";n;",";n+2;"]"
next n
print #1, "]"
print #1, "];"

print m\3;" Faces" 
print m;" Vertices" 




 
close




else
'read binary stl
OPEN COMMAND$ FOR binary AS #1

	get #1,,header
	print header
	get #1,,Nof~&
	print Nof~&
	redim Mesh(Nof~&-1) as facetype 
   
	get #1,,Mesh()

 

close
open c$+".scad" for output as #1
print #1, "//polyhedron(";c$;"()[0],";c$;"()[1]);"
print #1, "function ";c$;"()=[
print #1, "["
for n=0 to (Nof~&-1)
if n >0 then print #1, ",";
print #1, "[";
print #1,  trim$ (Mesh(n).p1.x)  ;"," ;
print #1,  trim$ (Mesh(n).p1.y);"," ;
print #1,  trim$ (Mesh(n).p1.z);"" ;
print #1, "]" 
print #1, ",[";
print #1,  trim$ (Mesh(n).p2.x);"," ;
print #1,  trim$ (Mesh(n).p2.y);"," ;
print #1,  trim$ (Mesh(n).p2.z);"" ;
print #1, "]" 
print #1, ",[";
print #1,  trim$ (Mesh(n).p3.x);"," ;
print #1,  trim$ (Mesh(n).p3.y);"," ;
print #1,  trim$ (Mesh(n).p3.z);"" ;
print #1, "]"

next n
print #1, "],";
print #1, "["
for n=0 to (Nof~&-1) *3 step 3
if n >0 then print #1, ",";
print #1, "[";n+1;",";n;",";n+2;"]"
next n
print #1, "]"
print #1, "];"

close
print Nof~&;" Faces" 
print Nof~&*3;" Vertices" 

end if
end if

print  TIMER-seconds! ; " Seconds"
sleep  2
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