'Have a nice day and God Bless!
'John 1:1, 3:16, Acts 10:38
dim shared vote(256) as integer
dim firstletter as string
dim f as string
dim sprite(32768) as integer
dim shared spname(32) as string
dim shared borderxstart(4) as integer
dim shared borderystart(4) as integer
dim shared ecode(10) as string
dim shared filenames(1000) as string
dim shared mfilenames(1000) as string
dim shared mfcount as integer
dim shared song as string
dim xbutton(256) 
dim shared spcode(100,100) as integer
dim cfname(10) as string
dim choice2 as string
mdx = 25
mdy = 25
xstart = 0
ystart = 0
dim nborder as string
dim sborder as string
dim eborder as string
dim wborder as string
xstart = 0
ystart = 0
placemode = 0
palpick = 0
dim mapfilename as string
dim ftname(100) as string                   'Name of the Feature.
dim ftx(100) as integer, fty(100) as integer 'Location of the Feature.
dim fts(100) as integer                     'Status of the Feature. 
dim ftpname(100) as string                    'Projectile Name
dim ftpx(100) as integer, ftpy(100) as integer 'Projectile Location.
dim ftps(100) as integer, ftpt(100) as integer 'Projectile Status and Trajectory in degrees, 0 being up, 90 being right.
dim ftc(100) as integer, ftcmd(100) as integer 'Feature Counter and current command. 
dim ftrnd(100) as integer                     'Feature random position.
dim esprite(81920) as integer  'Enemy Sprites
dim enemyname(10) as string
dim enemysprite(10) as string
dim enemypname(10) as string
dim enemyx(10) as integer
dim enemyy(10) as integer
dim enemyactive(10) as integer
dim enemydirection(10) as integer
dim enemyani(10) as integer
dim enemyresidue(10) as integer


dim shared alltiles(307200)
dim npcbtn(1024)
dim placebtn(1024)
dim arrowbtn(1024)
dim brickbtn(1024)
dim dimbtn(1024)
dim newbtn(1024)
dim openbtn(1024)
dim savebtn(1024)
dim musicbtn(1024)
dim uparrow(1024)
dim uparrow2(1024)
dim dnarrow(1024)
dim dnarrow2(1024)
dim arrowup(1024)
dim arrowdn(1024)
dim arrowlt(1024)
dim arrowrt(1024)
dim enblock(1024)
'dim xbutton(1024)
dim daze(1024)

sub DrawBigSprite(filename as string,x,y)
'cls
open "tiles\" + filename for input as #1    
  for b = 0 to 31 step 2
        for c = 0 to 31 step 2
        input #1, scolor
        if scolor <> 255 then pset (b+x,c+y), scolor
        if scolor <> 255 then pset (b+x+1,c+y), scolor
        if scolor <> 255 then pset (b+x,c+y+1), scolor
        if scolor <> 255 then pset (b+x+1,c+y+1), scolor
    next c
  next b
close #1
end sub

sub DrawSprite(filename as string,x,y,scale)
'cls
    open "tiles\" + filename for input as #1    
    for b = 0 to scale-1 step (scale/16)
            for c = 0 to scale-1 step (scale/16)
                input #1, scolor
                for d = 0 to (scale/16)-1
                    for e = 0 to (scale/16)-1
                        if scolor <> 255 then pset (b+x+d,c+y+e),scolor
                    next e
                next d
            next c
    next b
    close #1
end sub
sub MakeBox(boxmode, x1, y1, x2, y2, boxcolor, bordercolor, shadowcolor)
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
end sub









sub VoteSprite(filename as string)
'cls

spmax = 0
open "tiles\" + filename for input as #1    
for a = 0 to 255
    vote(a) = 0
next a
  for aa= 0 to 15
        for bb= 0 to 15
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



dim placeholder as string


mdx = 25
mdy = 25
xstart = 0
ystart = 0
xstart = 0
ystart = 0
placemode = 0
palpick = 0

sub MapPreview(mname as string,mx,my,md)
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
for a = 0 to 31
 input #1, spname(a)
next a
for a = 0 to mdy-1
    for b = 0 to mdx-1
        input #1, spcode(b,a)
    next b
next a
for a = 1 to 9
    input #1, ecode(a)
next a
close #1

for ax = 0 to mdy - 1
    for b = 0 to mdx-1
        VoteSprite spname(spcode(b,ax) mod 100)+".pix"
        spmax = 0
       for c = 0 to 255
            if vote(c) > spmax then spmax = c
        next c
        for d = 0 to md-1
            for e = 0 to md-1
                pset (((b*md)+d)+mx,((ax*md)+e)+my),spmax
            next e
        next d
    next b
next ax
end sub


screen 18,,2

cls
DrawBigSprite("npcbtn.pix",0,0)
get (0,0)-(31,31),npcbtn
cls
DrawBigSprite("placebtn.pix",0,0)
get (0,0)-(31,31),placebtn
cls
DrawBigSprite("arrowbtn.pix",0,0)
get (0,0)-(31,31),arrowbtn
cls
DrawBigSprite("brickbtn.pix",0,0)
get (0,0)-(31,31),brickbtn
cls
DrawBigSprite("dimbtn.pix",0,0)
get (0,0)-(31,31),dimbtn
cls
DrawBigSprite("newbtn.pix",0,0)
get (0,0)-(31,31),newbtn
cls
DrawBigSprite("openbtn.pix",0,0)
get (0,0)-(31,31),openbtn
cls
DrawBigSprite("savebtn.pix",0,0)
get (0,0)-(31,31),savebtn
cls
DrawBigSprite("uparrow.pix",0,0)
get (0,0)-(31,31),uparrow
cls
DrawBigSprite("uparrow2.pix",0,0)
get (0,0)-(31,31),uparrow2
cls
DrawBigSprite("dnarrow.pix",0,0)
get (0,0)-(31,31),dnarrow
cls
DrawBigSprite("dnarrow2.pix",0,0)
get (0,0)-(31,31),dnarrow2
cls
DrawBigSprite("arrowup.pix",0,0)
get (0,0)-(31,31),arrowup
cls
DrawBigSprite("arrowdn.pix",0,0)
get (0,0)-(31,31),arrowdn
cls
DrawBigSprite("arrowlt.pix",0,0)
get (0,0)-(31,31),arrowlt
cls
DrawBigSprite("arrowrt.pix",0,0)
get (0,0)-(31,31),arrowrt
cls
DrawBigSprite("daze.pix",0,0)
get (0,0)-(31,31),daze
cls
DrawBigSprite("enblock.pix",0,0)
get (0,0)-(31,31),enblock
cls
DrawBigSprite("musicbox.pix",0,0)
get (0,0)-(31,31),musicbtn



mapfilename = "mbase"
'chdir "c:\puzzle\"
LoadFile0:
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
for a = 0 to 31
 input #1, spname(a)
next a
for a = 0 to mdy-1
    for b = 0 to mdx-1
        input #1, spcode(b,a)
    next b
next a
for a = 1 to 9
    input #1, ecode(a)
next a
for a = 0 to 9
    input #1, enemyname(a)
next a
close #1

screenset 1,1
'for a = 0 to 9
'open "enemies\"+enemyname(a)+".ene" for input as #1
'input #1, enemysprite(a)
''sleep
'close #1
'next a


scroll = 0 
LoadFile:

for a = 0 to 31
DrawBigSprite(spname(a)+".pix", (a mod 8)*32, int(a/8)*32)
next a
get (0,0)-(255,127), sprite
cls

for a = 0 to 9
DrawBigSprite(enemysprite(a)+"u1.pix",0,a*32)
DrawBigSprite(enemysprite(a)+"u2.pix",32,a*32)
DrawBigSprite(enemysprite(a)+"r1.pix",64,a*32)
DrawBigSprite(enemysprite(a)+"r2.pix",96,a*32)
DrawBigSprite(enemysprite(a)+"d1.pix",128,a*32)
DrawBigSprite(enemysprite(a)+"d2.pix",160,a*32)
DrawBigSprite(enemysprite(a)+"l1.pix",192,a*32)
DrawBigSprite(enemysprite(a)+"l2.pix",224,a*32)
'sleep
next a
get (0,0)-(255,319),esprite







cls
DrawBigSprite("xbutton.pix",0,0)
get (0,0)-(15,15),xbutton


dim path as string
dim filename as string
dim activefile as string
dim mfilename as string

CONST attrib_readonly   = 1
CONST attrib_hidden     = 2
CONST attrib_system     = 4
CONST attrib_directory  = 16
CONST attrib_archive    = 32
ReloadFile:
'CHDIR "c:\puzzle\tiles\"  'Change this to the directory you want to browse

    fcount = 0
        filename = dir$("tiles\*", 32)
        DO
            filenames(fcount) = filename
            filename = dir$("", attrib)
            fcount = fcount + 1
        LOOP WHILE filename <> ""
        
        
    mfcount = 0
        filename = dir$("maps\*", 32)
        DO
            mfilenames(mfcount) = filename
            filename = dir$("", attrib)
            mfcount = mfcount + 1
        LOOP WHILE filename <> ""
        
        
'cls
'for a = 0 to fcount
'DrawBigSprite(filenames(a),(a mod 20)*32,int(a/20)*32)
'next a
'sleep

mousedelay = 0

fpscount = 0
fps = 0
cchoose = 15
codestart = 0 
savescroll = 0

'chdir "c:\puzzle\"



placemode = 0 
screenset 1,0
now = TIMER
LoopStart:
if now + 1 < TIMER then
now = TIMER
fps = fpscount
fpscount = 0
end if
cls
getmouse mx,my,,mb
for a = -1 to 15
    for b = -1 to 20
     spcoord = (spcode(b+xstart,a+ystart) mod 100) mod 32
     spx = (spcoord mod 8)*32
     spy = (int(spcoord / 8))*32
     put (b*32,a*32), sprite, (spx,spy)-(spx+31,spy+31), trans
     for c = 0 to 9
            if enemyx(c) = spx/32 and enemyy(c) = spy/32 then 
                line (spx,spy)-step(31,31),9,b
                'put (spx,spy),esprite,(0,0)-(31,31),trans
            end if
     next c
     if spcode(b+xstart, a+ystart) >= 200 and spcode(b+xstart, a+ystart) < 300 then 
         line (b*32,a*32)-step(31,31),15,b
     if a > -1 and b > -1 and a < 15 and b < 20 then locate (a*2)+1,(b*4)+1: 'print using "#"; int (spcode(b+xstart,a+ystart) / 100)
     end if
     if spcode(b+xstart, a+ystart) >= 300 then line (b*32,a*32)-step(31,31),14,b   
    next b
next a



if placemode = 0 then MakeBox(0,512,32,607,447,7,8,0)
if placemode = 3 then MakeBox(0,512,32,607,447,1,15,0)

if placemode = 0 or placemode = 3 then
put(512,32),npcbtn, trans
put (560,32),placebtn, trans
put (512,80),arrowbtn, trans
put (512,256),enblock, trans
put (512,288),musicbtn, trans
put(560,80),brickbtn,trans
put (512,128),dimbtn,trans
put (560,128),newbtn,trans
put (512,176),openbtn,trans
put (560,176),savebtn,trans
put (512,224),uparrow,trans
put (512,384),dnarrow,trans
put (320,0),arrowup,trans
put (320,448),arrowdn,trans
put (0,240),arrowlt,trans
put (608,240),arrowrt,trans
put (0,0),daze, trans
'DrawBigSprite("placebtn.pix",560,32)
'DrawBigSprite("arrowbtn.pix",512,80)
'DrawBigSprite("brickbtn.pix",560,80)
'DrawBigSprite("dimbtn.pix",512,128)
'DrawBigSprite("newbtn.pix",560,128)
'DrawBigSprite("openbtn.pix",512,176)
'DrawBigSprite("savebtn.pix",560,176)
'DrawBigSprite("uparrow.pix",512,224)
'DrawBigSprite("dnarrow.pix",512,384)
'DrawBigSprite("arrowup.pix",320,0)
'DrawBigSprite("arrowdn.pix",320,448)
'DrawBigSprite("arrowlt.pix",0,240)
'DrawBigSprite("arrowrt.pix",608,240)
end if
'DrawBigSprite("daze.pix",0,0)
if placemode = 0 then 
for a = 0 + scroll to 5 + scroll
 put (560,224+(a-scroll)*32),sprite,((a mod 8)*32,int(a/8)*32)-(31+(a mod 8)*32,31+int(a/8)*32),trans

'DrawBigSprite(spname(a)+".pix",560,224+(a-scroll)*32)
 codestart = a-5
next a
end if
 if ystart = 0 then line (0,0)-step(639,4), 14,bf
 if mdy - ystart = 15 then  line (0,479)-step(639,-4), 14,bf
 if xstart = 0 then line (0,0)-step(4,479),14,bf
 if mdx - xstart = 20 then line(639,0)-step(-4,479),14,bf
put (624,0), xbutton, trans
if placemode = 3 then 
for a = 0 + scroll to 5 + scroll
 'DrawBigSprite(filenames(a),560,224+(a-scroll)*32)
 put (560,224+(a-scroll)*32),sprite,((a mod 8)*32,int(a/8)*32)-(31+(a mod 8)*32,31+int(a/8)*32),trans
next a
end if


'if placemode = 2 then 
'    color 15
'    locate 2,1: print mb
'end if

locate 1,1

print using "## ## #"; int(mx/32)+xstart,int(my/32)+ystart; multikey(&h2A)
locate 2,1: print xstart; ystart
color 15,7:locate 27,65: print mapfilename: color ,0
'locate 25,1: color 15: print using "FPS: ## SCROLL: ## PALPICK: # CODE: ##"; fps; scroll; palpick; codestart
'locate 26,1: color 15: print using "X: ### Y: ###"; mx; my
'locate 27,1: color 15: print using "###"; spcode(int(mx/32)+xstart,int(my/32)+ystart)
'locate 2,1: color 15: print using "\           \"; filenames(
'locate 1,1: print fps
if placemode = 0 then 
if mb = 1 and mx >= 512 and mx <= 543 and my >= 224 and my <= 255 then
    put (512,224),uparrow2,trans
    'DrawBigSprite("uparow2.pix",512,224)
    scroll = scroll - 1: if scroll = -1 then scroll = 0
end if
if mb = 1 and mx >= 512 and mx <= 543 and my >= 384 and my <= 415 then 
    put (512,384),dnarrow2,trans
    'DrawBigSprite("dnarow2.pix",512,384)
   scroll = scroll + 1: if scroll = 27 then scroll = scroll - 1
end if
end if

if placemode = 0 then
 if mb = 1 and mx >= 320 and mx <= 351 and my >= 0 and my <= 31 and ystart > 0 then ystart = ystart - 1
 if mb = 1 and mx >= 320 and mx <= 351 and my >= 448 and my <= 479 and mdy - ystart > 15 then ystart = ystart + 1
 if mb = 1 and mx >= 0 and mx <= 31 and my >=240 and my <= 271 and xstart > 0 then xstart = xstart - 1
 if mb = 1 and mx >= 608 and mx <= 639 and my >= 240 and my <= 271 and mdx - xstart > 20 then xstart = xstart + 1 






 if mb = 1 and mx >= 512 and mx <= 543 and my >= 224 and my <= 255 then
         put (512,224),uparrow2,trans
     DrawBigSprite("uparow2.pix",512,224)
     scroll = scroll - 1: if scroll = -1 then scroll = 0
     codenum = 100 + scroll + palpick
     'sleep 100
 end if
 if mb = 1 and mx >= 512 and mx <= 543 and my >= 384 and my <= 415 then 
         put (512,384),dnarrow2,trans
     DrawBigSprite("dnarow2.pix",512,384)
    scroll = scroll + 1: if scroll = 27 then scroll = scroll - 1
     codenum = 100 + scroll + palpick
     'sleep 100
 end if 

 if mb = 1 and mx >= 560 and mx <= 591 and my >= 224 and my <= 415 and placemode = 0 then
  palpick = int((my-224) / 32)
  codenum = 100 + scroll + palpick
 end if
 'if mb = 2 and mx >= 560 and mx <= 591 and my >= 224 and my <= 415 then
 ' palpick = int((my-224) / 32)
 ' codenum = 100 + scroll + palpick
 ' goto LoopStart
 'end if
 line (560,(224+(palpick*32)))-step(31,31), int(rnd * 255),b

 if mb = 2 and mx >= 560 and mx <= 591 and my >= 224 and my <= 415 and placemode = 0 then
  scrollsave = scroll
  palpick = int((my-224) / 32)
  screenset 1,1
  FLetter:
  MakeBox(1,3,3,25,40,7,15,8)
  color 15,7: locate 3,3: input "Enter first letter"; firstletter
  if firstletter = "back" then goto EndofPallette
  flcount = 0
  FiName:
  gscale = 32
LoadSprite:
    MakeBox(0,16,64,640,400,1,14,0)
    fscount = 0
    for c = 0 to fcount
        if left$(filenames(c),len(firstletter)) = firstletter then 
            
            if gscale = 16 and fscount <= 79 then 
                DrawSprite(filenames(c),16+(fscount mod 8)*72,64+int(fscount/8)*32,gscale)
                locate 6+int(fscount/8)*2,3+((fscount-0) mod 8)*9: print left$((left$(filenames(c),len(filenames(c))-4)),8)
                fscount = fscount + 1
            end if

            if gscale = 32 and fscount <= 39 then 
                DrawSprite(filenames(c),16+(fscount mod 8)*72,64+int(fscount/8)*64,gscale)
                locate 7+int(fscount/8)*4,3+((fscount-0) mod 8)*9: print left$((left$(filenames(c),len(filenames(c))-4)),8)
                fscount = fscount + 1
            end if
            if fscount = 40 and gscale = 32 then gscale = 16: goto LoadSprite
                
        end if
    next c
  
  
  
  'MakeBox(1,3,3,25,40,7,15,8)
  'for a = 0 to fcount - 1
  'if left$(filenames(a), 1) = firstletter then 
  ' flcount = flcount + 1
  ' locate flcount+5, 3: print filenames(a)
  'end if
 'next a

 locate 3,3: input "Enter filename"; f
 '160,112
  if f = "back" then goto FLetter
  DrawBigSprite(f+".pix",160,112)
  locate 4, 3: input "Is this correct (0-No 1-Yes)"; correct
  if correct <> 0 and correct <> 1 then flcount = 0: goto FiName
  if correct = 0 then flcount = 0: goto FiName
  if correct = 1 then spname(scroll+palpick) = f
  EndofPallette:
  screenset 1,0
  placemode = 0
  color 15,0: cls
goto LoadFile
 end if

 if mb = 1 and mx >= 560 and mx <= 591 and my >= 32 and my <= 63 then placemode = 1

 if mb = 1 and mx >= 560 and mx <= 591 and my >= 80 and my <= 111 then placemode = 2
 

 if mb = 1 and mx >= 512 and mx <= 543 and my >= 128 and my <= 159 then 
   screenset 1,1
   MakeBox(1,3,3,5,40,7,15,8)  
   oldmdx = mdx: oldmdy = mdy
   color 15,7: locate 3,3: input "Number of Columns"; mdx
   locate 4,3: input "Number of Rows"; mdy
   color 15,0: cls
   screenset 1,0
   goto LoadFile
 end if
 
 if mb = 1 and mx >= 512 and mx <= 543 and my >= 80 and my <= 111 and placemode = 0 then
   screenset 1,1
   cursor = 1
   CursorStart:
   MakeBox(1,3,3,20,40,7,15,8)
   color 15,7
   locate 3,3: print "Boundaries Menu"
   locate 5, 3: print "1. North Name"
   locate 6, 3: print "2. South Name"
   locate 7, 3: print "3. East Name"
   locate 8, 3: print "4. West Name"
   locate 9, 3: print "5. North Start"
   locate 10, 3: print "6. South Start"
   locate 11, 3: print "7. East Start"
   locate 12, 3: print "8. West Start"
   locate 13, 3: print "9. Exit Menu"
   locate 15, 3: input "Option"; cursor
   if cursor < 1 or cursor > 9 then goto CursorStart
   if cursor = 1 then 
       locate 17, 3: print using "Current North Name is \      \"; nborder
       locate 18,3: input "New North Name"; nborder
   end if
   if cursor = 2 then 
       locate 17, 3: print using "Current South Name is \      \"; sborder
       locate 18,3: input "New South Name"; sborder
   end if
   if cursor = 3 then 
       locate 17, 3: print using "Current East Name is \      \"; eborder
       locate 18,3: input "New East Name"; eborder
   end if
   if cursor = 4 then 
       locate 17, 3: print using "Current West  Name is \      \"; wborder
       locate 18,3: input "New West Name"; wborder
   end if
   if cursor = 5 then 
       locate 17, 3: print using "Current North Start is X## Y##"; borderxstart(0); borderystart(0)
       locate 18,3: input "New North XStart"; borderxstart(0)
       locate 19,3: input "New North YStart"; borderystart(0)
   end if
   if cursor = 6 then 
       locate 17, 3: print using "Current South Start is X## Y##"; borderxstart(1); borderystart(1)
       locate 18,3: input "New South XStart"; borderxstart(1)
       locate 19,3: input "New South YStart"; borderystart(1)
   end if
   if cursor = 7 then 
       locate 17, 3: print using "Current East Start is X## Y##"; borderxstart(2); borderystart(2)
       locate 18,3: input "New East XStart"; borderxstart(2)
       locate 19,3: input "New East YStart"; borderystart(2)
   end if
   if cursor = 8 then 
       locate 17, 3: print using "Current West Start is X## Y##"; borderxstart(3); borderystart(3)
       locate 18,3: input "New West XStart"; borderxstart(3)
       locate 19,3: input "New West YStart"; borderystart(3)
   end if
   if cursor = 9 then goto EndBoundaries
   goto CursorStart
   EndBoundaries:
   screenset 1,0
 end if
 
 if mb = 1 and mx >= 560 and mx <= 591 and my >= 128 and my <= 139 and placemode = 0  then
   screenset 1,1
   MakeBox(1,3,3,5,40,7,15,8)  
   color 15,7: locate 3,3: input "Number of Columns"; mdx
   locate 4,3: input "Number of Rows"; mdy
   song = "blank"
   for a = 0 to 31
     spname(a) = "blank"
   next a
   for a = 0 to mdy-1
    for b = 0 to mdx-1
       spcode(b,a) = 0
    next b
   next a
   nborder = "blank"
   sborder = "blank"
   eborder = "blank"
   wborder = "blank"
   for a = 0 to 3
   borderxstart(a) = 0
   borderystart(a) = 0
   next a
   color 15,0: cls
   screenset 1,0
   goto LoadFile
 end if

 if mb = 1 and mx >= 512 and mx <= 543 and my >= 176 and my <= 207 and placemode = 0  then
     OpenFile:
   screenset 1,1
   'x = (c*8)-8
   'y = (r*16)-16
   
   counter = 0
   cursor = 1
   OpenFile2:
   MakeBox(1,3,3,28,40,7,15,8)      
   for a = 1 to 20
        if cursor = a then color 14 else color 15
        locate a + 3, 5: print using "\                    \"; mfilenames(a+counter-1)
   next a
   locate 25, 3: input "a/Last Page z/ Next Page, name to select>"; choice2
    if choice2 = "a" or choice2 = "A" then
        if counter > 19 then counter = counter - 20
        goto OpenFile2
    end if
    if choice2 = "z" or choice2 = "Z" then 
        if counter < mfcount-20 then counter = counter + 20
        goto OpenFile2
    end if
    if choice2 = "back" then goto LoadFile0
    mapfilename = choice2

   'counter = 4
   
   'MapPreview(
   
   
      '     mfilename = dir$("maps\*", 32)
      '     counter = 5
      '  DO
      '      color 15,8: locate counter,5: print mfilename
      '      mfilename = dir$("", attrib)
      '      counter = counter + 1: 
      '      if counter = 20 then 
      '          'sleep: counter = 5
      '          MakeBox(1,3,3,20,40,7,15,8)    
      '      end if
      '  LOOP WHILE mfilename <> ""

   'color 15, 7: locate 3,3: input "Open File"; mapfilename
   MapPreview(mapfilename,48,48,4)
   locate 3,3: print "Press any key to accept, q to go back"
   do:a$ = inkey$: loop until a$ <> ""
   if a$ = "q" or a$ = "Q" then goto OpenFile
   color 15,0: cls
   screenset 1,0
   goto LoadFile0
 end if 
  
 if mb = 1 and mx >= 560 and mx <= 591 and my >= 176 and my <= 207 and placemode = 0 then
   screenset 1,1
   MakeBox(1,3,3,5,40,7,15,8)  
   color 15, 7: locate 3,3: input "Save File"; mapfilename
open "maps\" + mapfilename + ".ma2" for output as #1
print #1, song
print #1, mdx
print #1, mdy
print #1, nborder
print #1, borderxstart(0)
print #1, borderystart(0)
print #1, sborder
print #1, borderxstart(1)
print #1, borderystart(1)
print #1, eborder
print #1, borderxstart(2)
print #1, borderystart(2)
print #1, wborder
print #1, borderxstart(3)
print #1, borderystart(3)
for a = 0 to 31
 print #1, spname(a)
next a
for a = 0 to mdy-1
    for b = 0 to mdx-1
        'if spcode(b,a) < 100 then spcode(b,a) = 100 + val(right$(spcode(b,a),2))
        if spcode(b,a) < 100 then spcode(b,a) = 100 + (spcode(b,a) mod 100)
        'if spcode(b,a) > 199 then spcode(b,a) = 200 + val(right$(spcode(b,a),2))
        print #1, spcode(b,a)
    next b
next a
for a = 1 to 9
    print #1, ecode(a)
next a
for a = 0 to 9
    print #1, enemyname(a)
next a

close #1

   'end if
   

   color 15,0: cls
   screenset 1,0
 end if 

end if

if mb = 1 and placemode = 0  and mx >= 512 and mx <= 543 and my >= 32 and my <= 63 and placemode = 0 then
 screenset 1,1
 MakeBox(1,3,3,20,80,7,15,8)
 color 15,7
 for a = 0 to 8
  locate 3+a,3: print using "##. \                        \"; a+1; ecode(a+1)
 next a
 locate 13,3: input "NPC to adjust"; npcadj
 if npcadj = 0 then goto EndAdj
 locate 14, 3: line input "Enter NPC Code >"; ecode(npcadj)
 EndAdj:
 color ,0
 screenset 1,0
end if

 if mb = 1 and placemode = 0 and mx >= 512 and mx <= 543 and my >= 256 and my <= 287 then 

    
       screenset 1,1
 MakeBox(1,3,3,20,80,7,15,8)
 color 15,7
 for a = 0 to 8
  locate 3+a,3: print using "##. \       \"; a+1; enemyname(a)
 next a
  locate 13,3: input "Enemy number to adjust"; eadj
 if eadj = 0 then goto EndAdj2
  locate 14, 3: input "Enemy name >"; en$
  enemyname(eadj-1) = en$
 
 
  EndAdj2:
  color ,0

  screenset 1,0
goto LoadFile
end if

    if mb = 1 and placemode = 0 and mx >=512 and mx <=543 and my >=288 and my <= 319 then
        screenset 1,1
        MakeBox(1,3,3,7,40,7,15,8) 
        color 15,7
        locate 3,3: print using "Current song is \               \"; song
        locate 4,3: line input "New song >"; song
    end if


 if mb = 1 and mx >= 0 and mx <= 31 and my >= 0 and my <= 31 and placemode = 2 then placemode = 0
if placemode = 1 then
    if mb = 1 then
      spcode(int(mx/32)+xstart,int(my/32)+ystart) = scroll+ palpick+100
      locate 19,1: print scroll+palpick+100
      locate 20,1: print spname(scroll+palpick)
    end if
end if
if placemode = 2 then
    if mb = 1 and spcode(int(mx/32)+xstart,int(my/32)+ystart) >= 100 and spcode(int(mx/32)+xstart,int(my/32)+ystart) <= 199 then 
        spcode(int(mx/32)+xstart,int(my/32)+ystart) = spcode(int(mx/32)+xstart,int(my/32)+ystart) + 100
        goto EndofPlace2
    end if
    if mb = 2 and spcode(int(mx/32)+xstart,int(my/32)+ystart) >= 200 and spcode(int(mx/32)+xstart,int(my/32)+ystart) <= 299 then 
        spcode(int(mx/32)+xstart,int(my/32)+ystart) = spcode(int(mx/32)+xstart,int(my/32)+ystart) - 100
goto EndofPlace2
    end if
    if mb = 2 and spcode(int(mx/32)+xstart,int(my/32)+ystart) >= 300  then 
        spcode(int(mx/32)+xstart,int(my/32)+ystart) = spcode(int(mx/32)+xstart,int(my/32)+ystart) - 200
goto EndofPlace2
    end if
    if mb = 3 and spcode(int(mx/32)+xstart,int(my/32)+ystart) >= 100 and spcode(int(mx/32)+xstart,int(my/32)+ystart) <= 399 then 
        spcode(int(mx/32)+xstart,int(my/32)+ystart) = spcode(int(mx/32)+xstart,int(my/32)+ystart) + 200
    goto EndofPlace2
    end if

'end if      
    'if mb = 3 and spcode(int(mx/32)+xstart,int(my/32)+ystart) >= 200 and spcode(int(mx/32)+xstart,int(my/32)+ystart) <= 299 then 
    '    spcode(int(mx/32)+xstart,int(my/32)+ystart) = spcode(int(mx/32)+xstart,int(my/32)+ystart) + 100
    '    goto EndofPlace2
    'end if      
    
    
      locate 20,1: print spname(scroll+palpick)
'if placemode > 0 then
'end if    


EndofPlace2:
end if







screencopy


if mb = 1 and mx >= 624 and mx < 640 and my >= 0 and my < 16 then end

if mb = 2 and placemode = 0 then placemode = 1: sleep 100: goto LoopStart
if mb = 2 and placemode = 1 then placemode = 0: sleep 100: goto LoopStart
if mb = 2 and placemode = 4 then placemode = 1: sleep 100: goto LoopStart
fpscount = fpscount + 1
sleep 10
goto LoopStart

sleep 





