
                module slice(r = 10, deg = 30) { 
                fn=$fn!=0?$fn :round(deg/10);  degn=(deg%360); 
                step=degn/fn;   start=min(degn ,0);  end=max(degn,0); 
                polygon(r*[[0,0], for(i=[start:step:end]) [cos(i), sin(i)]]);}

                slice(10, 130);