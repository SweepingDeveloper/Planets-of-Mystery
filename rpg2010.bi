'#INCLUDE "fmod.bi"
' Initialise FMOD with 48000Hz, 8 channels.
'FSOUND_Init(48000, 8, 0)


'Patch Code
'dim shared a as integer
dim shared b as integer
dim shared c as integer
dim shared d as integer
dim shared e as integer
dim shared diag as integer
dim shared xmin as integer
dim shared xmax as integer
dim shared z as string
dim shared fx as integer
dim shared fy as integer 
dim shared scolor as integer
dim shared spacepatch as integer
dim shared ymin as integer
dim shared ymax as integer
dim shared fxmin as integer
dim shared fxmax as integer
dim shared fymin as integer
dim shared fymax as integer
dim shared tindex as integer
dim shared x as integer
dim shared loadflag as integer
dim shared spx as integer
dim shared spy as integer
dim shared inbattle as integer
dim shared npcbattle as integer
dim shared xtile as integer
dim shared ytile as integer
dim shared xint as integer, yint as integer, zint as integer
dim shared spcoord as integer
dim shared linecount as integer
dim shared iflag as integer
dim shared ink as string
dim shared zz as integer
dim shared shadow as integer
dim shared endcursor as integer
dim shared r1 as integer,r2 as integer, r3 as integer
dim shared health as integer
dim shared index as integer
dim shared gameoverflag as integer = 0
dim shared spacedelay as integer
dim shared ninflag as integer
dim shared itemamt as integer
dim shared bhp as integer
dim shared battlewin as integer
dim shared fpscount as integer
dim shared swordmode as integer
dim shared rotatesong as uinteger
dim shared xstart as integer
dim shared sword as integer
'dim shared epick as integer
'dim shared enums as integer
'dim shared enemyfile(100) as string
dim shared batk as integer
dim shared bdef as integer
dim shared bacc as integer
'dim shared enemyname as string
dim shared level as integer
dim shared ebhp as integer
dim shared ebhpmax as integer
dim shared ebdf as integer
dim shared attchance as integer
dim shared attack as integer
dim shared song as string
dim shared accchance as integer
dim shared itemused as integer
dim shared escapechance as integer
dim shared distraction as integer
dim shared echance as integer
dim shared aa as integer
dim shared ccx as integer
dim shared ccy as integer
dim shared rpindex as integer
dim shared now as integer
dim shared fps as integer
dim shared hsound as integer
dim shared npcvar(99) as integer
dim shared shiphealthdelay as integer = 0
'dim shared fpscount as integer

'defint a-z,A-Z
'STARSHIP VARIABLES
dim shared fonttext as string                                       'Text Font
dim shared textfont(24576) as integer                               ''
dim shared redtextfont(24576) as integer                            ''
dim shared ship(16384) as integer,vship(16384) as integer,enemy(4096) as integer,ammo(4096) as integer,xplode(3072) as integer,landmass(98304) as integer 'Sprite Arrays
dim shared shipdock(3072) as integer                                                  '
dim shared starsx(100) as integer,starsy(100)   as integer                                       'Stars
dim shared targetx(10) as integer,targety(10) as integer,targetdir(10) as integer, targetactive(10)  as integer        'Space Opponents

dim shared mshipx as integer, mshipy as integer, mshipdir as integer, mshiphp as integer
dim shared mshippx as integer, mshippy as integer, mshippd as integer
dim shared mshippactive as integer


dim shared planetx(3) as integer,planety(3) as integer, planetcolor(3) as integer, planetsize(3)  as integer           'Planets
dim shared ani as single = 1.0                                             'Animation Variable
dim shared projactive(3) as integer, projx(3) as integer                   'Projectiles
dim shared projy(3) as integer, projdir(3) as integer                      ''
dim shared shipx as integer = 320, shipy as integer = 220                  'Real Ship Position
dim shared offsetx as integer = 0, offsety as integer = 0                  'Camera Offset
dim shared direction as integer = 0                                        'Ship Direction
dim shared rotationpoint(32,32) as integer
dim shared firedelay as integer = 0:dim deaddelay as integer = 0                                         'Delays for certain events
dim shared score as integer = 0
dim shared lives as integer = 3
'dim level as integer = 1                                       'Score, lives, level
level = 1
dim shipactive as integer = 1                                                      'Is the ship active?
dim oldsong as string




'RPG VARIABLES
dim shared cursor as integer
dim shared sprite(32768) as uinteger
dim shared csprite(16384) as uinteger
dim shared sword1(16384) as uinteger
dim shared sword2(16384) as uinteger
dim shared sword3(16384) as uinteger

'dim esprite(81920) as integer  'Enemy Sprites
'dim epsprite(10240) as integer 'Projectile Sprites
dim shared sspriteu(1024) as uinteger
dim shared ssprited(1024) as uinteger
dim shared sspritel(1024) as uinteger
dim shared sspriter(1024) as uinteger
dim shared sprite0(1024) as uinteger
dim shared backpack(1024) as uinteger
dim shared mechbug(1024) as uinteger
dim shared screenshot(307200) as uinteger
dim shared spname(32) as string
dim shared borderxstart(4) as integer
dim shared borderystart(4) as integer
dim shared ecode(10) as string
dim shared m as integer
dim shared y as integer
dim shared filenames(1000) as string
dim shared spcode(100,100) as integer
dim shared cfname(10) as string
dim shared charas(16) as string
dim shared charsw(4) as string
dim shared npcname as string: npcname = "null"
dim shared scriptline(1000) as string
dim shared prescriptline(1000) as string
dim shared scriptindex as integer
dim shared bunpcindex as integer
dim shared startstatus as integer
dim shared inventory(20) as string, inventorytitle(20) as string, inventorydesc(20) as string
dim shared  ninventory(50) as string,ninventorytitle(50) as string, ninventorydesc(50) as string
dim shared spweapon(10) as integer
for a as integer = 0 to 9: spweapon(a) = 0: next a
dim shared comvar(10) as integer  'Placeholders for health, money, etc.
dim shared scriptvar(10) as string
dim shared dow as integer

dim shared inventoryuse as string
dim shared choice(10) as string
dim shared sel as integer
dim shared selected as integer
dim shared enemyname(10) as string
dim shared activefile as string
dim shared newname as string
dim shared txt as string
dim shared nborder as string
dim shared sborder as string
dim shared eborder as string
dim shared wborder as string
dim shared crap(12) as string
dim shared numofcommands as integer
dim shared gamecommand(1000) as string
dim shared choicer(10) as integer
dim shared choicec(10) as integer
dim shared boom1(1024) as uinteger
dim shared boom2(1024) as uinteger
dim shared boom3(1024) as uinteger
dim shared boom4(1024) as uinteger
dim shared uinbattle(16384) as uinteger
dim shared ushoot(16384) as uinteger
dim shared u2inbattle(16384) as uinteger
dim shared usword(16384) as uinteger
dim shared usword2(16384) as uinteger
dim shared enemyinbattle(16384) as uinteger
dim shared yoyo(4096) as uinteger
dim shared snum(3072) as uinteger
dim shared isprite1(1024) as uinteger
dim shared isprite2(1024) as uinteger
dim shared isprite3(1024) as uinteger
dim shared isprite4(1024) as uinteger
dim shared isprite5(1024) as uinteger
dim shared isprite6(1024) as uinteger
dim shared isprite7(1024) as uinteger
dim shared isprite8(1024) as uinteger
dim shared isprite9(1024) as uinteger

dim shared mshipdown(16384) as uinteger
dim shared mshipleft(16384) as uinteger
dim shared mshipup(16384) as uinteger
dim shared mshipright(16384) as uinteger
dim shared mshipmatrix(16384) as integer

dim shared logo(49152) as uinteger




dim shared charx  as integer = 32
dim shared start as integer = 0
dim shared chary as integer = 32
dim shared charlook as integer = 0
dim shared chara as integer = 0
'dim shared xstart as integer = 0
dim shared ystart as integer = 0
dim shared border as integer = 4
dim shared npcmode as integer = 1
dim shared npcactive as integer = 0
dim shared npcindex as integer = 1
dim shared daze as integer = 0
dim shared gold as integer = 100
dim shared hp as integer = 25
dim shared hpmax as integer = 25
dim shared ssp as integer = 20
dim shared spmax as integer = 20
dim shared atk as integer = 20
dim shared def as integer = 20
dim shared experience as integer = 0
dim shared acc as integer = 80
dim shared expmax as integer = 25
dim shared repellant as integer = 0
dim shared placemode as integer = 0
dim shared palpick as integer = 0
dim shared xoffset as integer = 0
dim shared yoffset as integer = 0
dim shared anitimer as integer = 0
dim shared warpflag as integer = 1
dim shared sameflag as integer = 0
dim shared grassflag as integer = 0
dim shared grasschance as integer 
grasschance = int(rnd * 6)+1
dim shared collission as integer = 0 
dim shared mdx as integer = 25
dim shared mdy as integer = 25
'dim xstart = 0
'dim ystart = 0
'dim activefile as string = "doug"
for a as integer = 1 to 15
inventory(a) = "Blank"
'inventorytitle(a) = "Blank"
'inventorydesc(a) = "Nothing so far."
next a
'inventory(1) = "heal"
'inventorytitle(1) = "Ade X3"
'inventorydesc(1) = "Restores 25HP."
fonttext = ":!|$ % '  * ,_./0123456789   _ ? ABCDEFGHIJKLMNOPQRSTUVWXYZ      abcdefghijklmnopqrstuvwxyz     "
'sel = FSOUND_Sample_Load(FSOUND_FREE, "audio\select.mp3", 0, 0, 0)
'selected = FSOUND_Sample_Load(FSOUND_FREE, "audio\selected.mp3", 0, 0, 0)


dim shared enemyfile(50) as string,ename(50) as string
dim shared ehp(50) as integer, eatk(50) as integer, edef(50) as integer, eacc(50) as integer
dim shared eweapon(50,3) as integer,ewchance(50,3) as integer
dim shared eexpget(50) as integer, ereward(50) as integer
dim shared eindex as integer,epick as integer
dim shared enums as integer = 50
dim shared ewuse as integer
'spacebgmusic = FSOUND_Sample_Load(FSOUND_FREE, "audio\Space Area.mp3", 0, 0, 0)
'npcsay = FSOUND_Sample_Load(FSOUND_FREE, "audio\npcsay.mp3", 0, 0, 0)
'mars = FSOUND_Sample_Load(FSOUND_FREE, "audio\mars.mp3", 0, 0, 0)
'tackle = FSOUND_Sample_Load(FSOUND_FREE, "audio\tackle.mp3", 0, 0, 0)
'laser = FSOUND_Sample_Load(FSOUND_FREE, "audio\laser.mp3", 0, 0, 0)
'sword = FSOUND_Sample_Load(FSOUND_FREE, "audio\sword.mp3", 0, 0, 0)


open "enemies\enemylist.dat" for input as #1

for a as integer = 0 to enums - 1
 input #1, enemyfile(a)
 input #1, ename(a)
 input #1, ehp(a)
 input #1, eatk(a)
 input #1, edef(a)
 input #1, eacc(a)
for b as integer = 0 to 2
input #1, eweapon(a,b)
 input #1, ewchance(a,b)
next b
 input #1, eexpget(a)
 input #1, ereward(a)
next a
close #1
'data "spider1","Spider",10,10,10,70
'data 1,75,3,25,0,0,2,10
'data "snake1","Snake",10,20,15,75
'data 3,80,6,10,0,10,3,15

'return



dim mapfilename as string

sub MakeBox(boxmode as integer, x1 as integer, y1 as integer, x2 as integer, y2 as integer, boxcolor as integer, bordercolor as integer, shadowcolor as integer)
    if boxmode = 0 then 
        line (x1,y1)-(x2,y2), shadowcolor, bf
        line (x1-8,y1-8)-(x2-8,y2-8), boxcolor, bf
        line (x1-8,y1-8)-(x2-8,y2-8), bordercolor, b
    end if
    if boxmode = 1 then 
        line ((y1-1)*8,(x1-1)*16)-((y2-1)*8,((x2-1)*16)+4), shadowcolor, bf
        line (((y1-2)*8)+4,((x1-2)*16)+12)-(((y2-2)*8)+4,((x2-2)*16)+16), boxcolor, bf
        line (((y1-2)*8)+4,((x1-2)*16)+12)-(((y2-2)*8)+4,((x2-2)*16)+16), bordercolor, b
    end if
    if boxmode = 2 then 
        line ((y1*16)+0,(x1*16)+0)-((y2*16)+4,(x2*16)+4),shadowcolor,bf
        line ((y1*16)-4,(x1*16)-4)-((y2*16)+2,(x2*16)+2),boxcolor,bf
        line ((y1*16)-4,(x1*16)-4)-((y2*16)+2,(x2*16)+2),bordercolor,b
    end if

    'put ((column+(a-1))*16,row*16),textfont,(fx,fy)-(fx+15,fy+15), trans
    
    
end sub

sub MakeChoice(ec as integer)
    

'fbs_Stop()

'fbs_Play_Wave(rotatesong,100)

    do
        z = inkey$: if z = " " then z = ""
    loop until z = ""

    do
        color 15
        for b = 1 to len(choice(cursor))
            for c = 1 to len(fonttext)
                if mid$(fonttext,c,1) = mid$(choice(cursor),b,1) then 
                    fx = (((c-1) mod 16)*16): fy = (int((c-1)/16)*16)
                end if
            next c
            put (((choicec(cursor))+(b-1))*16,choicer(cursor)*16),redtextfont,(fx,fy)-(fx+15,fy+15), trans
        next b
    
    Selection2:
    z = inkey$: if z = "" then goto Selection2
    if z = chr$(255)+chr$(72) then     
        for b as integer = 1 to len(choice(cursor))
            for c as integer = 1 to len(fonttext)
                if mid$(fonttext,c,1) = mid$(choice(cursor),b,1) then 
                    fx = (((c-1) mod 16)*16): fy = (int((c-1)/16)*16)
                end if
            next c
            put ((choicec(cursor)+(b-1))*16,choicer(cursor)*16),textfont,(fx,fy)-(fx+15,fy+15), trans
        next b
        cursor = cursor - 1
        if cursor = 0 then cursor = ec
    end if

    if z = chr$(255)+chr$(80) then 

        for b as integer = 1 to len(choice(cursor))
            for c as integer = 1 to len(fonttext)
                if mid$(fonttext,c,1) = mid$(choice(cursor),b,1) then 
                    fx = (((c-1) mod 16)*16): fy = (int((c-1)/16)*16)
                end if
            next c
            put ((choicec(cursor)+(b-1))*16,choicer(cursor)*16),textfont,(fx,fy)-(fx+15,fy+15), trans
        next b
    
        cursor = cursor + 1
        if cursor = ec+1 then cursor = 1
    end if
loop until z = " "

end sub

sub InventoryChoice()
    
end sub





sub DrawSprite(filename as string,x as integer,y as integer,scale as integer)
    open "tiles\" + filename for input as #1    
    for b as integer = 0 to scale-1 step (scale/16)
            for c as integer = 0 to scale-1 step (scale/16)
                input #1, scolor
                for d as integer = 0 to (scale/16)-1
                    for e as integer = 0 to (scale/16)-1
                        if scolor <> 255 then pset (b+x+d,c+y+e),scolor
                    next e
                next d
            next c
    next b
    close #1
end sub

sub DrawSpriteCC90(filename as string,x as integer,y as integer,scale as integer)          'CC 90
    open "tiles\" + filename for input as #1    
    for c as integer = 0 to scale-1 step (scale/16)
            for b as integer = 0 to scale-1 step (scale/16)
                input #1, scolor
                for d as integer = 0 to (scale/16)-1
                    for e as integer = 0 to (scale/16)-1
                        if scolor <> 255 then pset (b+x+d,c+y+e),scolor
                    next e
                next d
            next  
    next  
    close #1
end sub




sub DrawSpriteC180(filename as string,x as integer,y as integer,scale as integer)        'C 180  
    open "tiles\" + filename for input as #1    
    for b = 0 to scale-1 step (scale/16)
            for c = 0 to scale-1 step (scale/16)
                input #1, scolor
                for d = 0 to (scale/16)-1
                    for e = 0 to (scale/16)-1
                        if scolor <> 255 then pset ((scale-1)-b+x+d,(scale-1)-c+y+e),scolor
                    next e
                next d
            next  
    next  
    close #1
end sub

sub DrawSpriteC90(filename as string,x as integer,y as integer,scale as integer)          
    open "tiles\" + filename for input as #1    
    for c = 0 to scale-1 step (scale/16)
            for b = 0 to scale-1 step (scale/16)
                input #1, scolor
                for d = 0 to (scale/16)-1
                    for e = 0 to (scale/16)-1
                        if scolor <> 255 then pset ((scale-1)-b+x+d,(scale-1)-c+y+e),scolor
                    next e
                next d
            next  
    next  
    close #1
end sub

sub BigPrint(row as integer,column as integer,txt as string)
    for a as integer = 1 to len(txt)
        for b as integer = 1 to len(fonttext)
            if mid$(fonttext,b,1) = mid$(txt,a,1) then 
                fx = (((b-1) mod 16)*16): fy = (int((b-1)/16)*16)
            end if
        next b
        put ((column+(a-1))*16,row*16),textfont,(fx,fy)-(fx+15,fy+15), trans
    next a
end sub


'***********ITEM EFFECTS GOSUB ROUTINE************************
sub ItemEffects
'ItemEffects:

itemused = 0
if left$(inventory(cursor),9) = "Guaranola" and inbattle = 1 then       'Guaranaola
    itemused = 1
    'if left$(right$(inventory(cursor),2),1) = "X" then
        itemamt = val(right$(inventory(cursor),1))
        inventory(cursor) = left$(inventory(cursor),len(inventory(cursor))-2) + "X" + str(itemamt-1)
    'end if
    if right$(inventory(cursor),1) = "0" then
        inventory(cursor)=  "Blank"
    end if
        batk = batk + (batk * 2)
        MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"You triple your attack power!")
    sleep 1000
end if

if left$(inventory(cursor),7) = "iShield" and inbattle = 1 then     'iShield
    itemused = 1
    'if left$(right$(inventory(cursor),2),1) = "X" then
        itemamt = val(right$(inventory(cursor),1))
        inventory(cursor) = left$(inventory(cursor),len(inventory(cursor))-2) + "X" + str(itemamt-1)
    'end if
    if right$(inventory(cursor),1) = "0" then
        inventory(cursor)=  "Blank"
    end if
    bdef = bdef + (bdef * 2)
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"You triple your defense power!")
    sleep 1000
end if

if left$(inventory(cursor),7) = "Glasses" and inbattle = 1 then    'Glasses
    itemused = 1
    'if left$(right$(inventory(cursor),2),1) = "X" then
        itemamt = val(right$(inventory(cursor),1))
        inventory(cursor) = left$(inventory(cursor),len(inventory(cursor))-2) + "X" + str(itemamt-1)
    'end if
    if right$(inventory(cursor),1) = "0" then
        inventory(cursor)=  "Blank"
    end if
    bacc = 100
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"You have perfect accuracy!")
    sleep 1000
end if

if left$(inventory(cursor),9) = "Fireworks" and inbattle = 1 then   'Fireworks
    itemused = 1
    'if left$(right$(inventory(cursor),2),1) = "X" then
        itemamt = val(right$(inventory(cursor),1))
        inventory(cursor) = left$(inventory(cursor),len(inventory(cursor))-2) + "X" + str(itemamt-1)
    'end if
    if right$(inventory(cursor),1) = "0" then
        inventory(cursor)=  "Blank"
    end if
    distraction = distraction + 2
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"Fireworks distract opponent!")
    sleep 1000
end if

if left$(inventory(cursor),10) = "Light.Show" and inbattle = 1 then      'Light Show
    itemused = 1
    'if left$(right$(inventory(cursor),2),1) = "X" then
        itemamt = val(right$(inventory(cursor),1))
        inventory(cursor) = left$(inventory(cursor),len(inventory(cursor))-2) + "X" + str(itemamt-1)
    'end if
    if right$(inventory(cursor),1) = "0" then
        inventory(cursor)=  "Blank"
    end if
    distraction = distraction + 3
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"Light show distracts opponent!")
    sleep 1000
end if

if left$(inventory(cursor),3) = "Ade" then                        'Ade
    itemused = 1
    'if left$(right$(inventory(cursor),2),1) = "X" then
        itemamt = val(right$(inventory(cursor),1))
        inventory(cursor) = left$(inventory(cursor),len(inventory(cursor))-2) + "X" + str(itemamt-1)
    'end if
    if right$(inventory(cursor),1) = "0" then
        inventory(cursor)=  "Blank"
    end if
    hp = hp + 25: if hp > hpmax then hp = hpmax
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"You gain 25HP!")
    sleep 1000
end if

if left$(inventory(cursor),12) = "Muscle.Patch" then                     'Muscle Patch
    itemused = 1
    'if left$(right$(inventory(cursor),2),1) = "X" then
        itemamt = val(right$(inventory(cursor),1))
        inventory(cursor) = left$(inventory(cursor),len(inventory(cursor))-2) + "X" + str(itemamt-1)
    'end if
    if right$(inventory(cursor),1) = "0" then
        inventory(cursor)=  "Blank"
    end if
    ssp = ssp + 25: if ssp > hpmax then ssp = spmax
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"You gain 25SP!")
    sleep 1000
end if

if left$(inventory(cursor),9) = "Repellant" and inbattle = 0 then      'Repellant
    itemused = 1
    'if left$(right$(inventory(cursor),2),1) = "X" then
        itemamt = val(right$(inventory(cursor),1))
        inventory(cursor) = left$(inventory(cursor),len(inventory(cursor))-2) + "X" + str(itemamt-1)
    'end if
    if right$(inventory(cursor),1) = "0" then
        inventory(cursor)=  "Blank"
    end if
    repellant = 60
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"You put on repellant!")
    sleep 1000
end if


EndofItemEffects:
end sub
'*********************************************************



'************SPECIAL WEAPON EFFECTS************************
sub SpWeaponEffects
'SpWeaponEffects:
if cursor = 1 and spweapon(1) = 1 and ssp >= 7 then   'Sword
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"You use your sword!")
    sleep 1000
    ssp = ssp - 7
    if spweapon(5) = 1 then ssp = ssp - 7
    put (32,32),uinbattle
    put (64,32),usword
    for a as integer = 64 to 256 step 16
        put (a,32),usword
        put (a+16,32),usword
        sleep 10
    next a
    put (384,32),sword1
    sleep 75
    put (384,32),sword1
    put (384,32),sword2
    sleep 75
    put (384,32),sword2
    put (384,32),sword3
    sleep 150
    put (384,32),sword3
    for a as integer = 256 to 32 step -16
        put (a,32),usword
        put (a+16,32),usword
        sleep 10
    next a
    
       attack = batk - (edef(epick)/2)  
    attchance = int(rnd * attack)+1
    if spweapon(5) = 0 then attack = attack * 1.5 + attchance
    if spweapon(5) = 1 then attack = attack * 3 + attchance
    if attack <= 0 then attack = level

    
    
    accchance = int(rnd * 100)+1
    if spweapon(5) = 1 then accchance = 100
    
    if accchance > bacc * .75 and accchance <= bacc then attack = attack * .75
    if accchance > bacc and accchance < bacc+((100-bacc)/2) then attack = attack / 2
    if accchance > bacc+((100-acc)/2) then attack = 0
    
    
    
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
        BigPrint (14,4,"Your sword does "+ str(attack) + "HP damage.")
        sleep 1000
    end if
       ' goto EndOfSpWeaponEffects

end if

if cursor = 2 and spweapon(2) = 1 and ssp >= 5 then   'Boomerang
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"You use your boomerang!")
    sleep 1000
    ssp = ssp - 10
    if spweapon(6) = 1 then ssp = ssp - 10
    put (64,32),boom1
    for a as integer = 64 to 144 step 16
        put (a,32),boom1
        put (a+16,32),boom1
        sleep 10
    next a 
    put (144,32),boom1
    for a as integer = 160 to 224 step 16
        put (a,32),boom2
        put (a+16,32),boom2
        sleep 10
    next a 
    put (224,32),boom2
    for a as integer = 240 to 304 step 16
        put (a,32),boom3
        put (a+16,32),boom3
        sleep 10
    next a 
    put (304,32),boom3
    for a as integer = 320 to 384 step 16
        put (a,32),boom4
        put (a+16,32),boom4
        sleep 10
    next a 
    put (384,32),boom4
    for a as integer = 384 to 320 step -16
        put (a,32),boom4
        put (a+16,32),boom4
        sleep 10
    next a     
    put (320,32),boom4
    for a as integer = 304 to 240 step -16
        put (a,32),boom4
        put (a+16,32),boom4
        sleep 10
    next a     
    put (240,32),boom3
    for a as integer = 224 to 160 step -16
        put (a,32),boom4
        put (a+16,32),boom4
        sleep 10
    next a     
    put (160,32),boom2
    for a as integer = 144 to 64 step -16
        put (a,32),boom4
        put (a+16,32),boom4
        sleep 10
    next a     
    put (64,32),boom1


   attack = batk - (edef(epick)/2)  
    attchance = int(rnd * attack)+1
    attack = attack * .75 + attchance

    if attack <= 0 then attack = level


    
    accchance = int(rnd * 100)+1
    if spweapon(6) = 1 then accchance = 100: distraction = distraction + 2
    if accchance > 60 then 
        distraction = distraction + 1
        BigPrint (13,4,"You stunned the "+ename(epick)+"!")
        sleep 1000
    end if
    'if accchance > bacc * .75 and accchance <= bacc then attack = attack * .75
    'if accchance > bacc and accchance < bacc+((100-bacc)/2) then attack = attack / 2
    'if accchance > bacc+((100-acc)/2) then attack = 0
    
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
        BigPrint (14,4,"Your boomerang does "+ str(attack) + "HP damage.")
        sleep 1000
        
    
    end if
'goto EndOfSpWeaponEffects

    '64-144
    '160-224
    '240-304
    '320-384
end if 

if cursor = 3 and spweapon(3) = 1 then   'Smokescreen
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"You use your smokescreen!")
    sleep 1000
    ssp = ssp - 25
    
    if ssp > 0 then 
        'int(rnd * 128)+32
        for a as integer = 1 to 25
            c = int(rnd * 128)+32
            d = int(rnd * 128)+32
            for b = 0 to 31
                if b < 15 then
                    circle (c,d),b*3,7
                    circle (c,d),1+b*3,7
                    circle (c,d),2+b*3,7
                end if
                if b> 14 then
                    circle (c,d),b*3,b
                    circle (c,d),1+b*3,b
                    circle (c,d),2+b*3,b
                end if
            next b
            sleep 25
        next a
    end if
    if ssp < 1 then
    
        BigPrint(13,4,"You're too tired to")
        BigPrint(14,4,"activate it!")
        sleep 1000
    end if
end if


if cursor = 4 and spweapon(4) = 1 then   'Energy
    MakeBox(1,13,9,16,75,1,15,7)
    BigPrint(12,4,"You use your energy distributor!")
    sleep 1000
        for a as integer = 1 to 25
            c = int(rnd * 128)+32
            d = int(rnd * 128)+32
            line (c,d)-step(2,-25),int(rnd * 15)+1,bf
            sleep 25
        next a
    hp = hp + (ssp/2)
    if hp> hpmax then hp = hpmax
    ssp = 0
    sleep 1000
end if
    









EndOfSpWeaponEffects:


end sub



dim shared vote(256) as integer

sub VoteSprite(filename as string)
'cls
spmax = 0
open "tiles\" + filename for input as #1    
for a as integer = 0 to 255
    vote(a) = 0
next a
  for aa as integer = 0 to 15
        for bb as integer = 0 to 15
            input #1, scolor
        
        
        vote(scolor) = vote(scolor) + 1
        'color 15: locate 20,3: print scolor, vote(scolor): sleep
        'if scolor <> 255 then pset (b+x,c+y), scolor
        'if scolor <> 255 then pset (b+x+1,c+y), scolor
        'if scolor <> 255 then pset (b+x,c+y+1), scolor
        'if scolor <> 255 then pset (b+x+1,c+y+1), scolor
    next bb
  next aa

close #1
end sub



sub MapPreview(mname as string,mx as integer,my as integer,md as integer)
open "maps\" + mname+".ma2" for input as #1
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
close #1

for ax as integer = 0 to mdy - 1
    for b as integer = 0 to mdx-1
        VoteSprite spname(spcode(b,ax) mod 100)+".pix"
        spmax = 0
       for c as integer = 0 to 255
            if vote(c) > spmax then spmax = c
        next c
        for d as integer = 0 to md-1
            for e as integer = 0 to md-1
                pset (((b*md)+d)+mx,((ax*md)+e)+my),spmax
            next e
        next d
    next b
next ax
end sub




#define UseRad 'if not then Rotate are in degres

