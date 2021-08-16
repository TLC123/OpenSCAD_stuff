//pub


echo(rfor (50,10,-10,[0,1]));

function rfor(i,to,stepsize=1,state)=
abs(i-to)<abs(stepsize)?/* are there space left to take next step */
state :  /* if done return state or what ever value you like*/
let(newstate=myFunction(state,i ))
rfor(i+stepsize,to,stepsize,newstate) // call next recursive step
;

/*your code here, reassign state as you like */
function myFunction (state,i)=  [state[0]+sqrt(i),state[1]];