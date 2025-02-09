
cls
randomize timer


dim completionflag as integer

'How do I get rid of the console window when using Screen?
'Here's the instructions for FBIde :

'1.Select 'View' from the pull down menu.
'2.Select 'Settings'
'3.Click the 'FreeBASIC' tab
'4.In the 'Compiler Command box' Change "<$fbc>" "<$file>" to "<$fbc>" "<$file>" -s gui
'5.Click 'Ok' at the bottom.

        dim p as integer

'Choose Font
'bload "ninfont.fon",0
'sleep

DrawSprite("texta1.pix",0,0,32)
DrawSprite("texta2.pix",32,0,32)
DrawSprite("texta3.pix",64,0,32)
DrawSprite("texta4.pix",96,0,32)
DrawSprite("texta5.pix",128,0,32)
DrawSprite("texta6.pix",160,0,32)
DrawSprite("texta7.pix",192,0,32)
DrawSprite("texta8.pix",224,0,32)
DrawSprite("textb1.pix",0,32,32)
DrawSprite("textb2.pix",32,32,32)
DrawSprite("textb3.pix",64,32,32)
DrawSprite("textb4.pix",96,32,32)
DrawSprite("textb5.pix",128,32,32)
DrawSprite("textb6.pix",160,32,32)
DrawSprite("textb7.pix",192,32,32)
DrawSprite("textb8.pix",224,32,32)
DrawSprite("textc1.pix",0,64,32)
DrawSprite("textc2.pix",32,64,32)
DrawSprite("textc3.pix",64,64,32)
DrawSprite("textc4.pix",96,64,32)
DrawSprite("textc5.pix",128,64,32)
DrawSprite("textc6.pix",160,64,32)
DrawSprite("textc7.pix",192,64,32)
DrawSprite("textc8.pix",224,64,32)

get (0,0)-(255,95),textfont

for a as integer = 0 to 255
   for b as integer = 0 to 95
       if point(a,b) = 31 then pset(a,b),12
   next b
next a

get (0,0)-(255,95),redtextfont

cls
DrawSprite("sn1234.pix",0,0,32)
DrawSprite("sn5678.pix",0,32,32)
DrawSprite("sn9.pix",0,64,32)
get(0,0)-(31,95),inumbers

for a as integer = 0 to 99
    starsx(a) = int(rnd * 640)
    starsy(a) = int(rnd * 480)
next a
for a as integer = 0 to 2
    projactive(a) = 0
next a
cls
DrawSprite("ship.pix",0,0,32)
DrawSprite("ship1.pix",32,0,32)
DrawSprite("ship2.pix",64,0,32)
DrawSprite("ship3.pix",96,0,32)
DrawSpriteC90("ship1.pix",32,32,32)
DrawSpriteC90("ship2.pix",64,32,32)
DrawSpriteC90("ship3.pix",96,32,32)
DrawSpriteC180("ship1.pix",32,64,32)
DrawSpriteC180("ship2.pix",64,64,32)
DrawSpriteC180("ship3.pix",96,64,32)
DrawSpriteCC90("ship1.pix",32,96,32)
DrawSpriteCC90("ship2.pix",64,96,32)
DrawSpriteCC90("ship3.pix",96,96,32)
'sleep
get (0,0)-(127,127),ship

cls
DrawSprite("pl.pix",8,0,64)
DrawSprite("an.pix",72,0,64)
DrawSprite("et.pix",128,0,64)
DrawSprite("lets.pix",192,0,64)

DrawSprite("po1.pix",64,64,64)
DrawSprite("po2.pix",128,64,64)

DrawSprite("my.pix",8,128,64)
DrawSprite("st.pix",72,128,64)
DrawSprite("er.pix",128,128,64)
DrawSprite("lety.pix",192,128,64)
get (0,0)-(255,191), logo





cls

DrawSprite("shipdock.pix",0,0,32)
DrawSprite("sd2.pix",32,0,32)
DrawSprite("sd3.pix",64,0,32)
get (0,0)-(95,0),shipdock

cls
DrawSprite("sproj.pix",0,0,32)
DrawSpriteC90("sproj.pix",32,0,32)
DrawSpriteC180("sproj.pix",64,0,32)
DrawSpriteCC90("sproj.pix",96,0,32)
get (0,0)-(127,31),ammo
cls
DrawSprite("eship.pix",0,0,32)
DrawSpriteC90("eship.pix",32,0,32)
DrawSpriteC180("eship.pix",64,0,32)
DrawSpriteCC90("eship.pix",96,0,32)
get (0,0)-(127,31), enemy
cls
DrawSprite("xplode1.pix",0,0,32)
DrawSprite("xplode2.pix",32,0,32)
DrawSprite("xplode3.pix",64,0,32)
get (0,0)-(95,31),xplode
cls
DrawSprite("rlm1.pix",0,0,128)
DrawSprite("rlm2.pix",128,0,128)
DrawSprite("glm1.pix",0,128,128)
DrawSprite("glm2.pix",128,128,128)
DrawSprite("blm1.pix",0,256,128)
DrawSprite("blm2.pix",128,256,128)
get (0,0)-(255,383),landmass
cls
DrawSprite("sn1234.pix",0,0,32)
DrawSprite("sn5678.pix",32,0,32)
DrawSprite("sn9.pix",64,0,32)
get (0,0)-(95,63),snum

cls
DrawSprite("mshipa1.pix",0,0,32)
DrawSprite("mshipa2.pix",32,0,32)
DrawSprite("mshipa3.pix",64,0,32)
DrawSprite("mshipa4.pix",96,0,32)

DrawSprite("mshipb1.pix",0,32,32)
DrawSprite("mshipb2.pix",32,32,32)
DrawSprite("mshipb3.pix",64,32,32)
DrawSprite("mshipb4.pix",96,32,32)

DrawSprite("mshipc1.pix",0,64,32)
DrawSprite("mshipc2.pix",32,64,32)
DrawSprite("mshipc3.pix",64,64,32)
DrawSprite("mshipc4.pix",96,64,32)

DrawSprite("mshipd1.pix",0,96,32)
DrawSprite("mshipd2.pix",32,96,32)
DrawSprite("mshipd3.pix",64,96,32)
DrawSprite("mshipd4.pix",96,96,32)

get (0,0)-(127,127),mshipdown
'sleep
'Get points
for a as integer = 0 to 16383
    mshipmatrix(a) = point(a mod 128,int(a/128))
next a
'Draw rotation
for a as integer = 0 to 16383
    pset(127-int(a/128), a mod 128), mshipmatrix(a)
next a

get (0,0)-(127,127),mshipleft
'sleep

'Get points
for a as integer = 0 to 16383
    mshipmatrix(a) = point(a mod 128,int(a/128))
next a
'Draw rotation
for a as integer = 0 to 16383
    pset(127-int(a/128), a mod 128), mshipmatrix(a)
next a

get (0,0)-(127,127), mshipup
'sleep

'Get points
for a as integer = 0 to 16383
    mshipmatrix(a) = point(a mod 128,int(a/128))
next a
'Draw rotation
for a as integer = 0 to 16383
    pset(127-int(a/128), a mod 128), mshipmatrix(a)
next a

get (0,0)-(127,127), mshipright
'sleep

cls

for a as integer = 0 to 9
    targetx(a) = int(rnd * 10000)-5000
    targety(a) = int(rnd * 10000)-5000
    targetdir(a) = int(rnd * 4)
    targetactive(a) = 1
next a
    
for a as integer = 0 to 2
    planetx(a) = int(rnd * 10000)-5000
    planety(a) = int(rnd * 10000)-5000
    planetsize(a) = int(rnd * 500)+250
next a 
planetcolor(0) = 1
planetcolor(1) = 2
planetcolor(2) = 4
diag = 0
RealMainMenu:
screenset 1,1
cls





'for a as integer = 0 to numcommands
'    gamecommand(a) = ""
'next a
'   numofcommands = 0
cls

sleep 500
cls

for a as integer = 0 to 31
    color a: line (a,a)-(640-a,480-a),16+int(a/2),b
next a

    put (192,0),logo,trans
'BigPrint(3,3,"*****DCRAWSHAWJR RPG SUITE*******")
BigPrint(12,11,"New Game")
BigPrint(14,11,"Load Game")
BigPrint(16,11,"Exit")

BigPrint(20,3,"Make your choice with arrow keys.")
BigPrint(21,3,"Press SPACE to confirm.")
cursor = 1
choice(1) = "New Game"
choicer(1) = 12:choicec(1) = 11
choice(2) = "Load Game"
choicer(2) = 14:choicec(2) = 11
choice(3) = "Exit"
choicer(3) = 16:choicec(3) = 11
MakeChoice(3)

if cursor = 1 then
    cls
    for a as integer = 0 to 31
    color a: line (a,a)-(640-a,480-a),16+int(a/2),b
    next a
    put (192,0),logo,trans
    'BigPrint(3,3,"*****DCRAWSHAWJR RPG SUITE*******")
    BigPrint(12,3,"Type your name to begin")
    BigPrint(13,3,"and press ENTER.")
    BigPrint(14,3,">....<")
    locate 15,9: line input newname
    if newname = "spacecheat" then
        completionflag = 9
        hpmax = 100
        hp = 100
        for a as integer = 0 to 9
            targetx(a) = int(rnd * 10000)-5000
            targety(a) = int(rnd * 10000)-5000
            targetdir(a) = int(rnd * 4)
            targetactive(a) = 1
        next a

        goto LoopStart0
    end if
    activefile = newname
    BigPrint(16,3,"Initializing new player...")
    'open "npcs\"+newname+".npc" for output as #1
    '    print #1,"STARTMODE 1"
    '    print #1,"$TART HP 030/030"
    '    print #1,"$TART SP 030/030"
    '    print #1,"$TART GOLD 00100"
    '    print #1,"$TART LVL 01"
    '    print #1,"$TART AT 00 00 02 06 mbasee1"
    '    'print #1,"$TART IN SPACE"
    '    print #1,"ENDMODE"
    'close #1
    open "files\"+newname+".qst" for output as #1
        print #1, 30
        print #1, 30
        print #1, 30
        print #1, 30
        print #1, 100
        print #1, 1
        print #1, 0
        print #1, 25
        print #1, "mbasee1"
        print #1, 0
        print #1, 0
        print #1, 64
        print #1, 196
        print #1, "Blank"
        print #1, "Blank"
        print #1, "Blank"
        print #1, "Blank"
        print #1, "Blank"
        print #1, "Blank"
        print #1, "Blank"
        print #1, "Blank"
        print #1, "Blank"
        print #1, 0
        print #1, 0
        print #1, 0
        print #1, 0
        print #1, 0
        print #1, 0
        'print #1, 1
        'print #1, "Buy me some bacon!"
        hp = 30: hpmax = 30
        ssp = 30: spmax = 30
        gold = 100
        level = 1
        mapfilename = "mbasee1"
        xstart = 0
        ystart = 0
        charx = 2*32
        chary = 6*32
    close #1
    open "files\"+newname+".cmd" for output as #1
        print #1, "1"
        numofcommands = 1
        for a as integer = 1 to 999
            gamecommand(a) = " "
            print #1, " "
        next a
    close #1
    
    cls
    
    
                for a as integer = 0 to 99
                for b as integer = 0 to 1: for c as integer = 0 to 1
                  pset (starsx(a)+b,starsy(a)+c),8
                next c: next b
            next a
            sleep 100
            for a as integer = 0 to 99
                for b as integer = 0 to 1: for c as integer = 0 to 1
                  pset (starsx(a)+b,starsy(a)+c),7
                next c: next b
            next a
            sleep 100
            for a as integer = 0 to 99
                for b as integer = 0 to 1: for c as integer = 0 to 1
                  pset (starsx(a)+b,starsy(a)+c),15
                next c: next b
            next a
            
            BigPrint(3,1,"During a mission six astronauts")
            sleep 2000
            BigPrint(5,1,"were suddenly beamed from their ships")
            sleep 2000
            BigPrint(7,1,"into another galaxy.  This galaxy")
            sleep 2000
            BigPrint(9,1,"contains three plantets.  They are...")
            sleep 2000
            BigPrint(11,1,"...the Planets of Mystery.")
            sleep 4000
            BigPrint(15,1,"You are a local among these parts who")
            sleep 2000
            BigPrint(17,1,"detects the ships.  Sensing they are")
            sleep 2000
            BigPrint(19,1,"in danger you go in search of them.")
            sleep 2000
            BigPrint(21,1,"Press any key to begin.")
            sleep 











        

    goto LoopStart0

'    startstatus = 1
'    npcactive = 1
'    npcname = activefile+ ".npc"
'    goto NPC
end if

if cursor = 2 then
    cls
    for a as integer = 0 to 31
    color a: line (a,a)-(640-a,480-a),16+int(a/2),b
    next a
    put (192,0),logo,trans

    'BigPrint(3,3,"*****DCRAWSHAWJR RPG SUITE*******")
    BigPrint(12,3,"Type your name to begin")
    BigPrint(13,3,"and press ENTER.")
    BigPrint(14,3,">....<")
    locate 15,9: line input newname
    activefile = newname
    BigPrint(16,3,"Initializing player...")
    open "files\"+newname+".qst" for input as #1
        input #1, hp
        input #1,hpmax
        input #1,ssp
        input #1,spmax
        input #1, gold
        input #1, level
        input #1, experience
        input #1, expmax
        input #1, mapfilename
        input #1, xstart
        input #1, ystart
        input #1, charx
        input #1, chary
        for a as integer = 1 to 9
            input #1, inventory(a) 
        next a
        for a as integer = 1 to 6
            input #1, spweapon(a)
        next a
        atk = atk * (1.1 ^ (level-1))
        def = def * (1.1 ^ (level-1))
        
        'input #1, numofcommands
        'for a as integer = 1 to numofcommands
        '    input #1, gamecommand(a-1)
        'next a
    close #1
    open "files\"+newname+".cmd" for input as #1
        input #1, numofcommands
        for a as integer = 1 to 999
            input #1, gamecommand(a)
        next a
    close #1

    
    goto LoadFile0
    'startstatus = 1
    'npcactive = 1
    'npcname = activefile+ ".npc"
    'goto NPC
end if

if cursor = 3 then 
    end
end if


'sleep

spacepatch = 0
'fbs_Create_Sound(spacebgmusic,@hSound)
