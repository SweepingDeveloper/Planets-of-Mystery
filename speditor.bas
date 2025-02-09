'Have a nice day and God Bless!
'John 1:1, 3:16, Acts 10:38


'8 bit text: " !   % '  * ,-./0123456789   _ ? ABCDEFGHIJKLMNOPQRSTUVWXYZ      abcdefghijklmnopqrstuvwxyz     "
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
dim shared grid(16,16)
dim shared curr(256)
dim tcurr(256)


sub DrawBigSprite(filename as string,x,y,scale)
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

dim shared gallery(16,256)
dim galleryx(16)
dim galleryy(16)
dim galleryfname(16) as string
sub DrawSprite(arraynumber,x,y)
'cls
  for b = 0 to 31 step 2
        for c = 0 to 31 step 2
        scolor = gallery(arraynumber,((b/2)*16)+(c/2))
        if scolor <> 255 then pset (b+x,c+y), scolor
        if scolor <> 255 then pset (b+x+1,c+y), scolor
        if scolor <> 255 then pset (b+x,c+y+1), scolor
        if scolor <> 255 then pset (b+x+1,c+y+1), scolor
    next c
  next b
end sub


dim uparrow(1024),dnarrow(1024)



dim shared filenames(1000) as string
dim cfname(8) as string
dim choosefile as string
dim filename as string
dim activefile as string
dim mouseover as integer
dim now as double
dim newbutton(1024)
dim savebutton(1024)
dim exitbutton(1024)
dim newgallery(1024)
dim loadgallery(1024)
dim savegallery(1024)
dim fliph(1024)
dim flipv(1024)
dim background(64000)
dim puzzback(256)


dim alphabet(2) as string
alphabet(0) = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
alphabet(1) = "abcdefghijklmnopqrstuvwxyz"
x = 0
y = 0
t = 0
cchoose = 15
scroll = 0
fpscount = 0
fps = 0
mouseover = 0 
gchosen = 0


'CHDIR "c:\puzzle\"
'DrawBigSprite("uparrow.pix",224,32)
'DrawBigSprite("dnarrow.pix",224,224)

screen 18,,2
cls


'DrawBigSprite("puzzback.pix",0,0,16)
'get (0,0)-(15,15),puzzback

'cls
'for a = 0 to 1199
'    put ((a mod 40)*16,int(a/40)*16),puzzback
'next a
'bsave "pbback.bck",0,307200
bload "pbback.bck",0

get (0,0)-(639,479),background



for a = 0 to 15
    galleryx(a) = 64+((a mod 4)*32)
    galleryy(a) = 128+((int(a/4))*32)
    galleryfname(a) = "blank.pix"
next a
ReloadFile:
'CHDIR "c:\puzzle\tiles\"  'Change this to the directory you want to browse

    fcount = 0
        filename = dir$("tiles\*", 32)
        DO
            filenames(fcount) = filename
            filename = dir$("", attrib)
            fcount = fcount + 1
        LOOP WHILE filename <> ""
        




'CHDIR "c:\puzzle\"
now = TIMER

cls
DrawBigSprite("newicon.pix",0,0,32)
get (0,0)-(31,31),newbutton
cls
DrawBigSprite("saveicon.pix",0,0,32)
get (0,0)-(31,31),savebutton
cls
DrawBigSprite("exiticon.pix",0,0,32)
get (0,0)-(31,31),exitbutton
cls
DrawBigSprite("newg.pix",0,0,32)
get (0,0)-(31,31),newgallery
cls
DrawBigSprite("openg.pix",0,0,32)
get (0,0)-(31,31),loadgallery
cls
DrawBigSprite("saveg.pix",0,0,32)
get (0,0)-(31,31),savegallery
cls
DrawBigSprite("fliph.pix",0,0,32)
get (0,0)-(31,31),fliph
cls
DrawBigSprite("flipv.pix",0,0,32)
get (0,0)-(31,31),flipv




LoadGallery:
for a = 0 to 15
open "tiles\" + galleryfname(a) for input as #1    
  for b = 0 to 31 step 2
        for c = 0 to 31 step 2
        input #1, scolor
        gallery(a, ((b/2)*16)+(c/2)) = scolor
    next c
  next b
close #1

next a
screenset 1,0
LoopStart:
color 15,0:cls
put (0,0),background,trans
if now + 1 < TIMER then
now = TIMER
fps = fpscount
fpscount = 0

end if

put (0,0),background
getmouse x,y,,t
x2 = int((x-32)/32)
y2 = int((y-32)/32)
line (0,0)-step(639,18),cchoose,bf
color 0,cchoose: locate 1,1: print using "FPS: ## X: ### Y: ### B: # C: ### \          \"; fps; x; y; t; cchoose; mouseover; activefile
color 15,0
'color 15,0: locate 2,2: print "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
for a = 1 to 26
    if left$(filenames(scroll),1) = mid$(alphabet(1),a,1) then color 12: locate 2,1+a: print mid$(alphabet(0),a,1)
'color 12,0: locate 2,1+(mid$(alphabet(1),,1))
next a

for a = 0 to 15
DrawSprite(a,galleryx(a),galleryy(a))
if gchosen = a then line (galleryx(a),galleryy(a))-step(31,31),15,b
if gchosen <> a then line (galleryx(a),galleryy(a))-step(31,31),8,b
next a


'for a = 0 + scroll to 7 + scroll
' cfname(a-scroll) = filenames(a)
' DrawBigSprite(filenames(a),256,32+(a-scroll)*32)
'next a

locate 20,3: print cfname(y2)
for a = 21 to 24
 for b = 1 to 80
  if ((a-21)*80)+(b-1) < 256 then locate a,b: color ((a-21)*80)+(b-1): print chr$(219)
  if ((a-21)*80)+(b-1) = 255 then locate a,b: color 15: print chr$(176)
 next b
next a
line (311,31)-step(257,257),15,b


for a = 0 to 15
    for b = 0 to 15
      color curr((b*16)+a): locate a+3,(b*2)+40: print chr$(219)
      color curr((b*16)+a): locate a+3,(b*2)+41: print chr$(219)
      pset (576+(b*2),256+(a*2)), curr((b*16)+a)
      pset (577+(b*2),256+(a*2)), curr((b*16)+a)
      pset (576+(b*2),257+(a*2)), curr((b*16)+a)
      pset (577+(b*2),257+(a*2)), curr((b*16)+a)
      if curr((b*16)+a) = 255 then 
        color 15
        locate a+3,(b*2)+40: print chr$(176)
        locate a+3,(b*2)+41: print chr$(176)
      end if
    next b
next a


color 255

      
'DrawBigSprite("uparrow.pix",224,32)
'DrawBigSprite("dnarrow.pix",224,256)

put (32,32),newbutton, trans
put (96,32),savebutton, trans
put (128,32),exitbutton, trans
put (32,64),newgallery,trans
put (64,64),loadgallery,trans
put (96,64),savegallery,trans
put (32,96),fliph,trans
put (64,96),flipv,trans

for a = 311 to 568 step 16
 line (a,31)-step(0,257),15
 line (311,a-280)-step(257,0), 15
next a

1

if multikey(&h01) then end

'if t = 1 and dragactive = 1 then dragactive = 0

for a = 0 to 15
if t = 1 and x >= galleryx(a) and x <= galleryx(a)+31 and y >= galleryy(a) and y <= galleryy(a) + 31 then
    gchosen = a
   activefile = galleryfname(a)
   open "tiles\" + galleryfname(a) for input as #1
   for b = 0 to 255
      input #1, curr(b) 
   next b
   close #1
end if

if t = 2 and x >= galleryx(a) and x <= galleryx(a)+31 and y >= galleryy(a) and y <= galleryy(a) + 31 then
screenset 1,1
gscale = 32
gchosen = a
    dim letter as string 
LoadSprite0:    
    MakeBox(1,3,3,4,30,1,14,0)
    color 14,1: locate 3,3: input "Search Terms >"; letter
    if letter = "back" then goto DoneLoading
LoadSprite:
    MakeBox(0,16,64,640,400,1,14,0)
    fscount = 0
    for c = 0 to fcount
        if left$(filenames(c),len(letter)) = letter then 
            
            if gscale = 16 and fscount <= 79 then 
                DrawBigSprite(filenames(c),16+(fscount mod 8)*72,64+int(fscount/8)*32,gscale)
                locate 6+int(fscount/8)*2,3+((fscount-0) mod 8)*9: print left$((left$(filenames(c),len(filenames(c))-4)),8)
                fscount = fscount + 1
            end if

            if gscale = 32 and fscount <= 39 then 
                DrawBigSprite(filenames(c),16+(fscount mod 8)*72,64+int(fscount/8)*64,gscale)
                locate 7+int(fscount/8)*4,3+((fscount-0) mod 8)*9: print left$((left$(filenames(c),len(filenames(c))-4)),8)
                fscount = fscount + 1
            end if
            if fscount = 40 and gscale = 32 then gscale = 16: goto LoadSprite
                
        end if
    next c
    MakeBox(1,3,3,4,30,1,14,0)
    color 14,1: locate 3,3: line input "File to load >"; galleryfname(a)
    if galleryfname(a) = "back" then goto LoadSprite0
    if right$(galleryfname(a),4) <> ".pix" then galleryfname(a) = galleryfname(a) + ".pix"
   activefile = galleryfname(a)
   open "tiles\" + galleryfname(a) for input as #1
   for b = 0 to 255
      input #1, curr(b) 
   next b
   close #1
    screenset 1,0
    goto LoadGallery
DoneLoading:
end if



next a



'if t = 1 and x >= 0 and x <= 209 and y >= 16 and y <= 31 then
'rolodex = int(x/8)
'scroll = 0
'    do
'        if left$(filenames(scroll),1) = mid$(alphabet(0),rolodex,1) or left$(filenames(scroll),1) = mid$(alphabet(1),rolodex,1) then goto EndRolodex
'        scroll = scroll + 1
'    loop until scroll = fcount - 7
'EndRolodex:
'end if




'if t = 1 and x2 = 7  and y2 >= 0 and y2 < 8 then
'   activefile = cfname(y2)
'   open "tiles\" + cfname(y2) for input as #1
'   for a = 0 to 255
'      input #1, curr(a) 
'   next a
'   close #1
'end if

'if t = 1 and x >= 224 and x <= 255 and y >= 32 and y <= 63 then
'    DrawBigSprite("uparow2.pix",224,32)
'    scroll = scroll - 1: if scroll = -1 then scroll = 0
'end if

'if t = 1 and x >= 224 and x <= 255 and y >= 256 and y <= 287 then 
'    DrawBigSprite("dnarow2.pix",224,256)
'   scroll = scroll + 1: if scroll = fcount - 7 then scroll = scroll - 1
'end if



if t = 1 and y >= 320 and y <= 384 then
 cchoose = int((y-320)/16)*80 + int(x/8)
end if


if t = 1 and x >=320 and x <= 560 and y >= 32 and y <= 304 then
 curr((int((x-312)/16)*16)+int((y-32)/16)) = cchoose
end if

if t = 2 and x >=320 and x <= 560 and y >= 32 and y <= 304 then
    for a = 0 to 255
 curr(a) = cchoose
next a

end if

'Fliph
if t = 1 and x2 = 0 and y2 = 2 then
    for a = 0 to 255
        tcurr(a) = curr(a)
    next a
    for a = 0 to 255
        xc = int(a/16)*16
        yc = a mod 16
        curr(a) = tcurr(240-xc+yc)
    next a
end if
'Flipv
if t = 1 and x2 = 1 and y2 = 2 then
    for a = 0 to 255
        tcurr(a) = curr(a)
    next a
    for a = 0 to 255
        xc = int(a/16)*16
        yc = a mod 16
        curr(a) = tcurr(xc+(16-yc))
    next a
end if


if t = 1 and x2 = 0 and y2 = 0 then
for a = 0 to 255
 curr(a) = 255
next a
 activefile = "Untitled"
end if

if t = 1 and x2 = 0 and y2 = 1 then
for a = 0 to 15
 galleryfname(a) = "blank"
next a
end if

if t = 1 and x2 = 2 and y2 = 0 then
    screenset 1,1
    color 15,0
locate 5,3: input "Save File Name"; choosefile
   choosefile = choosefile + ".pix"
   open "tiles\" + choosefile for output as #1
   for a = 0 to 255
      print #1, curr(a) 
   next a
   close #1
   activefile = choosefile
   galleryfname(gchosen) = choosefile
   screenset 1,0
   goto ReloadFile
end if
if t = 1 and x2 = 3 and y2 = 0 then end
if t = 1 and x2 = 1 and y2 = 1 then
    screenset 1,1
    color 15,0
locate 5,3: input "Load Gallery File Name"; choosefile
   choosefile = choosefile + ".gal"
   open choosefile for input as #1
   for a = 0 to 15
      input #1, galleryfname(a)
   next a
   close #1
   screenset 1,0
   goto ReloadFile


end if

if t = 1 and x2 = 2 and y2 = 1 then
    screenset 1,1
    color 15,0
locate 5,3: input "Save Gallery File Name"; choosefile
   choosefile = choosefile + ".gal"
   open choosefile for output as #1
   for a = 0 to 15
      print #1, galleryfname(a)
   next a
   close #1
   screenset 1,0
   goto ReloadFile


end if




 WAIT &h3DA, 8
        ' Copy work page to visible page
        SCREENCOPY
fpscount = fpscount + 1
goto LoopStart


