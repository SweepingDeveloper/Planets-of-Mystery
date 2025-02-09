
'Start of RPG Loop - Start of New Map Loop
LoadFile0:
'dim mshipactive as integer
'dim scheck as integer
dim shared tilexnote as integer
dim shared tileynote as integer
dim shared pxstart as integer
dim shared pystart as integer
dim shared pcharx as integer
dim shared pchary as integer
dim shared correct as integer
dim shared spweaponflag as integer
dim shared backgroundMusic as string


for a as integer = 0 to 9
spweapon(a) = 0
next a
'dim completionflag as integer
cls
loadflag = 1
oldsong = song
'dim scheck as integer
scheck = 0

open "maps\" + mapfilename + ".ma2" for input as #1
    input #1, song
    input #1, mdx
    input #1, mdy
    input #1, nborder
    input #1, borderxstart(0)
    input #1, borderystart(0)
    input #1, sborder
    input #1, borderxstart(1)
    input #1, borderystart(1)
    input #1, eborder
    input #1, borderxstart(2)
    input #1, borderystart(2)
    input #1, wborder
    input #1, borderxstart(3)
    input #1, borderystart(3)
    for a as integer = 0 to 31
        input #1, spname(a)
    next a
    for a as integer = 0 to mdy-1
        for b as integer = 0 to mdx-1
            input #1, spcode(b,a)
        next b
    next a
    for a as integer = 1 to 9
        input #1, ecode(a)
    next a
    for a as integer = 0 to 9
        input #1, enemyname(a)
    next a
close #1

if oldsong <> song then 


end if


for a as integer = 1 to 999
    if mid$(gamecommand(a),1,len(mapfilename)) = mapfilename then
        spcode(val(mid$(gamecommand(a),len(mapfilename)+2,2)),val(mid$(gamecommand(a),len(mapfilename)+5,2))) = val(right$(gamecommand(a),3))
    end if
    if left$(gamecommand(a),1) = "@" then  '@ # text
        ecode(val(mid$(gamecommand(a),3,1))) = right$(gamecommand(a),len(gamecommand(a))-5)
    end if
    if left$(gamecommand(a),1) = "S" then
        spweapon(val(right$(gamecommand(a),1))) = 1
    end if
next a


charas(0) = "herou1"
charas(1) = "herou3"
charas(2) = "herou2"
charas(3) = "herou3"
charas(4) = "herod1"
charas(5) = "herod3"
charas(6) = "herod2"
charas(7) = "herod3"
charas(8) = "herol1"
charas(9) = "herol3"
charas(10) = "herol2"
charas(11) = "herol3"
charas(12) = "heror1"
charas(13) = "heror3"
charas(14) = "heror2"
charas(15) = "heror3"
charsw(0) = "herous"
charsw(1) = "herods"
charsw(2) = "herols"
charsw(3) = "herors"



if sameflag = 0 then 
    cls
    for a as integer = 0 to 15
        DrawSprite(charas(a)+".pix", a*32,0,32)
        get (0,0)-(511,31), csprite
    next a
    cls
    DrawSprite(charsw(0)+".pix", 0,0,32)
    get (0,0)-(31,31), sspriteu
    cls
    DrawSprite(charsw(1)+".pix", 0,0,32)
    get (0,0)-(31,31), ssprited
    cls
    DrawSprite(charsw(2)+".pix", 0,0,32)
    get (0,0)-(31,31), sspritel
    cls
    DrawSprite(charsw(3)+".pix", 0,0,32)
    get (0,0)-(31,31), sspriter
    cls
end if


LoadFile:
if sameflag = 0 then 
    cls
    for a as integer = 0 to 31
        DrawSprite(spname(a)+".pix", (a mod 8)*32, int(a/8)*32,32)
    next a
    get (0,0)-(255,127), sprite
    cls
    DrawSprite(spname(0)+".pix", 0,0,32)
    get (0,0)-(31,31), sprite0
    cls
end if

sameflag = 0

cls
if border <> 4 then            'Scrolling Effects for going to the next screen.
    screenset 1,1
    if border = 0 then 
        for c as integer = 0 to 480
            put (0,c),screenshot, TRANS
            for a as integer = 0 to 14
                for b as integer = -1 to 20
                    spcoord = spcode(b+xstart,a+ystart) mod 100
                    spx = (spcoord mod 8)*32
                    spy = (int(spcoord / 8))*32
                    put ((b*32)+xoffset,-480+(a*32)+c+yoffset), sprite0, TRANS
                    put ((b*32)+xoffset,-480+(a*32)+c+yoffset), sprite, (spx,spy)-(spx+31,spy+31), TRANS
                next b   
            next a
            sleep 1
        next c
    end if

    if border = 1 then 
        for c as integer = 0 to -480 step -1
            put (0,c),screenshot, TRANS
            for a as integer = 0 to 14
                for b as integer = -1 to 20
                    spcoord = spcode(b+xstart,a+ystart) mod 100
                    spx = (spcoord mod 8)*32
                    spy = (int(spcoord / 8))*32
                    put ((b*32)+xoffset,480+(a*32)+c+yoffset),sprite0, TRANS
                    put ((b*32)+xoffset,480+(a*32)+c+yoffset), sprite, (spx,spy)-(spx+31,spy+31), TRANS
                next b
            next a
            sleep 1
        next c
    end if
    
    if border = 2 then 
        for c as integer = 0 to -640 step -1
            put (c,0),screenshot, TRANS
            for a as integer = -1 to 15
                for b as integer = 0 to 19
                    spcoord = spcode(b+xstart,a+ystart) mod 100
                    spx = (spcoord mod 8)*32
                    spy = (int(spcoord / 8))*32
                    put (640+(b*32)+c+xoffset,(a*32)+yoffset), sprite0, TRANS
                    put (640+(b*32)+c+xoffset,(a*32)+yoffset), sprite, (spx,spy)-(spx+31,spy+31), TRANS
                next b
            next a
            sleep 1
        next c
     end if

    if border = 3 then 
        for c as integer = 0 to 640
            put (c,0),screenshot, TRANS
            for a as integer = -1 to 15
                for b as integer = 0 to 19
                    spcoord = spcode(b+xstart,a+ystart) mod 100
                    spx = (spcoord mod 8)*32
                    spy = (int(spcoord / 8))*32
                    put (-640+(b*32)+c+xoffset,(a*32)+yoffset), sprite0, TRANS
                    put (-640+(b*32)+c+xoffset,(a*32)+yoffset), sprite, (spx,spy)-(spx+31,spy+31), TRANS
                next b
            next a
            sleep 1
        next c
    end if

end if


screenset 1,0

'fpscount = 0
'fps = 0
'now = TIMER

'********************START OF MAIN GAME LOOP*********************************
LoopStart2:
if completionflag = 1337 then goto RealMainMenu
if cheatactive = 1 then
    if cheatmode(0) = 1 then hp = hpmax
    if cheatmode(1) = 1 then ssp = spmax
    if cheatmode(2) = 1 then gold = 1771561
    if cheatmode(3) = 1 then repellant = 3
end if



border = 4
if now + 1 < TIMER then     'Calculates the FPS.  Also calculates the repellant time, if repellant was used.
    if repellant > 0 then repellant = repellant - 1
    
    grasschance = int(rnd * 6)+1
now = TIMER
fps = fpscount
fpscount = 0
end if
if spacepatch = 1 then spacepatch = 0: goto LoadFile0
LoopReset:
cls
inbattle = 0
npcbattle = 0

for a as integer = -1 to 15
    for b as integer = -1 to 20
        spcoord = (spcode(b+xstart,a+ystart) mod 100) mod 32
        spx = (spcoord mod 8)*32
        spy = (int(spcoord / 8))*32
        put ((b*32)+xoffset,(a*32)+yoffset), sprite, (0,0)-(31,31), TRANS
        put ((b*32)+xoffset,(a*32)+yoffset), sprite, (spx,spy)-(spx+31,spy+31), TRANS
    next b
    if warpflag = 1 then screencopy: sleep 25
next a
if warpflag = 1 then warpflag = 0


put (charx+xoffset, chary+yoffset), csprite, ((((charlook*4)+(chara mod 4))*32),0)-((((charlook*4)+(chara mod 4))*32)+31,31), TRANS



'*********ON-SCREEN STATUS TEXT GOES HERE***********
'line (
'BigPrint(1,2,"**********         $")
'39 = 0% = 0
'47 = 100% = hpmax

line (32,32)-step(160,16),135+((hp/hpmax)*8),bf
line (32,32)-step(160,16),87+((hp/hpmax)*8),b
if scheck = 0 then line (32,32)-step(160,16),15,b
line (33,33)-step(-2+(hp/hpmax)*160,14),39+((hp/hpmax)*8),bf
BigPrint(2,5,str(hp)+"/"+str(hpmax)+ "        $"+ str(gold))
if cheatmode(5) = 1 then BigPrint(0,0,"SPECIAL WEAPONS: "+ str(spweapon(1))+ str(spweapon(2))+ str(spweapon(3))+ str(spweapon(4))+ str(spweapon(5))+ str(spweapon(6))+ str(spweapon(7))+ str(spweapon(8)))
if cheatmode(5) = 1 then BigPrint(1,0,"CHARX "+str(charx)+" CHARY "+str(chary))
'BigPrint(1,1,str(charx)+ "   "+str(chary))
'for a as integer = 0 to 8
'    locate a+1,60: print inventory(a)
'next a

'BigPrint(1,5,str(numofcommands))
'***************************************************
grassflag = 0


'**************COLISSION DETECTION CODE***************
for a as integer = 0+ystart to 14+ystart
    for b as integer = 0+xstart to 19+xstart
        tilexnote = b
        tileynote = a
        xmin = (b*32)-31: xmax = (b*32)+31
        ymin = (a*32)-31: ymax = (a*32)+31
        if spcode(b,a) >= 200 and  spcode(b,a) <= 299 then
            for c as integer = 0 to 2
                if projx(c) >= xmin and projx(c) <= xmax and projy(c) >= ymin and projy(c) <= ymax then projactive(c) = 0
            next c
            if chary+(ystart*32) >= ymin and chary+(ystart*32) <= ymax and charx+(xstart*32) >= xmin and charx+(xstart*32) <= xmax then
                if chary+(ystart*32) = ymin then chary = chary - 1
                if chary+(ystart*32) = ymax then chary = chary + 1
                if charx+(xstart*32) = xmin then charx = charx - 1
                if charx+(xstart*32) = xmax then charx = charx + 1
                for c as integer = 1 to 9
                    if val(mid$(ecode(c),1,2)) = b and val(mid$(ecode(c),4,2)) = a then          
                        if npcname <> mid$(ecode(c),9,len(npcname)-8) then
                            npcname = mid$(ecode(c),9,len(npcname)-8)
                            npcmode = val(mid$(ecode(c),7,1))
                            npcactive = 1
                            goto NPC
                        end if
                        if npcname = mid$(ecode(c),9,len(npcname)-8) then
                            npcactive = 1
                            goto NPC
                        end if
                    end if
                next c
            end if
        end if
        'I know; this is lazy code; I just wanted to wrap things up.

'        for zz = 0 to 999
'            if gamecommand(zz) = "island2 29 09 101" and gamecommand(zz+1) = "island2 18 40 101" then
if completionflag < 8 then
    completionflag = 0
    for zz = 1 to 8
      if spweapon(zz) = 1 then completionflag = completionflag + 1
    next zz
end if





if completionflag = 8 then
    screenset 1,1
            for a as integer = 0 to 9 
                for b as integer = 0 to 479 step 10
                    line (0,b+a)-step(640,0),0
                next b
                sleep 100
            next a
            
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
            
            BigPrint(3,3,"And so the astronauts are free")
            sleep 2000
            BigPrint(5,3,"from their imprisonment in the")
            sleep 2000
            BigPrint(7,3,"vast worlds.  But who was it that")
            sleep 2000
            BigPrint(9,3,"was really holding them against")
            sleep 2000
            BigPrint(11,3,"their will?")
            sleep 4000
            BigPrint(15,3,"Something is amok in space...")
            sleep 2000
            BigPrint(17,3,"...perhaps the answers are there!")
            sleep 2000
            BigPrint(19,3,"Press any key to continue.")
            sleep 

        
            screenset 1,0
            npcactive = 0
            completionflag = 9
            goto LoopStart0
           
            
    
 end if
 '           end if
 '       next zz




if spcode(b,a) >= 300 then
            for c as integer = 0 to 2
                if projx(c) >= xmin and projx(c) <= xmax and projy(c) >= ymin and projy(c) <= ymax then projactive(c) = 0
            next c
            if chary+(ystart*32) >= ymin and chary+(ystart*32) <= ymax and charx+(xstart*32) >= xmin and charx+(xstart*32) <= xmax then
                grassflag = 1
                xtile = b: ytile = a
            end if
        end if
    next b
next a
'****************************************************



color 15,0
screenset 1,1
get (0,0)-(639,479),screenshot   'Screenshot used for various effects,
screenset 1,0                    'such as in battle, and in scrolling

GETMOUSE xint, yint, zint
screencopy                       'Copies what's drawn on the screen.

'*************USER INPUT*****************************
'If a user presses an arrow key, they go that direction.
'The player sprite reflects your move.
'This piece of code detects the player's location against a 
'certain reference point, and compensates with the x and y offset.
'This code also triggers a battle if the variable grasschance "rolls a 6"
'and you have no repellant.

if multikey(&h4B) then   'Left
    if grasschance = 6 and grassflag = 1 and repellant = 0 then rpindex = 1: Battler
RP1:
    charx = charx - 1
    if charx + xoffset < 160 and xstart > 0 then
        xoffset = xoffset + 1
    end if
    charlook = 2
    direction = 3
    anitimer = anitimer + 1
    if anitimer = 25 then anitimer = 0: scheck = scheck + 1: chara = chara + 1: if chara = 4 then chara = 0
end if

if multikey(&h4D) then   'Right
    if grasschance = 6 and grassflag = 1 and repellant = 0 then rpindex = 2: Battler
RP2:
    charx = charx + 1
    if charx + xoffset > 479 and xstart + 20 < mdx then
        xoffset = xoffset - 1
    end if
    direction = 1
    charlook = 3
    anitimer = anitimer + 1
    if anitimer = 25 then anitimer = 0: scheck = scheck + 1: chara = chara + 1: if chara = 4 then chara = 0
end if

if multikey(&h48) then   'Up
    if grasschance = 6 and grassflag = 1 and repellant = 0 then rpindex = 3: Battler
RP3:
    chary = chary - 1
    if chary + yoffset < 120 and ystart > 0 then
        yoffset = yoffset + 1
    end if
    direction = 0
    charlook = 0
    anitimer = anitimer + 1
    if anitimer = 25 then anitimer = 0: scheck = scheck + 1: chara = chara + 1: if chara = 4 then chara = 0
end if

if multikey(&h50) then   'Down
    if grasschance = 6 and grassflag = 1 and repellant = 0 then rpindex = 4: Battler
RP4:
    if chary + yoffset > 359 and ystart + 15 < mdy  then
        yoffset = yoffset - 1
    end if
    chary = chary + 1
    direction = 2
    charlook = 1
    anitimer = anitimer + 1
    if anitimer = 25 then anitimer = 0: scheck = scheck + 1: chara = chara + 1: if chara = 4 then chara = 0
end if



if gameoverflag = 1 then
            screenset 1,1
                for a as integer = 0 to 9 
                for b as integer = 0 to 479 step 10
                    line (0,b+a)-step(640,0),0
                next b
                sleep 100
            next a
            
            color ,0: cls


        gameoverflag = 0:
        screenset 1,0
        goto RealMainMenu
    end if




if multikey(&h32) then
end if


if scheck >= 10 then scheck = 0: ssp= ssp + 1: if ssp > spmax then ssp = spmax

if multikey(&h51) and cheatactive = 1 and cheatmode(4) = 1 then
    screenset 1,1
    ChangeMap:
    cls
    print "Warp Menu"
    line input "Place? >"; warpchoice
    MapPreview(warpchoice,128,128,8)
    input "XStart >"; pxstart
    input "YStart >"; pystart
    line (128+(pxstart*8),128+(pystart*8))-step(160,120),15,b
   
    input "X >"; pcharx
    input "Y >"; pchary
    circle (132+(pxstart*8)+(pcharx/4),132+(pystart*8)+(pchary/4)),5,15,,,,f
    input "Correct? (1 for yes)"; correct
    if correct <> 1 then goto ChangeMap
    if correct = 1 then 
        mapfilename = warpchoice
        xstart = pxstart
        ystart = pystart
        charx = pcharx
        chary = pchary
        goto LoadFile0
    end if
    screenset 1,0
end if


'If a player offsets beyond a sprite width (32 pixels), then the offset is
'reset to 0 and the entire board shifts.  In perspective, you wouldn't
'see the difference as the game pushes you back one sprite's length.

if xoffset = 32 then xoffset = 0: xstart = xstart - 1:charx = charx + 32
if xoffset = -32 then xoffset = 0: xstart = xstart + 1:charx = charx - 32
if yoffset = 32 then yoffset = 0: ystart = ystart - 1:chary = chary + 32
if yoffset = -32 then yoffset = 0: ystart = ystart + 1:chary = chary - 32
'*****************************************************


'********WARP LOCATIONS*******************************
'If a player goes beyond the current screen, the game
'moves them to the next appropriate screen, just like
'in the NES Legend of Zelda.
if charx < 0 then 
    charx = 600
    mapfilename = wborder
    if borderxstart(3) < 99 then xstart = borderxstart(3)
    if borderystart(3) < 99 then ystart = borderystart(3)
    border = 3
    cls
    goto LoadFile0
end if
if charx > 607 then 
    charx = 8
    mapfilename = eborder
    if borderxstart(2) < 99 then xstart = borderxstart(2)
    if borderystart(2) < 99 then ystart = borderystart(2)
    border = 2
   cls
    goto LoadFile0
end if
if chary < 0 then 
    chary = 440
    mapfilename = nborder
    if borderxstart(0) < 99 then xstart = borderxstart(0)
    if borderystart(0) < 99 then ystart = borderystart(0)
    border = 0
cls
    goto LoadFile0
end if
if chary > 448 then 
    chary = 8
    mapfilename = sborder
    if borderxstart(1) < 99 then xstart = borderxstart(1)
    if borderystart(1) < 99 then ystart = borderystart(1)
    border = 1
    cls
    goto LoadFile0
end if
'*********************************************************

getmouse x,y,,zz

'******************INVENTORY SCREEN***********************
ink = inkey$
if multikey(&h2C) then   'Z Key (i)
    '&h2C Z
    cursor = 1
    screenset 1,1
'    MakeBox(1,16,7,25,35,1,15,7)
'    MakeBox(2,13,4,14,15,1,15,7)
'    BigPrint(13,4,"INVENTORY")
    
    MakeBox(0,480,288,639,500,3,15,0)
    MakeBox(2,17,30,18,39,1,15,0)
    BigPrint(17,30,"INVENTORY")
    
    
    
    for aa = 1 to 9
        choice(aa) = ""
        for b as integer = 1 to len(inventory(aa))
            if mid$(inventory(aa),b,1) <> "." then choice(aa) = choice(aa) + mid$(inventory(aa),b,1)
            if mid$(inventory(aa),b,1) = "." then choice(aa) = choice(aa) + " "
        next b
        ix = 488 + ((aa-1) mod 3) * 48
        iy = 300 + int((aa-1)/3)* 48
        if left$(inventory(aa),9) = "Guaranola" then DrawSprite("gola.pix",ix,iy,32)
        if left$(inventory(aa),12) = "Muscle.Patch" then DrawSprite("mpatch.pix",ix,iy,32)
        if left$(inventory(aa),3) = "Ade" then DrawSprite("ade.pix",ix,iy,32)
        if left$(inventory(aa),7) = "iShield" then DrawSprite("ishield.pix",ix,iy,32)
        if left$(inventory(aa),7) = "Glasses" then DrawSprite("glasses.pix",ix,iy,32)
        if left$(inventory(aa),9) = "Fireworks" then DrawSprite("firework.pix",ix,iy,32)
        if left$(inventory(aa),10) = "Light.Show" then DrawSprite("lightshow.pix",ix,iy,32)
        if left$(inventory(aa),9) = "Repellant" then DrawSprite("repel.pix",ix,iy,32)
        if left$(inventory(aa),3) = "Key" then DrawSprite("key.pix",ix,iy,32)
        if left$(inventory(aa),7) = "Red.Key" then DrawSprite("redkey.pix",ix,iy,32)
        if left$(inventory(aa),10) = "Yellow.Key" then DrawSprite("yelwkey.pix",ix,iy,32)
        if left$(inventory(aa),9) = "Green.Key" then DrawSprite("grenkey.pix",ix,iy,32)
        if left$(inventory(aa),8) = "Corn.Dog" then DrawSprite("corndog.pix",ix,iy,32)
        if left$(inventory(aa),5) = "Blank" then DrawSprite("bbox.pix",ix,iy,32)
        if left$(inventory(aa),8) = "Boss.Key" then DrawSprite("bosskey.pix",ix,iy,32)
        
        quan = val(right$(inventory(aa),1))-1
        put (504 + ((aa-1) mod 3) * 48,316 + int((aa-1)/3)* 48),inumbers, ((quan mod 2) *16,int(quan/2)*16)-(16+(quan mod 2) *16,16+int(quan/2)*16),trans
        line (486+ ((aa-1) mod 3) * 48,298 + int((aa-1)/3)* 48)-step(36,36),3,b
        choice(aa) = left$(inventory(aa),len(inventory(aa))-3)
        if choice(aa) = "Bl" then choice(aa) = "Blank"
        choicer(aa) = 14+aa: choicec(aa) = 4
        'BigPrint(choicer(aa),choicec(aa),inventory(aa))
    next aa

   do
        z = inkey$: if z = " " then z = ""
        loop until z = ""
    do
    spweaponflag = 0
    for aa = 1 to 6 
        if spweapon(aa) = 1 then spweaponflag = spweaponflag + 1
     next aa
    if spweaponflag = 6 then
        MakeBox(2,28,25,30,39,1,15,0)
        BigPrint(28,25,choice(cursor))
        BigPrint(29,25,"Press W to warp")
    end if
    if spweaponflag < 6 then 
        MakeBox(2,28,25,29,39,1,15,0)
        BigPrint(28,25,choice(cursor))
    end if
    Selection3:
    line (486+ ((cursor-1) mod 3) * 48,298 + int((cursor-1)/3)* 48)-step(36,36),15,b

    z = inkey$: if z = "" then goto Selection3
    
    if z = chr$(255)+chr$(72) then     
        line (486+ ((cursor-1) mod 3) * 48,298 + int((cursor-1)/3)* 48)-step(36,36),3,b
        cursor = cursor - 3
        if cursor < 1 then cursor = cursor + 9
    end if
    if z = chr$(255)+chr$(80) then     
        line (486+ ((cursor-1) mod 3) * 48,298 + int((cursor-1)/3)* 48)-step(36,36),3,b
        cursor = cursor + 3
        if cursor > 9 then cursor = cursor - 9
    end if
    if z = chr$(255)+chr$(75) then     
        line (486+ ((cursor-1) mod 3) * 48,298 + int((cursor-1)/3)* 48)-step(36,36),3,b
        cursor = cursor - 1
        if cursor = 0 then cursor = 9
    end if
    if z = chr$(255)+chr$(77) then     
        line (486+ ((cursor-1) mod 3) * 48,298 + int((cursor-1)/3)* 48)-step(36,36),3,b
        cursor = cursor + 1
        if cursor = 10 then cursor = 1
    end if
    if z = "w" and spweaponflag = 6 then
        
        if mapfilename= "island" then mapfilename = "island2": goto IslandWarp
        if mapfilename= "island2" then mapfilename = "island"
        IslandWarp:
        screenset 1,1
        color 0,15: cls
        sleep 100
        color 0,0: cls
        sleep 100
        color 0,15: cls
        sleep 100
        color 0,0: cls
        sleep 100
        color 0,15: cls
        sleep 100
        color 0,0: cls
        sleep 100
        goto LoadFile0
    end if
    if z = chr$(255)+chr$(73) then
        MakeBox(2,17,30,18,39,1,15,0)
        BigPrint(17,30,"|||||||||")
        BigPrint(17,30,"PASSWORD?")
        locate 1,1: line input password
        if password = "iamajanitor" then
            BigPrint(17,30,"|||||||||")
            BigPrint(17,30,"ACTIVE!")
            cheatactive = 1
            sleep 1000
        end if
        if password = "sandbox" then
            BigPrint(17,30,"|||||||||")
            BigPrint(17,30,"SANDBOX!!")
            sleep 1000
            mapfilename = "sandbox"
            xstart = 0
            ystart = 0
            charx = 32
            chary = 32
            goto LoadFile0
        end if
        
    
    
    end if
loop until z = " "
    


    'MakeChoice(9)
    ItemEffects
    'rpindex = 5: goto ItemEffects
    RP5:
    
    EndofChoice:
    screenset 1,0
    iflag = 0
end if
'*********************************************************



'**********IN-GAME MAIN MENU******************************
if multikey(&h2A) then     'Shift Key
    GameMainMenu:
        cursor = 1 
        screenset 1,1
        MakeBox(1,16,7,25,47,1,15,7)
        MakeBox(2,13,4,14,15,1,15,7)
        BigPrint(13,4,"MAIN MENU")
        BigPrint(15,3,"Continue Game")
        BigPrint(16,3,"Status")
        BigPrint(17,3,"Options")
        BigPrint(18,3,"Save Game")
        BigPrint(19,3,"Quit Game")
        if cheatactive = 1 then BigPrint(20,3,"Cheats")
        choice(1) = "Continue Game"
        choicer(1) = 15: choicec(1) = 3
        choice(2) = "Status"
        choicer(2) = 16: choicec(2) = 3
        choice(3) = "Options"
        choicer(3) = 17: choicec(3) = 3
        choice(4) = "Save Game"
        choicer(4) = 18: choicec(4) = 3
        choice(5) = "Quit Game"
        choicer(5) = 19: choicec(5) = 3
        if cheatactive = 1 then
        choice(6) = "Cheats"
        choicer(6) = 20: choicec(6) = 3        
        end if
        if cheatactive = 0 then MakeChoice(5)
        if cheatactive = 1 then MakeChoice(6)
        if cursor = 1 then
            goto EndofMainMenu
        end if
        if cursor = 2 then
            MakeBox(1,16,7,25,35,1,15,7)
            MakeBox(2,13,4,14,15,1,15,7)
            BigPrint(13,4,str(activefile))
            BigPrint(15,3,"LEVEL: "+str(level))
            BigPrint(16,3,"EXP: "+str(experience)+"/"+str(expmax))
            BigPrint(17,3,"HP: "+str(hp)+"/"+str(hpmax))
            BigPrint(18,3,"ssp: "+str(ssp)+"/"+str(spmax))
            BigPrint(19,3,"ATK: "+str(atk))
            BigPrint(20,3,"DEF: "+str(def))
            BigPrint(21,3,"ACC: "+str(acc))
            BigPrint(22,3,"PRESS ANY KEY")
            do:loop until inkey$ = ""
            sleep
            goto GameMainMenu
        end if
        if cursor = 3 then
            
        end if
        if cursor = 4 then
            open "files\"+activefile+".qst" for output as #1
                print #1, hp
                print #1, hpmax
                print #1, ssp
                print #1, spmax
                print #1, gold
                print #1, level
                print #1, experience
                print #1, expmax
                print #1, mapfilename
                print #1, xstart
                print #1, ystart
                print #1, charx
                print #1, chary
                for a as integer = 1 to 9
                    print #1, inventory(a)
                next a
                'print #1, numofcommands
                'for a as integer = 1 to numofcommands-1
                '    print #1, gamecommand(a-1)
                'next a
                close #1
            open "files\"+activefile+".cmd" for output as #1
                print #1, numofcommands
                for a as integer = 1 to 999
                    print #1, gamecommand(a)
                next a
            close #1
                MakeBox(2,13,4,14,15,1,15,7)
                BigPrint(13,4,"Saved!")
                sleep 1000
            
            goto GameMainMenu
        end if
        if cursor = 5 then
            goto RealMainMenu
        end if
        if cursor = 6 then
            cursor = 1
        MakeBox(1,16,7,25,47,1,15,7)
        MakeBox(2,13,4,14,15,1,15,7)
        BigPrint(13,4,"CHEATS")
        BigPrint(15,3,"Infinite HP = "+str(cheatmode(0)))
        BigPrint(16,3,"Infinite ssp = "+str(cheatmode(1)))
        BigPrint(17,3,"Infinite Money = "+str(cheatmode(2)))
        BigPrint(18,3,"Infinite Repellant = "+str(cheatmode(3)))
        BigPrint(19,3,"Warp with PGDN = "+str(cheatmode(4)))
        BigPrint(20,3,"Debug Stats = "+str(cheatmode(5)))        
        BigPrint(21,3,"Back to Main Menu")
        choice(1) = "Infinite HP = "+str(cheatmode(0))
        choicer(1) = 15: choicec(1) = 3
        choice(2) = "Infinite ssp = "+str(cheatmode(1))
        choicer(2) = 16: choicec(2) = 3
        choice(3) = "Infinite Money = "+str(cheatmode(2))
        choicer(3) = 17: choicec(3) = 3
        choice(4) = "Infinite Repellant = "+str(cheatmode(3))
        choicer(4) = 18: choicec(4) = 3
        choice(5) = "Warp with PGDN = "+str(cheatmode(4))
        choicer(5) = 19: choicec(5) = 3
        choice(6) = "Debug Stats = "+str(cheatmode(5))
        choicer(6) = 20: choicec(6) = 3        
        choice(7) = "Back to Main Menu"
        choicer(7) = 21: choicec(7) = 3

        MakeChoice(7)
        if cursor = 1 then cheatmode(0) = abs(cheatmode(0)-1)
        if cursor = 2 then cheatmode(1) = abs(cheatmode(1)-1)
        if cursor = 3 then cheatmode(2) = abs(cheatmode(2)-1)
        if cursor = 4 then cheatmode(3) = abs(cheatmode(3)-1)
        if cursor = 5 then cheatmode(4) = abs(cheatmode(4)-1)
        if cursor = 6 then cheatmode(5) = abs(cheatmode(5)-1)
        if cursor = 7 then goto GameMainMenu
        end if
        
        
    EndofMainMenu:
end if
'*********************************************************
