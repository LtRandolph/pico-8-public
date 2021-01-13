levels={
{
    name="20,63,wHERE aRE wE?",
    mapRect="0,0,16,16",
    dialogs=
[[updatePlayer=30|i FOUND SOME SCHEMATICS.
tHAT WHIP YOU GRABBED WORKS
WITH ALL THE ALIEN TECH.~30|tRY HITTING THINGS.
nOT THAT BIG RED BUTTON.
hAVEN'T FIGURED IT OUT YET.$getInteractPos=30|tHAT TERMINAL HAS MULTIPLE
MODES.
(pRESS JUMP)$changeMachineType=28|lOOKS LIKE YOU'VE FOUND
A HEAVY WEAPON. HOPEFULLY
WE WON'T NEED THAT.~26|*sNORT*$whipWaveButton=28|dID YOU DO SOMETHING,
jEM?~26|yEAH. tHAT BIG RED BUTTON
WAS IN MY WAY.$enemyArrived=30|aAH! gET AWAY!~28|yOU'VE GOT TO KILL THEM!
tHEY'RE SABOTAGING THE
EQUIPMENT.$waveEnded=30|fASCINATING. tHERE'S AN
AUTOMATED BUILD SYSTEM.~26|dAMN. bLOCKED MY SHOTS.$victory=26|tHAT'S ALL OF THEM.
hOW YOU TWO DOING?~30|i STILL HAVE SO MANY
QUESTIONS.~28|tHAT'S FINE. aSK WHILE WE
MOVE. i DON'T WANT TO STAY.]],
    waves=
[[squidA,150,5
squidA,130,10]],
    numbers=
[[lives=5
grapTypeCount=1
machineTypeCount=2]]
},
{
    name="20,43,rICOCHET",
    mapRect="0,16,16,48",
    dialogs=[[updatePlayer=30|tHOSE GRAPPLE NODES ARE MORE
VERSATILE THAN THEY APPEAR.~28|yOU CAN INSTALL MIRRORS TO
BOUNCE SHOTS AROUND.
(pRESS WHIP)$victory=28|nICE JOB, jEM.
lET'S KEEP LOOKING FOR A WAY
HOME.]],
    waves=
[[squidA,150,8
tankA,250,5]],
numbers=
[[lives=5
grapTypeCount=3
machineTypeCount=2]]
},
{
    name="20,75,sHOOTING gALLERY",
    mapRect="16,0,48,16",
    dialogs=[[updatePlayer=28|i THINK THIS WEAPON MIGHT
BE YOUR NEW FAVORITE.
STRAIGHT TO THE POINT.~26|a GUN?~28|yEAH.~26|yOU KNOW ME WELL, eSS.$victory=26|yOU WERE RIGHT, eSS.
i LIKE THIS ONE.]],
    waves=
[[squidA,80,12
tankA,220,9
squidB,100,10]],
numbers=
[[lives=5
grapTypeCount=3
machineTypeCount=3]]
},
{
    name="20,67,dISORIENTATION",
    mapRect="16,16,48,48",
    dialogs=[[updatePlayer=28|wE FIGURED OUT SOME MORE
TECHNOLOGY. a PORTAL SYSTEM
FOR THE GRAPPLE NODES.~30|oF COURSE, ANYTHING THAT
PASSES THROUGH WILL HAVE ITS
VELOCITY FLIPPED.~26|wHY'S THAT?~30|sCIENCE.$victory=26|tHESE PORTALS MIGHT GET US
HOME, YEAH?~30|mAYBE. i NEED MORE TIME.]],
    waves=
[[squidB,110,5
tankB,220,8]],
numbers=
[[lives=5
grapTypeCount=5
machineTypeCount=3]]
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
grapTypeCount=5
machineTypeCount=4]]
},
{
    name="20,55,sPACE fORCE",
    mapRect="80,0,112,16",
    dialogs=[[updatePlayer=28|aNOTHER GRAPPLE NODE MOD FOR
YOU. pUSHES IN A DIRECTION.~26|sOUNDS SIMPLE.$victory=26|hEY vAN. wHERE WE AT ON THAT
PORTAL TO eARTH?~30|sOLVING ALIEN PHYSICS AS
FAST AS MY HUMAN BRAIN CAN,
jEM.]],
    waves=
[[tankB,230,8
squidB,150,6]],
numbers=
[[lives=5
grapTypeCount=9
machineTypeCount=4]]
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
grapTypeCount=9
machineTypeCount=4]]
}
}

foreach(levels,parseNumbers)

function initLevel(level)
    currentLevel=level
    currentLevelWaves=split(level.waves,'\n')
    lives=level.lives
    trajectoryEndPoint=nil
    grapTypes={unpack(allGrapTypes,1,level.grapTypeCount)}
    machineTypes={unpack(allMachineTypes,1,level.machineTypeCount)}
    clearWrappedFns()
    for dialogPack in all(split(level.dialogs,'$')) do
        wrapFnWithDialog(unpack(split(dialogPack,'=')))
    end
end

function drawHealth()
    rectfill(0,0,32,6,0)
    if (lives==0) return
    rectfill(1,1,(31*lives/currentLevel.lives),5,3)
end