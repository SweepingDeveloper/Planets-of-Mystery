'dim mshipactive as integer
'dim scheck as integer


LoopStart0:
'dim shared mshipactive as integer
'dim shared scheck as integer
    if completionflag <> 9 then 
    end if

    if completionflag = 9 then 
        
    mshipx = int(rnd * 10000)-5000
    mshipy = int(rnd * 10000)-5000
    'mshipx = 0
    'mshipy =0  
    mshipdir = int(rnd * 4)
    mshipactive = 1
    mshiphp = 100

        
    end if
spacedelay = 0
'fbs_Stop()

'fbs_Play_Sound(hSound,3) 

screenset 1,0
LoopStart:

    


if multikey(&h4B)+multikey(&h48)+multikey(&h4D)+multikey(&h50) < 2 then diag = 0
if multikey(&h4B) = 1 and multikey(&h48) = 1 and shipactive = 1 then diag = 1 : direction = 3 'Up Left
if multikey(&h4B) = 1 and multikey(&h4D) = 1 and shipactive = 1 then diag = 1 : direction = 0 'Up Right
if multikey(&h50) = 1 and multikey(&h48) = 1 and shipactive = 1 then diag = 1 : direction = 1 'Down Left
if multikey(&h50) = 1 and multikey(&h4D) = 1 and shipactive = 1 then diag = 1 : direction = 2 'Down Right

cls
'locate 1,1: print multikey(&h4B)+multikey(&h48)+multikey(&h4D)+multikey(&h50)



for a as integer = 0 to 99
    for b as integer = 0 to 1: for c as integer = 0 to 1
      pset (starsx(a)+b,starsy(a)+c),15
    next c: next b
next a
    for a as integer = 0 to 2
        if planetx(a)-offsetx > 0-planetsize(a) and planetx(a)-offsetx < 640+planetsize(a) and planety(a)-offsety > 0-planetsize(a) and planety(a)-offsety < 480+planetsize(a) then 
            circle (planetx(a)-offsetx,planety(a)-offsety),planetsize(a),planetcolor(a),,,,F
            if a = 0 and val(mid$(date$,4,2)) mod 2 = 0 then put (planetx(a)-offsetx-64,planety(a)-offsety-64),landmass,(0,128)-(127,255),trans
            if a = 0 and val(mid$(date$,4,2)) mod 2 = 1 then put (planetx(a)-offsetx-64,planety(a)-offsety-64),landmass,(128,128)-(255,255),trans
            if a = 1 and val(mid$(date$,4,2)) mod 2 = 0 then put (planetx(a)-offsetx-64,planety(a)-offsety-64),landmass,(0,256)-(127,383),trans
            if a = 1 and val(mid$(date$,4,2)) mod 2 = 1 then put (planetx(a)-offsetx-64,planety(a)-offsety-64),landmass,(128,256)-(255,383),trans
            if a = 2 and val(mid$(date$,4,2)) mod 2 = 0 then put (planetx(a)-offsetx-64,planety(a)-offsety-64),landmass,(0,0)-(127,127),trans
            if a = 2 and val(mid$(date$,4,2)) mod 2 = 1 then put (planetx(a)-offsetx-64,planety(a)-offsety-64),landmass,(128,0)-(255,127),trans
            if a = 0 and val(mid$(date$,4,2)) mod 2 = 1 then put (planetx(a)-offsetx-256,planety(a)-offsety-64),landmass,(0,128)-(127,255),trans
            if a = 0 and val(mid$(date$,4,2)) mod 2 = 0 then put (planetx(a)-offsetx-256,planety(a)-offsety-128),landmass,(128,128)-(255,255),trans
            if a = 1 and val(mid$(date$,4,2)) mod 2 = 1 then put (planetx(a)-offsetx-256,planety(a)-offsety-64),landmass,(0,256)-(127,383),trans
            if a = 1 and val(mid$(date$,4,2)) mod 2 = 0 then put (planetx(a)-offsetx-256,planety(a)-offsety-128),landmass,(128,256)-(255,383),trans
            if a = 2 and val(mid$(date$,4,2)) mod 2 = 1 then put (planetx(a)-offsetx-256,planety(a)-offsety-64),landmass,(0,0)-(127,127),trans
            if a = 2 and val(mid$(date$,4,2)) mod 2 = 0 then put (planetx(a)-offsetx-256,planety(a)-offsety-128),landmass,(128,0)-(255,127),trans
        end if
    next a    
    for a as integer = 0 to 9
        if targetx(a)-offsetx > 0 and targetx(a)-offsetx < 640 and targety(a) - offsety > 0 and targety(a)-offsety < 480 then
            if targetactive(a) = 1 then put (targetx(a)-offsetx,targety(a)-offsety),enemy,(32*targetdir(a),0)-((32*targetdir(a))+31,31),trans
            if targetactive(a) >= 2 then put (targetx(a)-offsetx,targety(a)-offsety),xplode,(32*0,0)-((32*0)+31,31),trans
            if targetactive(a) >= 6 then put (targetx(a)-offsetx,targety(a)-offsety),xplode,(32*1,0)-((32*1)+31,31),trans
            if targetactive(a) >= 10 then put (targetx(a)-offsetx,targety(a)-offsety),xplode,(32*2,0)-((32*2)+31,31),trans
            if targetactive(a) >= 14 then put (targetx(a)-offsetx,targety(a)-offsety),xplode,(32*1,0)-((32*1)+31,31),trans
            if targetactive(a) >= 18 then put (targetx(a)-offsetx,targety(a)-offsety),xplode,(32*0,0)-((32*0)+31,31),trans
        end if
    next a
    'if completionflag = 9 then
    'end if
    
    



    line (440,280)-(639,479),18,BF
    line (440,280)-(639,479),15,B
    for a as integer = 0 to 2
        circle (540+(planetx(a)/50),380+(planety(a)/50)),(planetsize(a)/50),planetcolor(a),,,,F
    next a
    for a as integer = 0 to 9
        if targetactive(a) = 1 then circle (540+(targetx(a)/50),380+(targety(a)/50)),2,4,,,,F
        if targetactive(a) >=2 then circle (540+(targetx(a)/50),380+(targety(a)/50)),3,14,,,,F
        if targetactive(a) >=6 then circle (540+(targetx(a)/50),380+(targety(a)/50)),4,15,,,,F
        if targetactive(a) >=10 then circle (540+(targetx(a)/50),380+(targety(a)/50)),5,15,,,,F
        if targetactive(a) >=14 then circle (540+(targetx(a)/50),380+(targety(a)/50)),4,14,,,,F
        if targetactive(a) >=18 then circle (540+(targetx(a)/50),380+(targety(a)/50)),3,14,,,,F
    next a
        if completionflag = 9 then
                if mshippd > 0 then 
                    circle (mshippx-offsetx, mshippy-offsety),mshippd,32+((mshippd/100)*8),,,,F
                end if
                if mshipactive = 1 then circle (540+(mshipx/50),380+(mshipy/50)),4,14,,,,F
        end if
    circle (540+(shipx/50),380+(shipy/50)),2,int(rnd * 256),,,,F
    line (540+(shipx/50)-6,380+(shipy/50)-5)-STEP(13,10),15,B
        if mshipactive = 1 and mshipdir = 0 then put(mshipx-offsetx,mshipy-offsety),mshipup,trans
        if mshipactive = 1 and mshipdir = 1 then put(mshipx-offsetx,mshipy-offsety),mshipright,trans
        if mshipactive = 1 and mshipdir = 2 then put(mshipx-offsetx,mshipy-offsety),mshipdown,trans
        if mshipactive = 1 and mshipdir = 3 then put(mshipx-offsetx,mshipy-offsety),mshipleft,trans
 

    if shipactive = 1 then
        put (shipx-offsetx,shipy-offsety),ship,(32*int(ani),32*direction)-((32*int(ani))+31,(32*direction)+31),trans
    end if
    if shiphealthdelay > 1 and shiphealthdelay mod 2 = 0 then put (shipx-offsetx+4,shipy-offsety+4),ship,(32*int(ani),32*direction)-((32*int(ani))+31,(32*direction)+31)
    'if shipactive > 1 then put (shipx-offsetx+1,shipy-offsety+1),ship,(32*int(ani),32*direction)-((32*int(ani))+31,(32*direction)+31)
    for a as integer = 0 to 2
        if projactive(a) = 1 then put (projx(a)-offsetx,projy(a)-offsety),ammo,(32*projdir(a),0)-((32*projdir(a))+31,31),trans
    next a

    for a as integer = 0 to 2
    xmin = planetx(a)-64: xmax = planetx(a) + 64
    ymin = planety(a)-64: ymax = planety(a) + 64
        if shipx >= xmin and shipx <=xmax and shipy >= ymin and shipy <= ymax then
            BigPrint (4,0,"DOCKING READY")
            if multikey(&h39) then
                    if planetcolor(a) = 4 then 
                        npcactive = 1
                        spacepatch = 1
                        npcname = "wtmbase.npc"
                        goto NPC
                    end if
                    if planetcolor(a) = 1 then 
                        npcactive = 1
                        spacepatch = 1
                        npcname = "wtisland.npc"
                        goto NPC
                    end if
                    if planetcolor(a) = 2 then 
                        npcactive = 1
                        spacepatch = 1
                        npcname = "wtvillage.npc"
                        goto NPC
                    end if
            end if
            
        end if
    next a
line (32,32)-step(160,16),135+((hp/hpmax)*8),bf
line (32,32)-step(160,16),87+((hp/hpmax)*8),b
if scheck = 0 then line (32,32)-step(160,16),15,b
line (33,33)-step(-2+(hp/hpmax)*160,14),39+((hp/hpmax)*8),bf
BigPrint(2,5,str(hp)+"/"+str(hpmax)+ "        $"+ str(gold))
BigPrint(0,0,str(npcvar(0))+str(npcvar(1)))

if mshipactive = 1 then
line (32,64)-step(160,16),135+((mshiphp/100)*8),bf
line (32,64)-step(160,16),87+((mshiphp/100)*8),b
line (32,64)-step(160,16),12,b
line (33,65)-step(-2+(mshiphp/100)*160,14),39+((mshiphp/100)*8),bf
    BigPrint(4,3,str(mshiphp)+"/100")
end if


   WAIT &h3DA, 8

    SCREENCOPY
   
if inkey$ = "q" then end



if multikey(&h4B) and shipactive = 1 then    'left
    direction = 3
    shipx = shipx - 4
        offsetx = offsetx - 4
        for a as integer = 0 to 99
            starsx(a) = starsx(a) + 8
            if starsx(a) >= 640 then starsx(a) = 0 : starsy(a) = int(rnd * 480)
        next a

end if

if multikey(&h4D) and shipactive = 1 then    'right 
    direction  = 1
    shipx = shipx + 4
    offsetx = offsetx + 4
    for a as integer = 0 to 99
        starsx(a) = starsx(a) - 8
        if starsx(a) <= -1 then starsx(a) = 639 : starsy(a) = int(rnd * 480)
    next a
end if

if multikey(&h48) and shipactive = 1  then    'up
    direction  = 0
    shipy = shipy - 4
    offsety = offsety - 4
    for a as integer = 0 to 99
        starsy(a) = starsy(a) + 8
        if starsy(a) >= 480 then starsy(a) = 0 : starsx(a) = int(rnd * 640)
    next a
end if

if multikey(&h50) and shipactive = 1  then   'down
    direction  = 2
    shipy = shipy + 4
    offsety = offsety + 4
    for a as integer = 0 to 99
        starsy(a) = starsy(a) - 8
        if starsy(a) <= -1 then starsy(a) = 479 : starsx(a) = int(rnd * 640)
    next a
end if
    





ani = ani + .1
if ani >= 4 then ani = 1


if multikey(&h2D) and firedelay = 0 then 

    firedelay = 10
    if projactive(0) = 0 then projactive(0) = 1: projx(0) = shipx: projy(0) = shipy: projdir(0) = direction: goto One
    if projactive(1) = 0 then projactive(1) = 1: projx(1) = shipx: projy(1) = shipy: projdir(1) = direction: goto One
    if projactive(2) = 0 then projactive(2) = 1: projx(2) = shipx: projy(2) = shipy: projdir(2) = direction: goto One
One:
end if

for a as integer = 0 to 2
    if projactive(a) = 1 then 
        if projdir(a) = 0 then projy(a) = projy(a) - 8: if projy(a)-offsety < 0 then projactive(a) = 0 
        if projdir(a) = 1 then projx(a) = projx(a) + 8: if projx(a)-offsetx > 640 then projactive(a) = 0 
        if projdir(a) = 2 then projy(a) = projy(a) + 8: if projy(a)-offsety > 480 then projactive(a) = 0 
        if projdir(a) = 3 then projx(a) = projx(a) - 8: if projx(a)-offsetx < 0 then projactive(a) = 0 
    end if
next a

if spacedelay = 299 then
    mshippx = mshipx+64
    mshippy = mshipy+64
    mshippd = 1

end if

if mshippd > 0 then
    mshippd = mshippd + 3
    if mshippd = 451 then mshippd = 0: spacedelay = 0
end if



if mshipactive = 1 then
    if mshipx + 128 < shipx then mshipx = mshipx + 3: mshipdir = 1
    if mshipx  > shipx+32 then mshipx = mshipx - 3: mshipdir = 3
    if mshipy +128 < shipy then mshipy = mshipy + 3: mshipdir = 2
    if mshipy  > shipy+32 then mshipy = mshipy - 3: mshipdir = 0
end if


for a as integer = 0 to 9
    if targetactive(a) > 1 then targetactive(a) = targetactive(a) + 1: if targetactive(a) = 21 then targetactive(a) = 0 
    if shipactive = 1 then
    if a > 4 then 
        if targetx(a) < shipx then targetx(a) = targetx(a) + 2: targetdir(a) = 1
        if targetx(a) > shipx then targetx(a) = targetx(a) - 2: targetdir(a) = 3
        if targety(a) < shipy then targety(a) = targety(a) + 1: targetdir(a) = 2
        if targety(a) > shipy then targety(a) = targety(a) - 1: targetdir(a) = 0
    end if
    if a < 5 then 
        if targetx(a) < shipx then targetx(a) = targetx(a) + 2: targetdir(a) = 1
        if targetx(a) > shipx then targetx(a) = targetx(a) - 2: targetdir(a) = 3
        if targety(a) < shipy then targety(a) = targety(a) + 3: targetdir(a) = 2
        if targety(a) > shipy then targety(a) = targety(a) - 3: targetdir(a) = 0
    end if
    end if
    if targetx(a) < -5000 then targetx(a) = -5000
    if targetx(a) > 5000 then targetx(a) = 5000
    if targety(a) < -5000 then targety(a) = -5000
    if targety(a) > 5000 then targety(a) = 5000
    
    fxmin = targetx(a): fxmax = targetx(a) + 31
    fymin = targety(a): fymax = targety(a) + 31
    for b as integer = 0 to 2
        if projactive(b) = 1 and targetactive(a) = 1 and projx(b) >= fxmin and projx(b) <= fxmax and projy(b) >= fymin and projy(b) <= fymax then
            targetactive(a) = 2: projactive(b) = 0: gold = gold + 10: score = score + ((level * ((a mod 5)+1))*100)
        end if
    next b
next a

    'You hit Mothership
    for a as integer = 0 to 2
        fxmin = mshipx: fxmax = mshipx+127
        fymin = mshipy: fymax = mshipy+127
        if projactive(a) = 1 and mshipactive = 1 and mshiphp > 0 and projx(a) >= fxmin and projx(a) <= fxmax and projy(a) >= fymin and projy(a) <= fymax then
            mshiphp = mshiphp - 1
            projactive(a) = 0
            gold = gold + 50
            screenset 1,1
                if mshipdir = 0 then put(mshipx-offsetx+4,mshipy-offsety+1),mshipup
                if mshipdir = 1 then put(mshipx-offsetx+4,mshipy-offsety-1),mshipright
                if mshipdir = 2 then put(mshipx-offsetx+4,mshipy-offsety+4),mshipdown
                if mshipdir = 3 then put(mshipx-offsetx+4,mshipy-offsety-4),mshipleft
                sleep 100
            screenset 1,0
        end if
    next a
    
    
    if mshipactive = 1 and mshiphp = 0 then
                    screenset 1,1
                for a as integer = 1 to 500
                    circle (mshipx-offsetx+64, mshipy-offsety+64),a, 16+((a/500)*16),,,,f
                    sleep 5
                next a
                
                        for a as integer = 0 to 9 
                            for b as integer = 0 to 479 step 10
                                line (0,b+a)-step(640,0),0
                            next b
                            sleep 100
                        next a
                        
                        color ,0: cls
                        
                   
                        
                        
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
            
            BigPrint(3,3,"You have defeated the mothership")
            sleep 2000
            BigPrint(5,3,"and finished the game.  There is now")
            sleep 2000
            BigPrint(7,3,"peace in the Planets of Mystery.")
            sleep 2000
            sleep 4000
            BigPrint(15,3,"Thank you for playing this game.")
            sleep 2000
            BigPrint(17,3,"Have a nice day and God Bless!")
            sleep 2000
            BigPrint(19,3,"Press any key.")
            sleep 


                        
                        
                        
                end
    
    
    end if
    
    
   'Mothership hits you 
   fxmin = mshipx: fxmax = mshipx+127
   fymin = mshipy: fymax = mshipy+127
   for a as integer = 0 to 9
   if targetactive(a) > 0 and shipactive = 1 and shipx >= fxmin and shipx <= fxmax and shipy >= fymin and shipy <= fymax and shiphealthdelay < 2 then
        hp = int(hp - (hpmax/2))
        shiphealthdelay = 100
   end if
   next a
   
   'Big Blob hits you
   if mshippd > 1 then
       
    if abs(shipx-mshippx)^2 + abs(shipy-mshippy)^2 < mshippd ^ 2 then hp = 0
   
   end if
   
   
   
   
    
for a as integer = 0 to 9
    fxmin = targetx(a): fxmax = targetx(a) + 31
    fymin = targety(a): fymax = targety(a) + 31
    if targetactive(a) > 0 and shipactive = 1 and shipx >= fxmin and shipx <= fxmax and shipy >= fymin and shipy <= fymax and shiphealthdelay < 2 then

        'shipactive = 2
        hp = int(hp - (hpmax/4))
        'deaddelay = 1
        shiphealthdelay = 100
        'if direction = 0 then shipy = shipy + 64
        'if direction = 1 then shipx = shipx - 64
        'if direction = 2 then shipy = shipy - 64
        'if direction = 3 then shipx = shipx + 64
    end if
next a  

    if hp <= 0 then
        screenset 1,1
      put (shipx-offsetx,shipy-offsety),xplode,(32*0,0)-((32*0)+31,31),trans

      sleep 250
    put (shipx-offsetx,shipy-offsety),xplode,(32*1,0)-((32*1)+31,31),trans

      sleep 250
    put (shipx-offsetx,shipy-offsety),xplode,(32*2,0)-((32*2)+31,31),trans

      sleep 250
   put (shipx-offsetx,shipy-offsety),xplode,(32*1,0)-((32*1)+31,31),trans

      sleep 250
    put (shipx-offsetx,shipy-offsety),xplode,(32*0,0)-((32*0)+31,31),trans

      sleep 250

        'for a as integer = 1 to 25
        '    put (shipx+1,shipy+1),uinbattle
        '    sleep 25
        'next a


        MakeBox(1,13,9,16,75,1,15,7)
        BigPrint (12,4,"You have been destroyed.")
        sleep 1000
        BigPrint (14,4,"You lose, good day sir!")
        sleep
        completionflag = 0
        hp = hpmax
                 shipx = 320
         shipy = 240
         offsetx = 0
         offsety = 0
         for a as integer = 0 to 99
            starsx(a) = int(rnd * 640)
            starsy(a) = int(rnd * 480)
         next a

        screenset 1,0
        goto RealMainMenu
    end if

if shipactive > 1 then 
    shipactive = shipactive + 1
     if shipactive = 21 then 
         shipactive = 0
         deaddelay = 10
         'shipx = 320
         'shipy = 240
         'offsetx = 0
         'offsety = 0
         'for a as integer = 0 to 99
         '   starsx(a) = int(rnd * 640)
         '   starsy(a) = int(rnd * 480)
        'fanext a
    end if
end if


for a as integer = 0 to 9
if targetactive(a) = 1 then goto KeepGoing
next a

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

'level = level + 1
'deaddelay = 100
shipactive = 0

KeepGoing:
tindex = 0
for a as integer = 0 to 9
    if targetactive(a) = 0 then tindex = tindex + 1
next a
if tindex > 2 then
    for a as integer = 0 to 9
        if targetactive(a) = 0 then 
            targetx(a) = int(rnd * 10000)-5000
            targety(a) = int(rnd * 10000)-5000
            targetdir(a) = int(rnd * 4)
            targetactive(a) = 1
        end if
    next a
end if





 if deaddelay > 0 then deaddelay = deaddelay - 1: if deaddelay = 0 then shipactive = 1
if firedelay > 0 then firedelay = firedelay - 1
sleep 10
hp = hp + .01: if hp > hpmax then hp = hpmax
spacedelay = spacedelay + 1: if spacedelay > 300 then spacedelay = 300
shiphealthdelay = shiphealthdelay - 1: if shiphealthdelay < 0 then shiphealthdelay = 0
goto LoopStart

sleep
