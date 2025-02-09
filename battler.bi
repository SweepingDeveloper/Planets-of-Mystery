sub Battler

'*********************BATTLE CODE****************************************

'Battler:
gameoverflag = 0
screenset 1,1
      spcoord = spcode(xtile,ytile) mod 100
      spx = (spcoord mod 8)*32
      spy = (int(spcoord / 8))*32

if npcbattle = 0 then        'Effect used when starting a random battle. 
    for a as integer = 1 to 25
    put (((xtile-xstart)*32)+xoffset+1,((ytile-ystart)*32)+yoffset+1), sprite, (spx,spy)-(spx+31,spy+31)
    sleep 50
    next a
    for a as integer = 1 to 640
    circle (((xtile-xstart)*32)+xoffset+17,((ytile-ystart)*32)+yoffset+17),a,0, , , , F
    sleep 2
    next a
end if
if npcbattle = 1 then        'Effect used when starting an NPC battle.
    for a as integer = 0 to 239
        for b = 0 to 480 step 240
            line (0,b+a)-step(640,0),0
        next b
        sleep 5
    next a
end if

'The game randomly chooses an opponent for you to fight, based on what screen
'you're in.  If it's an NPC battle, the opponent is already chosen.
PickEnemy:         

'The game crashes at this moment.
if npcbattle = 0 then 
    epick = int(rnd * 9)
for a as integer = 0 to (enums-1)
    if enemyfile(a) = enemyname(epick) then epick = a
next a
end if
'epick = int(rnd * 9)
'if npcbattle = 1 then epick = 0

EnemyFound:
'Set up the stats.  You get 3 extra attack and defense points for each 
'level you gain.
batk = atk + (3*(level-1))
bdef = def + (3*(level-1))
bacc = acc
ebhp = ehp(epick)
ebhpmax = ehp(epick)
ebdf = edef(epick)
inbattle = 1
print "Enemy stats found..."
'Set up the playing field.
cls
DrawSprite("heror1.pix",0,0,128)
get (0,0)-(127,127),uinbattle
cls
DrawSprite("herors.pix",0,0,128)
get (0,0)-(127,127),u2inbattle
cls
DrawSprite("heror1.pix",0,0,128)
get (0,0)-(127,127),usword
cls
DrawSprite("mands.pix",0,0,128)
get (0,0)-(127,127),usword2
cls
DrawSprite("sword1.pix",0,0,128)
get (0,0)-(127,127),sword1
cls
DrawSprite("sword2.pix",0,0,128)
get (0,0)-(127,127),sword2
cls
DrawSprite("sword3.pix",0,0,128)
get (0,0)-(127,127),sword3

cls
DrawSprite(enemyfile(epick)+".pix",0,0,128)
get (0,0)-(127,127),enemyinbattle
cls
DrawSprite("yoyo.pix",0,0,64)
get (0,0)-(63,63),yoyo
cls
DrawSprite("boom1.pix",0,0,32)
get (0,0)-(31,31),boom1
cls
DrawSprite("boom2.pix",0,0,32)
get (0,0)-(31,31),boom2
cls
DrawSprite("boom3.pix",0,0,32)
get (0,0)-(31,31),boom3
cls
DrawSprite("boom4.pix",0,0,32)
get (0,0)-(31,31),boom4
if npcbattle = 0 then 
for a as integer = 0 to 79
    put ((a mod 20)*32,((int(a/20))*32)+128), sprite, (spx,spy)-(spx+31,spy+31)
next a
end if
if npcbattle = 1 then 
for a as integer = 0 to 79
    put ((a mod 20)*32,((int(a/20))*32)+128), sprite, (0,0)-(31,31)
next a
end if
put (32,32),uinbattle,trans
put (448,32),enemyinbattle,trans

BigPrint (12,4,"You have encountered a "+ ename(epick) + "!")
'********************************************
'The following is a really helpful piece of code right here.
'There are hardcore gamers that like to press keys rapidly
'and hold keys.  Using this piece of code, the game will wait
'until you're not pressing any keys, then it will continue.
'This will save you a bunch of testing headaches in the future.
do: loop until inkey$ = ""  
'*******************************************
sleep 1000
BattleMainMenu:
cls
if npcbattle = 0 then 
for a as integer = 0 to 79
    put ((a mod 20)*32,((int(a/20))*32)+128), sprite, (spx,spy)-(spx+31,spy+31)
next a
end if
if npcbattle = 1 then 
for a as integer = 0 to 79
    put ((a mod 20)*32,((int(a/20))*32)+128), sprite, (0,0)-(31,31)
next a
end if
put (32,32),uinbattle,trans
put (448,32),enemyinbattle,trans
line (578,162)-step(16,-128),8,bf
line (576,160)-step(16,-128),7,bf
line (576,160)-step(16,-((ebhp/ebhpmax)*128)),15,bf
MakeBox(1,16,2,22,35,1,15,7)
locate 2,1: print "                                                                          "
'locate 1,1: print using "YOUR ATK ### DEF ### ACC ###  ENEMY DEF ###"; batk; bdef; bacc; ebdf
BigPrint(1,1,"HP:"+str(hp)+"/"+str(hpmax)+ "  SP:"+str(ssp)+"/"+str(spmax))

choice(1) = "Blaster"
choicer(1) = 15:choicec(1) = 1
choice(2) = "ssp. Weapon"
choicer(2) = 16:choicec(2) = 1
choice(3) = "Item"
choicer(3) = 17:choicec(3) = 1
choice(4) = "Rest"
choicer(4) = 18:choicec(4) = 1
choice(5) = "Run Away!"
choicer(5) = 19:choicec(5) = 1

'BigPrint(15,1,"Blaster")
'BigPrint(16,1,"ssp. Weapon")
'BigPrint(17,1,"Item")
'BigPrint(18,1,"Rest")
'BigPrint(19,1,"Run Away!")

for aa = 1 to 5
    BigPrint(choicer(aa),choicec(aa),choice(aa))
next aa

cursor = 1 
MakeChoice(5)

if cursor = 1 then              'Blaster
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint (12,4,"You use your blaster.")
    sleep 1000
    'fbs_Play_Wave(laser,1)

    put (32,32),uinbattle
    put (32,32),u2inbattle
    for a as integer = 160 to 448 step 8
        put (a,96),ammo,(32,0)-(63,31)
        sleep 5
    next a
    for a as integer = 160 to 448 step 8
        put (a,96),ammo,(32,0)-(63,31)
        sleep 2
    next a
    
    attack = batk - (edef(epick)/2)  
    attchance = int(rnd * attack)+1
    attack = attack * .75 + attchance

    if attack <= 0 then attack = level
    
    
    accchance = int(rnd * 100)+1
    'locate 27, 1: print using "Accuracy Level: ###"; accchance
    if accchance > bacc * .75 and accchance <= bacc then attack = attack * .75
    if accchance > bacc and accchance < bacc+((100-bacc)/2) then attack = attack / 2
    if accchance > bacc+((100-acc)/2) then attack = 0
    'locate 28, 1: print using "Attack Power: ###"; attack
    
    
    if attack <= 0 then BigPrint (13,4,"You missed!"): sleep 1000
    if attack > 0 then
        ebhp = ebhp - attack
    
        line (578,162)-step(16,-128),8,bf
        line (576,160)-step(16,-128),7,bf
        if ebhp > 0 then 
            line (576,160)-step(16,-((ebhp/ebhpmax)*128)),15,bf
        end if
        for a as integer = 1 to 25
           put (448,32),enemyinbattle
           sleep 10
        next a
        put (448,32),enemyinbattle,trans
        BigPrint (14,4,"Your blaster does "+ str(attack) + "HP damage.")
        sleep 1000
    end if
            if ebhp <= 0 then
            battlewin = 1
        for a as integer = 1 to 25
           put (448+1,32+1),enemyinbattle
           sleep 25
        next a
        'for a as integer = 40 to 79
        '    put ((a mod 20)*32,((int(a/20))*32)+128), sprite, (spx,spy)-(spx+31,spy+31),trans
        'next a
        
        MakeBox(1,13,9,16,75,1,15,7)
        BigPrint (12,4,"The "+ename(epick)+ " has been destroyed!")
        sleep 1000
        BigPrint (14,4,"You gain "+ str(eexpget(epick)) + "EXP and $" + str(ereward(epick))+ "!")
        experience = experience + eexpget(epick)
        gold = gold + ereward(epick)
        if experience >= expmax then 
            expmax = int(expmax * 2.1)
            level = level + 1
            sleep 1000
            MakeBox(1,13,9,21,75,1,15,7)
        
            BigPrint (12,4,"You have leveled up to level "+ str(level)+ "!")
            sleep 2000
            BigPrint (14,4,str(int(hpmax*1.1))+ " HP")
            BigPrint (15,4,str(int(spmax*1.1))+ " ssp")
            BigPrint (16,4,str(int(atk*1.1))+ " ATK")
            BigPrint (17,4,str(int(def*1.1))+ " DEF")
            BigPrint (19,4,"Press any key to continue!")
            hpmax = int(hpmax*1.2): hp = hpmax
            spmax = int(spmax*1.2): ssp = spmax
            atk = int(atk*1.2)
            def = int(def*1.2)
        end if
    do: loop until inkey$ = ""
    sleep 4000


    goto EndofBattle
    
end if
goto EnemyTurn
end if 

if cursor = 2 then      'Special Weapon
    cursor = 1 
    MakeBox(1,16,7,25,35,1,15,7)
    if spweapon(1) = 1 then choice(1) = "Sword" else choice(1) = "Nothing"
    if spweapon(5) = 1 then choice(1) = "Super Sword"
    if spweapon(2) = 1 then choice(2) = "Boomerang" else choice(2) = "Nothing"
    if spweapon(6) = 1 then choice(2) = "Superang"
    if spweapon(3) = 1 then choice(3) = "Smokescreen" else choice(3) = "Nothing"
    if spweapon(4) = 1 then choice(4) = "Energy" else choice(4) = "Nothing"
    choicer(1) = 15: choicec(1) = 4
    choicer(2) = 16: choicec(2) = 4
    choicer(3) = 17: choicec(3) = 4
    choicer(4) = 18: choicec(4) = 4
    for a as integer = 1 to 4
        BigPrint(choicer(a),choicec(a),choice(a))
    next a
    MakeChoice(4)
    rpindex = 7: SpWeaponEffects
    if cursor = 3 and spweapon(3) = 1 and ssp > 0 then
        for a as integer = 32 to -64 step -8
            put (a,32),uinbattle
            put (a-8,32),uinbattle
            sleep 25
        next a
        goto EndofBattle     

    end if
    if ssp < 0 then ssp = ssp + 25
    RP7:
    
    
            if ebhp <= 0 then
            battlewin = 1
        for a as integer = 1 to 25
           put (448+1,32+1),enemyinbattle
           sleep 25
        next a
        'for a as integer = 40 to 79
        '    put ((a mod 20)*32,((int(a/20))*32)+128), sprite, (spx,spy)-(spx+31,spy+31),trans
        'next a
'fbs_Stop()
'fbs_Load_MP3File("audio\battlewin.mp3",rotatesong)
'fbs_Play_Wave(rotatesong,100)


        MakeBox(1,13,9,16,75,1,15,7)
        BigPrint (12,4,"The "+ename(epick)+ " has been destroyed!")
        sleep 1000
        BigPrint (14,4,"You gain "+ str(eexpget(epick)) + "EXP and $" + str(ereward(epick))+ "!")
        experience = experience + eexpget(epick)
        gold = gold + ereward(epick)
        if experience >= expmax then 
            expmax = int(expmax * 2.1)
            level = level + 1
            sleep 1000
            MakeBox(1,13,9,21,75,1,15,7)
        
            BigPrint (12,4,"You have leveled up to level "+ str(level)+ "!")
            sleep 2000
            BigPrint (14,4,str(int(hpmax*1.1))+ " HP")
            BigPrint (15,4,str(int(spmax*1.1))+ " ssp")
            BigPrint (16,4,str(int(atk*1.1))+ " ATK")
            BigPrint (17,4,str(int(def*1.1))+ " DEF")
            BigPrint (19,4,"Press any key to continue!")
            hpmax = int(hpmax*1.2): hp = hpmax
            spmax = int(spmax*1.2): ssp = spmax
            atk = int(atk*1.2)
            def = int(def*1.2)
        end if
    do: loop until inkey$ = ""
    sleep 4000

    goto EndofBattle
end if
goto EnemyTurn
end if






if cursor = 3 then     'Use Item
    cursor = 1
    
    
    
    

    MakeBox(0,480,288,639,500,3,15,0)
    MakeBox(2,17,30,18,39,1,15,0)
    BigPrint(17,30,"INVENTORY")
    
    
    
    for aa = 1 to 9
        choice(aa) = ""
        for b = 1 to len(inventory(aa))
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
        if left$(inventory(aa),8) = "Corn.Dog" then DrawSprite("corndog.pix",ix,iy,32)
        if left$(inventory(aa),5) = "Blank" then DrawSprite("bbox.pix",ix,iy,32)
        if left$(inventory(aa),7) = "Red.Key" then DrawSprite("redkey.pix",ix,iy,32)
        if left$(inventory(aa),10) = "Yellow.Key" then DrawSprite("yelwkey.pix",ix,iy,32)
        if left$(inventory(aa),9) = "Green.Key" then DrawSprite("grenkey.pix",ix,iy,32)
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
    MakeBox(2,28,25,29,39,1,15,0)
    BigPrint(28,25,choice(cursor))
    Selection5:
    line (486+ ((cursor-1) mod 3) * 48,298 + int((cursor-1)/3)* 48)-step(36,36),15,b

    z = inkey$: if z = "" then goto Selection5
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

loop until z = " "








    
    
    
    'MakeBox(1,16,7,25,35,1,15,7)
    'for aa = 1 to 9
    '    choice(aa) = ""
    '    for b = 1 to len(inventory(aa))
    '        if mid$(inventory(aa),b,1) <> "." then choice(aa) =  choice(aa) + mid$(inventory(aa),b,1)
    '        if mid$(inventory(aa),b,1) = "." then choice(aa) = choice(aa) + " "
    '    next b
    '    choice(aa) = inventory(aa)
    '    choicer(aa) = 14+aa: choicec(aa) = 4
    '    BigPrint(choicer(aa),choicec(aa),choice(aa))
    'next aa

    'MakeChoice(9):
    'rpindex = 6: goto ItemEffects
    RP6:
    ItemEffects
    if itemused = 1 then goto EnemyTurn else goto BattleMainMenu
end if

if cursor = 4 then     'Rest
    MakeBox(1,13,9,16,75,1,15,7)
    if int(hp * 1.1) < hpmax then BigPrint (12,4,"You rest and gain "+ str(int(hpmax*.1)) + "HP.")
    if int(hp * 1.1) >= hpmax then BigPrint (12,4,"You have no need to rest.")
    if int(hp * 1.1) < hpmax then hp = hp + int(hpmax * .1)
    sleep 1000
    goto EnemyTurn
end if

if cursor = 5 then
    escapechance = int(rnd * (hp+ebhp))+1
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint (12,4,"You attempt to escape...")
    sleep 2000
    if escapechance < hp then
    for a as integer = 32 to -64 step -8
        put (a,32),uinbattle
        put (a-8,32),uinbattle
        sleep 25
    next a
    goto EndofBattle     
    end if
    BigPrint (13,4,"You can't escape!")
    sleep 1000
    goto EnemyTurn
end if



goto BattleMainMenu




EnemyTurn:
sleep 1000
locate 2,1: print "                                                                          "
BigPrint(1,1,"HP:"+str(hp)+"/"+str(hpmax)+ "  ssp:"+str(ssp)+"/"+str(spmax))
line (578,162)-step(16,-128),8,bf
line (576,160)-step(16,-128),7,bf
line (576,160)-step(16,-((ebhp/ebhpmax)*128)),15,bf

if distraction > 0 then
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"The "+ename(epick)+" is distracted!")
    sleep 1000
    for a as integer = 1 to 5
    put (460+int(rnd * 16)-8,32+int(rnd * 16)-8),enemyinbattle
    sleep 100
    next a
    sleep 1000
    distraction = distraction - 1
    goto BattleMainMenu
end if

echance = int(rnd * (ewchance(epick,0)+ewchance(epick,1)+ewchance(epick,2)))+1
if echance <= ewchance(epick,0) then ewuse = eweapon(epick,0)
if echance > ewchance(epick,0) and echance <= ewchance(epick,0)+ewchance(epick,1)  then ewuse = eweapon(epick,1)
if echance > ewchance(epick,0)+ewchance(epick,1) then ewuse = eweapon(epick,2)

MakeBox(1,13,9,16,75,1,15,7)

if ewuse = 0 and int(ebhp * 1.1) < ehp(epick) then BigPrint (12,4,"The "+ename(epick)+" rests and gains "+ str(int(ebhp* .1)) + "HP."): ebhp = ebhp + int(ebhp * .1): sleep 2000

if ewuse = 1 then            'Tackle
    BigPrint(12,4,"The "+ename(epick)+" tackles you!")
    sleep 1000

    'fbs_Play_Wave(tackle)

    for a as integer = 448 to 176 step -16
        put (a,32),enemyinbattle
        put (a-16,32),enemyinbattle
        sleep 10
    next a
    for a as integer = 160 to 400 step 16
        put (a,32),enemyinbattle
        put (a+16,32),enemyinbattle
        sleep 10
    next a
    
    
    attack = eatk(epick) - (bdef/2)
    attchance = int(rnd * attack)+1
    attack = attack * .75 + attchance
    
    accchance = int(rnd * 100)+1
    if accchance > acc and accchance < acc+((100-acc)/2) then attack = attack / 2
    if accchance > acc+((100-acc)/2) then attack = 0
    'locate 27,1: print using "Attack Power: ###"; attack
    if attack <= 0 then BigPrint (13,4,"You must be as hard as a rock!"): sleep 1000
    if attack > 0 then
        for a as integer = 1 to 24
            put (32,32),uinbattle
        sleep 10
        next a
        BigPrint (13,4,"The "+ename(epick)+" does "+ str(attack) + "HP damage.")
        hp = hp - attack
        sleep 1000
     end if
end if
    
if ewuse = 2 then           'Green Laser
    BigPrint(12,4,"The "+ename(epick)+" fires a laser at you!")
    sleep 1000

    for a as integer = 1 to 25
        color 2: line (100+int(rnd * 32),32+int(rnd*64))-step(288,int(rnd * 3)-1)
        color 10: line (100+int(rnd * 32),32+int(rnd*64))-step(288,int(rnd * 3)-1)
        sleep 10
    next a
    attack = eatk(epick) - (bdef/2)
    attchance = int(rnd * attack)+1
    attack = attack * .75 + attchance
    attack = attack * 1.5
    accchance = int(rnd * 100)+1
    if accchance > acc and accchance < acc+((100-acc)/2) then attack = attack / 2
    if accchance > acc+((100-acc)/2) then attack = 0
    if attack <= 0 then BigPrint (13,4,"The laser does no damage."): sleep 1000
    if attack > 0 then
        for a as integer = 1 to 24
            put (32,32),uinbattle
            sleep 10
        next a
            BigPrint (13,4,"The "+ename(epick)+" does "+ str(attack) + "HP damage.")
            hp = hp - attack
        sleep 1000
    end if
end if

if ewuse = 3 then          'Yellow Laser
    BigPrint(12,4,"The "+ename(epick)+" fires a laser at you!")
    sleep 1000

    for a as integer = 1 to 25
        color 6: line (100+int(rnd * 32),32+int(rnd*64))-step(288,int(rnd * 3)-1)
        color 14: line (100+int(rnd * 32),32+int(rnd*64))-step(288,int(rnd * 3)-1)
        sleep 10
    next a
    attack = eatk(epick) - (bdef/2)
    attchance = int(rnd * attack)+1
    attack = attack * .75 + attchance
    attack = attack * 1.25
    accchance = int(rnd * 100)+1
    if accchance > acc and accchance < acc+((100-acc)/2) then attack = attack / 2
    if accchance > acc+((100-acc)/2) then attack = 0
    if attack <= 0 then BigPrint (13,4,"The laser does no damage."): sleep 1000
    if attack > 0 then
        for a as integer = 1 to 24
            put (32,32),uinbattle
            sleep 10
        next a
        BigPrint (13,4,"The "+ename(epick)+" does "+ str(attack) + "HP damage.")
        hp = hp - attack
        sleep 1000
    end if
end if

if ewuse = 4 then         'Yo-Yo
    BigPrint(12,4,"The "+ename(epick)+"'s got a yo-yo!")
    sleep 1000


    put (448,32),yoyo
    for a as integer = 448 to 176 step -16
        color int(rnd * 16)+15: line (448,64)-step(-abs(448-a),0)
        put (a,32),yoyo
        put (a-16,32),yoyo
        sleep 10
    next a
    for a as integer = 160 to 448 step 16
        color int(rnd * 16)+15: line (448,64)-step(-abs(448-a),0)
        put (a,32),yoyo
        put (a+16,32),yoyo
        sleep 10
    next a
    attack = eatk(epick) - (bdef/2)
    attchance = int(rnd * attack)+1
    attack = attack * .75 + attchance
    attack = attack * 1.65
    accchance = int(rnd * 100)+1
    if accchance > acc and accchance < acc+((100-acc)/2) then attack = attack / 2
    if accchance > acc+((100-acc)/2) then attack = 0
    if attack <= 0 then BigPrint (13,4,"Wow, like that hurt?"): sleep 1000
    if attack > 0 then
        for a as integer = 1 to 24
            put (32,32),uinbattle
            sleep 10
        next a
        BigPrint (14,4,"The "+ename(epick)+" does "+ str(attack) + "HP damage.")
        hp = hp - attack
        sleep 1000
    end if    
end if

if ewuse = 5 then        'Lightning
    BigPrint(12,4,"The "+ename(epick)+" uses super awesome lightning!")
    sleep 1000

    for a as integer = 1 to 24
        color 15: line (100+int(rnd * 32),32+int(rnd*64))-(380+int(rnd*64),32+int(rnd*64))
        color 15: line (100+int(rnd * 32),32+int(rnd*64))-(380+int(rnd*64),32+int(rnd*64))
        sleep 10
    next a
    attchance = int(rnd * (eatk(epick)+bdef))+1
    attack = eatk(epick) - (attchance/2)
    attack = attack * 2
    accchance = int(rnd * 100)+1
    if accchance > acc and accchance < acc+((100-acc)/2) then attack = attack / 2
    if accchance > acc+((100-acc)/2) then attack = 0
    if attack <= 0 then BigPrint (13,4,"The "+ename(epick)+" missed!"): sleep 1000
    if attack > 0 then
        for a as integer = 1 to 24
            put (32,32),uinbattle
            sleep 10
        next a
        BigPrint (14,4,"The "+ename(epick)+" does "+ str(attack) + "HP damage.")
        hp = hp - attack
        sleep 1000
    end if
end if

if ewuse = 6 and int(ebhp * 1.5) < ehp(epick) then    'Heal
    line (578,162)-step(16,-128),8,bf
    line (576,160)-step(16,-128),7,bf
    if ebhp > 0 then 
        line (576,160)-step(16,-((ebhp/ebhpmax)*128)),15,bf
    end if
    BigPrint (12,4,"The "+ename(epick)+" uses heal and gains "+ str(int(ebhp* .5)) + "HP."):  ebhp = ebhp + int(ehp(epick) * .5):sleep 2000
end if

if ewuse = 7 then            'Stomp
    BigPrint(12,4,"The "+ename(epick)+" makes one giant leap!")
    sleep 1000
 

    for a as integer = 32 to -64 step -8
        put (448,a),enemyinbattle
        put (448,a-8),enemyinbattle
        sleep 10
    next a
    for a as integer = -64 to 32 step 16
        put (448,a),enemyinbattle
        put (448,a+8),enemyinbattle
        sleep 10
    next a
    get (0,0)-(640,480),screenshot

    for a as integer = 1 to 25
        put (int(rnd * 16)-8,int(rnd * 16)-8), screenshot, trans
        sleep 25
    next a
    put (0,0),screenshot, trans
    MakeBox(1,13,9,15,75,1,15,7)
    attack = eatk(epick) - (bdef/2)
    attchance = int(rnd * attack)+1
    attack = attack * .75 + attchance
    attack = attack * .60
    accchance = int(rnd * 100)+1
    if accchance > acc and accchance < acc+((100-acc)/2) then attack = attack / 2
    if accchance > acc+((100-acc)/2) then attack = 0
    if attack <= 0 then BigPrint (13,4,"You got nice shoes on?"): sleep 1000
    if attack > 0 then
        for a as integer = 1 to 24
            put (32,32),uinbattle
            sleep 10
        next a
        BigPrint (13,4,"The "+ename(epick)+" does "+ str(attack) + "HP damage.")
        hp = hp - attack
        sleep 1000
    end if
end if


if hp <= 0 then
    MakeBox(1,13,9,16,75,1,15,7)
    for a as integer = 1 to 25
        put (32+1,32+1),uinbattle
        sleep 25
    next a
    
 

'fbs_Stop()
'fbs_Load_MP3File("audio\gameover.mp3",rotatesong)
'fbs_Play_Wave(rotatesong,1)


        BigPrint (12,4,"You have been destroyed.")
        sleep 1000
        BigPrint (14,4,"You lose, good day sir!")
        sleep 2000

        if npcbattle = 1 then hp = bhp: battlewin = -1: goto EndofBattle
        hp = hpmax
        'gold = int(gold*.5)
        gameoverflag = 1
        'goto RealMainMenu
        goto EndofBattle
end if

sleep 1000

goto BattleMainMenu

EndofBattle:
repellant = 3
for a as integer = 16 to 31 
color 15,a: cls
sleep 25
next a

for aa = 640 to 1 step -32
put (0,0),screenshot,trans
    ccx = ((xtile-xstart)*32)+xoffset+17
    ccy = ((ytile-ystart)*32)+yoffset+17
circle (ccx,ccy),aa,15,,,,F
sleep 25
next aa

screenset 1,0
grasschance = 0

if npcbattle = 1 then goto EndofBattler

'goto LoopStart2
'gosub EndofBattler
EndofBattler:

    
    
end sub

