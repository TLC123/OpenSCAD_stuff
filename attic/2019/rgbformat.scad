echo("<img src='http://www.openscad.org/assets/img/logo.png'></img>");
echo("<font color='red'>red</font> <font color='green'>green</font> <font color='blue'>blue</font>");

ok=out ([[2,4,6 ],[2,4,6 ],] );
 function out(a)=
 let( e=
 is_list(a[0])?echo( chr(    [for(i=a)rgbFormat(i)]  )):
 len(a)==3?
 echo(rgbFormat(a)):
 echo(str(a)))
 true;
  function rgbFormat(a)=str( "[<font color='red'>",a[0],",<font color='green'>",a[1],",<font color='blue'>",a[2],"]");