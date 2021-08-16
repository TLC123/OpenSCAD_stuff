Deck=["Ace of Spades","Two of Spades","Three of Spades",
"Four of Spades","Five of Spades","Six of Spades","Seven of Spades",
"Eight of Spades","Nine of Spades","Ten of Spades","Jack of Spades",
"Queen of Spades","King of Spades","Ace of Hearts","Two of Hearts",
"Three of Hearts","Four of Hearts","Five of Hearts","Six of Hearts",
"Seven of Hearts","Eight of Hearts","Nine of Hearts","Ten of Hearts",
"Jack of Hearts","Queen of Hearts","King of Hearts","Ace of Clubs",
"Two of Clubs","Three of Clubs","Four of Clubs","Five of Clubs",
"Six of Clubs","Seven of Clubs","Eight of Clubs","Nine of Clubs",
"Ten of Clubs","Jack of Clubs","Queen of Clubs","King of Clubs",
"Ace of Diamonds","Two of Diamonds","Three of Diamonds",
"Four of Diamonds","Five of Diamonds","Six of Diamonds",
"Seven of Diamonds","Eight of Diamonds","Nine of Diamonds",
"Ten of Diamonds","Jack of Diamonds","Queen of Diamonds","King of Diamonds"];

echo( shuffle(Deck,10));


function shuffle(il,repeat=2)=len(il)<=1?il:
let(l=repeat>0?shuffle(il,repeat-1):il, p=split(l))
round(rands(0,2,1)[0])==0?
concat( shuffle(p[0]),shuffle(p[1])):
concat( shuffle(p[1]),shuffle(p[0]));

function split(l)=[[for(i=[0:2:len(l)-1])l[i]],[for(i=[1:2:len(l)-1])l[i]]]  ;
 
