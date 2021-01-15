levels={
{
    name="20,63,wHERE aRE wE?",
    mapRect="0,0,16,16",
    dialogs=
[[updatePlayer=26|sO... wHERE ARE WE?~30|sEEMS THAT WAS AN ALIEN
TELEPORTER. sCOUT AHEAD,
WHILE I TRY TO GET US HOME.~28|tRY HITTING THINGS.
cAREFUL WITH THAT BIG RED
BUTTON.$getInteractPos=30|tHAT TERMINAL HAS MODES.
(pRESS JUMP)$machineType=28|lOOKS LIKE A WEAPON.
(aIM WITH ARROWS)$projDeathEffect=26|tHAT COULD DO SOME DAMAGE.$whipWaveButton=28|dID YOU DO SOMETHING, jEM?~26|yEAH. tHAT BIG RED BUTTON
WAS IN MY WAY.$enemyArrived=30|aAH! gET AWAY!~28|yOU'VE GOT TO KILL THEM!
tHEY'RE SABOTAGING THE
EQUIPMENT.$waveEnded=30|fASCINATING. tHEY'RE
BUILDING BARRIERS.~26|dAMN. bLOCKED MY SHOT.$victory=26|tHAT'S ALL OF THEM.
hOW YOU TWO DOING?~30|sTILL SO MUCH TO DECIPHER.~28|sURE. wORK WHILE WE MOVE.]],
    waves=
[[squidA,190,3
squidA,150,8]],
    numbers=
[[lives=5
grapCount=1
machCount=2
dir=1
blockCount=1]]
},
{
    name="20,43,rICOCHET",
    mapRect="0,16,16,48",
    dialogs=[[updatePlayer=30|tHOSE GRAPPLE NODES HAVE
MODES, TOO.~28|aDD MIRRORS TO BOUNCE YOUR
SHOTS.
(pRESS WHIP)$victory=28|nICE JOB, jEM.
lET'S KEEP GOING.]],
    waves=
[[squidA,150,8
tankA,250,5]],
numbers=
[[lives=5
grapCount=3
machCount=2
dir=-1
blockCount=2]]
},
{
    name="20,75,sHOOTING gALLERY",
    mapRect="16,0,48,16",
    dialogs=[[updatePlayer=28|tHIS WEAPON MIGHT BE YOUR
NEW FAVORITE.
sTRAIGHTFORWARD.~26|a GUN?~28|yEAH.~26|yOU KNOW ME WELL, eSS.$victory=26|yOU WERE RIGHT, eSS.]],
    waves=
[[squidA,80,12
tankA,220,9
squidB,100,10]],
numbers=
[[lives=5
grapCount=3
machCount=3
dir=-1
blockCount=3]]
},
{
    name="20,67,dISORIENTATION",
    mapRect="16,16,48,48",
    dialogs=[[updatePlayer=28|wE FIGURED OUT SOME MORE
TECHNOLOGY. a PORTAL SYSTEM
FOR THE GRAPPLE NODES.~30|oBVIOUSLY ANYTHING THAT
PASSES THROUGH WILL HAVE
ITS VELOCITY FLIPPED.~26|wHY'S THAT?~30|sCIENCE.$victory=26|tHESE PORTALS MIGHT GET US
HOME, YEAH?~30|i HOPE SO.]],
    waves=
[[squidB,110,5
tankB,220,8]],
numbers=
[[lives=5
grapCount=5
machCount=3
dir=-1
blockCount=4]]
},
{
    name="20,99,a sHOCKING dEVELOPMENT",
    mapRect="48,0,80,32",
    dialogs=[[updatePlayer=28|vAN FOUND MORE ALIEN
GIBBERISH.~30|tHIS "GIBBERISH" MAY SAVE
OUR LIVES.~28|fAIR. tRY A SPARK LAUNCHER.$victory=26|sTAY AWAY FROM MY NERDS.~28|*SIGH*]],
    waves=
[[squidB,120,8
squidC,150,6]],
    numbers=
[[lives=5
grapCount=5
machCount=4
dir=-1
blockCount=5]]
},
{
    name="20,55,sPACE fORCE",
    mapRect="80,0,112,16",
    dialogs=[[updatePlayer=28|aNOTHER GRAPPLE MODE:
pUSHES IN A DIRECTION.~26|sOUNDS SIMPLE.$victory=26|hEY vAN. hOW'S THAT PORTAL
TO eARTH GOING?~30|sOLVING ALIEN PHYSICS AS
FAST AS MY HUMAN BRAIN CAN,
jEM.]],
    waves=
[[tankB,230,8
squidB,150,6]],
numbers=
[[lives=5
grapCount=9
machCount=4
dir=-1
blockCount=3]]
},
{
    name="20,55,alMOST hOME",
    mapRect="80,16,112,48",
    dialogs=[[updatePlayer=30|iF i FLIP THE QUANTUM SPIN,
THE PORTAL RANGE SHOULD...~28|jEM, BUY US SOME TIME. vAN
LOOKS READY TO HAVE A
BREAKTHROUGH.~26|wILL DO. gET US HOME, BUDDY.$victory=30|tHAT'S IT! jEM, GET IN HERE.
wE'RE GOING HOME.]],
    waves=
[[tankB,200,8
squidC,120,8
tankC,240,6]],
numbers=
[[lives=10
grapCount=9
machCount=4
dir=1
blockCount=5]]
}
}

foreach(levels,parseNumbers)

function initLevel(level)
    currentLevel=level
    currentLevelWaves=split(level.waves,'\n')
    lives=level.lives
    trajEnd=nil
    grapTypes={unpack(allGraps,1,level.grapCount)}
    machineTypes={unpack(allMachs,1,level.machCount)}
    clearWrappedFns()
    for dialogPack in all(split(level.dialogs,'$')) do
        dialogFn(unpack(split(dialogPack,'=')))
    end
end

function drawHealth()
    rectfill(0,0,32,6,0)
    if (lives==0) return
    rectfill(1,1,(31*lives/currentLevel.lives),5,3)
end