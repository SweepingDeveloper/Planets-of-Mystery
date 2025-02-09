
'*****************NPC CODE********************************
NPC: 
'dim tilexnote as integer
'dim tileynote as integer
'dim pxstart as integer
'dim pystart as integer
'dim pcharx as integer
'dim pchary as integer
'dim shared correct as integer
'dim shared spweaponflag as integer
'dim shared backgroundmusic as string

if npcactive = 1 then
    linecount = 0

    screenset 1,1
    open "npcs\" + npcname for input as #1
        for a as integer = 1 to 1000
            input #1, scriptline(a)
            linecount = linecount + 1
            if eof(1) then goto EndLoadNPC
        next a
        EndLoadNPC:
    close #1
Two:

    for a as integer = 1 to linecount
        if mid$(scriptline(a),1,9) = "STARTMODE" and right$(scriptline(a),1) = str(npcmode) then npcindex = a: goto FoundIndex
    next a
    npcindex = 1
    FoundIndex:
    warpflag = 0

    for a as integer = 1 to 9: choice(a) = "null": next a

    DO 
    SpecialCommand:
    if cheatmode(5) = 1 then color 15,0: locate 1,1: print using "\                        \ Line ###"; ecode(c); npcindex
    ink = inkey$: if ink = "!" then end
    'BOX
        if mid$(scriptline(npcindex),1,3) = "BOX" then
            scriptvar(0) = mid$(scriptline(npcindex),5,1)
            scriptvar(1) = mid$(scriptline(npcindex),7,3)
            scriptvar(2) = mid$(scriptline(npcindex),11,3)
            scriptvar(3) = mid$(scriptline(npcindex),15,3)
            scriptvar(4) = mid$(scriptline(npcindex),19,3)
            scriptvar(5) = mid$(scriptline(npcindex),23,3): shadow = val(scriptvar(5))
            scriptvar(6) = mid$(scriptline(npcindex),27,3)
            scriptvar(7) = mid$(scriptline(npcindex),31,3)
            MakeBox(val(scriptvar(0)),val(scriptvar(1)),val(scriptvar(2)),val(scriptvar(3)),val(scriptvar(4)),val(scriptvar(5)),val(scriptvar(6)),val(scriptvar(7)))
        end if
    
    'SPRITE
        dim namelength as integer
        if mid$(scriptline(npcindex),1,6) = "SPRITE" then
            scriptvar(0) = mid$(scriptline(npcindex),8,1)
            scriptvar(1) = mid$(scriptline(npcindex),10,val(scriptvar(0)))
            scriptvar(2) = mid$(scriptline(npcindex),11+val(scriptvar(0)),3)
            scriptvar(3) = mid$(scriptline(npcindex),15+val(scriptvar(0)),3)
            DrawSprite(scriptvar(1)+".pix",val(scriptvar(2)), val(scriptvar(3)),32)
        end if
    
    'SAY
        if mid$(scriptline(npcindex),1,3) = "SAY" then
            scriptvar(0) = mid$(scriptline(npcindex),5,2)
            scriptvar(1) = mid$(scriptline(npcindex),8,2)
            scriptvar(2) = mid$(scriptline(npcindex),11,3)
            scriptvar(3) = mid$(scriptline(npcindex),15,3)
            scriptvar(4) = mid$(scriptline(npcindex),19, len(scriptline(npcindex))-18)
            for a as integer = 1 to len(scriptvar(4))
                for b as integer = 1 to len(fonttext)
                    if mid$(fonttext,b,1) = mid$(scriptvar(4),a,1) then 
                        fx = (((b-1) mod 16)*16): fy = (int((b-1)/16)*16)
                    end if
                next b
                
                color val(scriptvar(2)), shadow
                put ((val(scriptvar(1))+(a-1))*16,val(scriptvar(0))*16),textfont,(fx,fy)-(fx+15,fy+15), trans
                

                
                'fbs_Play_Wave(npcsay,1)

                

                if val(scriptvar(3)) > 0 then sleep val(scriptvar(3))
            next a
        end if
    
    'PAUSE
        if mid$(scriptline(npcindex),1,5) = "PAUSE" then
            do: loop until inkey$ = ""
            scriptvar(0) = mid$(scriptline(npcindex),7,4)
            if val(scriptvar(0)) = 0 then sleep else sleep val(scriptvar(0))
        end if
    
    'CHOICE
        if mid$(scriptline(npcindex),1,6) = "CHOICE" then
            scriptvar(0) = mid$(scriptline(npcindex),8,1)
            scriptvar(1) = mid$(scriptline(npcindex),10,2)
            scriptvar(2) = mid$(scriptline(npcindex),13,2)
            scriptvar(3) = mid$(scriptline(npcindex),16,3)
            scriptvar(4) = mid$(scriptline(npcindex),20,3)
            scriptvar(5) = mid$(scriptline(npcindex),24, len(scriptline(npcindex))-23)
            choice(val(scriptvar(0))) = scriptvar(5)
            choicer(val(scriptvar(0))) = val(scriptvar(1))
            choicec(val(scriptvar(0))) = val(scriptvar(2))
            
            for a as integer = 1 to len(scriptvar(5))
                for b as integer = 1 to len(fonttext)
                    if mid$(fonttext,b,1) = mid$(scriptvar(5),a,1) then 
                        fx = (((b-1) mod 16)*16): fy = (int((b-1)/16)*16)
                    end if
                next b
                put ((val(scriptvar(2))+(a-1))*16,val(scriptvar(1))*16),textfont,(fx,fy)-(fx+15,fy+15), trans
                'locate val(scriptvar(1)), val(scriptvar(2))+(a-1): print mid$(scriptvar(5),a,1)
                sleep val(scriptvar(4))
            next a
        end if
    
    'CHOOSE
        if mid$(scriptline(npcindex),1,6) = "CHOOSE" then
            scriptvar(0) = mid$(scriptline(npcindex),8,3)
            cursor = 1
            z = inkey$: if z = " " then z = ""
            do: loop until inkey$ = ""
            do
                color 15
                endcursor = val(mid$(scriptline(npcindex),12,1))
                
                for b as integer = 1 to len(choice(cursor))
                    for c as integer = 1 to len(fonttext)
                        if mid$(fonttext,c,1) = mid$(choice(cursor),b,1) then 
                            fx = (((c-1) mod 16)*16): fy = (int((c-1)/16)*16)
                        end if
                    next c
                    put ((choicec(cursor)+(b-1))*16,choicer(cursor)*16),redtextfont,(fx,fy)-(fx+15,fy+15), trans
                next b
                
                Selection:
                z = inkey$: if z = "" then goto Selection
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
                    if cursor = 0 then cursor = endcursor
                
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
                    if cursor = endcursor+1 then cursor = 1
                end if
                if z = "q" then end
            loop until z = " "
        end if
    
    'CCHECK ## ##
        if mid$(scriptline(npcindex),1,6) = "CCHECK" then
            scriptvar(0) = mid$(scriptline(npcindex),8,2)
            scriptvar(1) = mid$(scriptline(npcindex),11,2)
            BigPrint(val(scriptvar(0)),val(scriptvar(1)),"$"+str(gold))
        end if
    
    'IFCHOICE
        if mid$(scriptline(npcindex),1,8) = "IFCHOICE" then
            scriptvar(0) = mid$(scriptline(npcindex),10,1)
            scriptvar(1) = mid$(scriptline(npcindex),12,3)
            if cursor = val(scriptvar(0)) then npcindex = val(scriptvar(1))-1: goto EndofIndex
        end if
    
    'IFDATE # ######## ###
        if mid$(scriptline(npcindex),1,6) = "IFDATE" then
            scriptvar(0) = mid$(scriptline(npcindex),8,1)
            scriptvar(1) = mid$(scriptline(npcindex),10,2)
            scriptvar(2) = mid$(scriptline(npcindex),12,2)
            scriptvar(3) = mid$(scriptline(npcindex),14,4)
            scriptvar(4) = mid$(scriptline(npcindex),19,3)
            if val(scriptvar(0)) = 1 then
               if m = val(scriptvar(1)) and d = val(scriptvar(2)) and y = val(scriptvar(3)) then npcindex = val(scriptvar(4))-1: goto EndofIndex
            end if
            if val(scriptvar(0)) = 0 then
               if m = val(scriptvar(1)) or d = val(scriptvar(2)) or y = val(scriptvar(3)) then npcindex = val(scriptvar(4))-1: goto EndofIndex
            end if
        end if
    
    'IFTIME # #### #### ###
    '##:##:##
        if mid$(scriptline(npcindex),1,6) = "IFTIME" then
            scriptvar(0) = mid$(scriptline(npcindex),8,1)
            scriptvar(1) = mid$(scriptline(npcindex),10,2)
            scriptvar(2) = mid$(scriptline(npcindex),12,2)
            scriptvar(3) = mid$(scriptline(npcindex),15,2)
            scriptvar(4) = mid$(scriptline(npcindex),17,2)
            scriptvar(5) = mid$(scriptline(npcindex),20,2)
            if val(scriptvar(0)) = 1 then
                if (val(mid$(time$,1,2))*60)+val(mid$(time$,4,2)) >= (val(scriptvar(1))*60)+val(scriptvar(2)) then
                      if (val(mid$(time$,1,2))*60)+val(mid$(time$,4,2)) <= (val(scriptvar(3))*60)+val(scriptvar(4)) then
                         npcindex = val(scriptvar(5)) - 1
                      end if
                end if
            end if
            if val(scriptvar(0)) = 0 then
                if (val(mid$(time$,1,2))*60)+val(mid$(time$,4,2)) <= (val(scriptvar(1))*60)+val(scriptvar(2)) then
                    if (val(mid$(time$,1,2))*60)+val(mid$(time$,4,2)) >= (val(scriptvar(3))*60)+val(scriptvar(4)) then
                        npcindex = val(scriptvar(5)) - 1
                    end if
                end if
            end if
        end if
    
    'IFWEEK ####### ###
        if mid$(scriptline(npcindex),1,6) = "IFWEEK" then
            scriptvar(0) = mid$(scriptline(npcindex),8,7)
            scriptvar(1) = mid$(scriptline(npcindex),16,3)
            for a as integer = 1 to 7
                if mid$(scriptvar(0),a,1) = "1" and dow = a then npcindex = val(scriptvar(1))-1: goto EndofIndex
            next a
        end if
    
    'VAR ## +#####
        if mid$(scriptline(npcindex),1,3) = "VAR" then
            scriptvar(0) = mid$(scriptline(npcindex),5,2)
            scriptvar(1) = mid$(scriptline(npcindex),8,1)
            scriptvar(2) = right$(scriptline(npcindex),5)
            if scriptvar(1) = "+" then npcvar(val(scriptvar(0))) = int(npcvar(val(scriptvar(0))) + val(scriptvar(2)))
            if scriptvar(1) = "-" then npcvar(val(scriptvar(0))) = int(npcvar(val(scriptvar(0))) - val(scriptvar(2)))
            if scriptvar(1) = "=" or scriptvar(1) = " " then npcvar(val(scriptvar(0))) = int(val(scriptvar(2)))
            if scriptvar(1) = "*" then npcvar(val(scriptvar(0))) = int(npcvar(val(scriptvar(0))) * val(scriptvar(2)))
            if scriptvar(1) = "/" then npcvar(val(scriptvar(0))) = int(npcvar(val(scriptvar(0))) / val(scriptvar(2)))
            if scriptvar(1) = "^" then npcvar(val(scriptvar(0))) = int(npcvar(val(scriptvar(0))) ^ val(scriptvar(2)))
            if scriptvar(1) = "M" or scriptvar(1) = "m" then npcvar(val(scriptvar(0))) = int(npcvar(val(scriptvar(0))) mod val(scriptvar(2)))
        end if
        
    'IFLOOK # ###
        if mid$(scriptline(npcindex),1,6) = "IFLOOK" then
            if charlook = val(mid$(scriptline(npcindex),8,1)) then npcindex = val(right$(scriptline(npcindex),3))-1
        end if
    'IFVAR ## ##### ### ###
        if mid$(scriptline(npcindex),1,5) = "IFVAR" then
            scriptvar(0) = mid$(scriptline(npcindex),7,2)
            scriptvar(1) = mid$(scriptline(npcindex),10,5)
            scriptvar(2) = mid$(scriptline(npcindex),16,3)
            scriptvar(3) = mid$(scriptline(npcindex),20,3)
            scriptvar(4) = mid$(scriptline(npcindex),6,1)
            if scriptvar(4) = " " or scriptvar(4) = "=" then if npcvar(val(scriptvar(0))) = val(scriptvar(1)) then npcindex = val(scriptvar(2))-1 else npcindex = val(scriptvar(3))-1
            if scriptvar(4) = "X" then if npcvar(val(scriptvar(0))) <> val(scriptvar(1)) then npcindex = val(scriptvar(2))-1 else npcindex = val(scriptvar(3))-1
            if scriptvar(4) = "<" then if npcvar(val(scriptvar(0))) < val(scriptvar(1)) then npcindex = val(scriptvar(2))-1 else npcindex = val(scriptvar(3))-1
            if scriptvar(4) = ">" then if npcvar(val(scriptvar(0))) > val(scriptvar(1)) then npcindex = val(scriptvar(2))-1 else npcindex = val(scriptvar(3))-1
            if scriptvar(4) = ")" then if npcvar(val(scriptvar(0))) >= val(scriptvar(1)) then npcindex = val(scriptvar(2))-1 else npcindex = val(scriptvar(3))-1
            if scriptvar(4) = "(" then if npcvar(val(scriptvar(0))) <= val(scriptvar(1)) then npcindex = val(scriptvar(2))-1 else npcindex = val(scriptvar(3))-1
            goto EndofIndex
        end if
    
    
    'SETRAND ## ##
        if mid$(scriptline(npcindex),1,7) = "SETRAND" then
            scriptvar(0) = mid$(scriptline(npcindex),9,2)
            scriptvar(1) = mid$(scriptline(npcindex),12,2)
            r1 = val(scriptvar(0))
            r2 = val(scriptvar(1))
            r3 = int(rnd*(r2-r1))+r1
        end if
    
    'IFRAND ## ###
        if mid$(scriptline(npcindex),1,6) = "IFRAND" then
            scriptvar(0) = mid$(scriptline(npcindex),8,2)
            scriptvar(1) = mid$(scriptline(npcindex),11,3)
            if r3 = val(scriptvar(0)) then npcindex = val(scriptvar(1))-1: goto EndofIndex
        end if
    
    'GOTO
        if mid$(scriptline(npcindex),1,4) = "GOTO" then
            npcindex = val(mid$(scriptline(npcindex),6,3))-1: goto EndofIndex
        end if
    
    'WARP
        if mid$(scriptline(npcindex),1,4) = "WARP" then
            warpflag = 1
            scriptvar(0) = mid$(scriptline(npcindex),6,2)
            scriptvar(1) = mid$(scriptline(npcindex),9,2)
            scriptvar(2) = mid$(scriptline(npcindex),12,2)
            scriptvar(3) = mid$(scriptline(npcindex),15,2)
            scriptvar(4) = mid$(scriptline(npcindex),18,len(scriptline(npcindex))-17)
            xoffset = 0
            yoffset = 0
            if scriptvar(4) = mapfilename then sameflag = 1
            mapfilename = scriptvar(4)
            xstart = val(scriptvar(0))
            ystart = val(scriptvar(1))
            charx = val(scriptvar(2))*32
            chary = val(scriptvar(3))*32
        end if
    
    'CASH +##### ###
    'CASH -##### ###
        if mid$(scriptline(npcindex),1,6) = "CASH +" then
            scriptvar(0) = mid$(scriptline(npcindex),7,5)
            scriptvar(1) = mid$(scriptline(npcindex),13,3)
            gold = gold + val(scriptvar(0))
        end if
    
        if mid$(scriptline(npcindex),1,6) = "CASH -" then
            scriptvar(0) = mid$(scriptline(npcindex),7,5)
            scriptvar(1) = mid$(scriptline(npcindex),13,3)
            gold = gold - val(scriptvar(0))
            if gold < 0 then 
                gold = gold + val(scriptvar(0))
                npcindex = val(scriptvar(1))-1
            end if
        end if
    
    'HEALTH +###
    'HEALTH -###
        if mid$(scriptline(npcindex),1,6) = "HEALTH" then
            scriptvar(0) = mid$(scriptline(npcindex),9,3)
            if mid$(scriptline(npcindex),8,1) = "+" then hp = hp + val(scriptvar(0))
            if mid$(scriptline(npcindex),8,1) = "-" then hp = hp - val(scriptvar(0))
            if hp > hpmax then hp = hpmax
            if hp <= 0 then gameoverflag = 1
        end if
    
    'SPWEAPON #
        if mid$(scriptline(npcindex),1,8) = "SPWEAPON" then
            spweapon(val(right$(scriptline(npcindex),1))) = 1
            color ,0: cls
            BigPrint(3,3,"Another astronaut is free!")

            
            for a as integer = 0 to 99
                for b as integer = 0 to 1: for c as integer = 0 to 1
                  pset (starsx(a)+b,starsy(a)+c),15
                next c: next b
            next a            
            for a as integer = 480 to -32 step -4
                put (320,a),ship,(32,0)-(63,31)
                sleep 50
                put (320,a),ship,(32,0)-(63,31)            
            next a
            
        end if
      
    'INVGET abcdefgh ###
        if mid$(scriptline(npcindex),1,6) = "INVGET" then
            index = 0
            do
                index = index + 1
            loop until mid$(scriptline(npcindex),8+index,1) = " "
            scriptvar(0) = mid$(scriptline(npcindex),8,index)
            scriptvar(1) = right$(scriptline(npcindex),3)
            
            InventoryChoice2:
            ninflag = 0
            FoundInventory:


    
    MakeBox(0,480,288,639,500,3,15,0)
    MakeBox(2,17,30,18,39,1,15,0)
    BigPrint(17,30,"PLACE")
    
    
    
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
    Selection4:
    line (486+ ((cursor-1) mod 3) * 48,298 + int((cursor-1)/3)* 48)-step(36,36),15,b

    z = inkey$: if z = "" then goto Selection4

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
    if z = "q" or z = "Q" then cursor = 10
    
loop until z = " " or z = "q" or z = "Q" 




'MakeBox(1,16,7,26,35,1,15,7)
'            MakeBox(2,13,2,14,20,1,15,7)
'            BigPrint(13,2,"PLACE IN INVENTORY")
'                for aa = 1 to 9
'        choice(aa) = ""
'        for b as integer = 1 to len(inventory(aa))
'            if mid$(inventory(aa),b,1) <> "." then choice(aa) =  choice(aa) + mid$(inventory(aa),b,1)
'            if mid$(inventory(aa),b,1) = "." then choice(aa) = choice(aa) + " "
'        next b
'        choice(aa) = inventory(aa)
'        choicer(aa) = 14+aa: choicec(aa) = 4
'        BigPrint(choicer(aa),choicec(aa),choice(aa))
'    next aa
'            choice(10) = "Give Up"
'            choicer(10) = 24: choicec(10) = 4
'            BigPrint(choicer(10),choicec(10),choice(aa))
'            MakeChoice(10)
'data "blank","Blank X0","Nothing so far"
'data "super","Guaranola X0","Triples your attack power."
'data "stamina","Muscle Patch X0", "Restores 25SP."
'data "heal","Ade X0","Restores 25HP."
'data "shield","iShield X0", "Triples your defense power."
'data "glasses","Glasses X0", "Provides 100% accuracy."
'data "firework","Fireworks X0", "Distracts enemy for 2 turns."
'data "light", "Light Show X0", "Distracts enemy for 3 turns."
'data "repel", "Repellant X0", "Repels enemies for 60 seconds."            
            ninflag = 0
            if cursor < 10 then
                if inventory(cursor) = "Blank" then 
                    inventory(cursor) = scriptvar(0) 
                 end if
                if left$(inventory(cursor),len(inventory(cursor))-3) = left$(scriptvar(0),len(scriptvar(0))-3) then
                    ninflag = 1
                    itemamt = val(right$(inventory(cursor),1))
                    inventory(cursor) = left$(inventory(cursor),len(inventory(cursor))-2) + "X" + str(itemamt+1)
                    goto Placed
                end if
                if left$(inventory(cursor),len(inventory(cursor))-3) <> left$(scriptvar(0),len(scriptvar(0))-3) and inventory(cursor) <> "Blank" then 
                    goto InventoryChoice2
                end if
                Placed:
                
                
                
    MakeBox(0,480,288,639,448,3,15,0)
    MakeBox(2,17,30,18,39,1,15,0)
    BigPrint(17,30,"PLACED")
    
    
    
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

                
                'MakeBox(1,16,7,26,35,1,15,7)
                'for aa = 1 to 9
                '    choice(aa) = ""
                '    for b as integer = 1 to len(inventory(aa))
                '        if mid$(inventory(aa),b,1) <> "." then choice(aa) =  choice(aa) + mid$(inventory(aa),b,1)
                '        if mid$(inventory(aa),b,1) = "." then choice(aa) = choice(aa) + " "
                '    next b
                '    choice(aa) = inventory(aa)
                '    choicer(aa) = 14+aa: choicec(aa) = 4
                '    BigPrint(choicer(aa),choicec(aa),choice(aa))
                'next aa
                sleep 1000
            end if
            if cursor = 10 then npcindex = val(scriptvar(1))-1
        end if
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    'INVGIVE abcdefgh ###
        if mid$(scriptline(npcindex),1,7) = "INVGIVE" then
            
            
            index = 0
            do
                index = index + 1
            loop until mid$(scriptline(npcindex),9+index,1) = " "
            scriptvar(0) = mid$(scriptline(npcindex),9,index)
            scriptvar(1) = right$(scriptline(npcindex),3)
            for a as integer = 1 to 8
                'print "Checking Inventory Item "; a
                if left$(inventory(a),len(inventory(a))-3) = scriptvar(0) then 
                    'print "Looking for "; scriptvar(0); " Found ";left$(inventory(a),len(inventory(a))-3) 
                   'if left$(right$(inventory(a),2),1) = "X" then
                        itemamt = val(right$(inventory(a),1))
                        inventory(a) = left$(inventory(a),len(inventory(a))-2) + "X" + str(itemamt-1)
                    'end if
                    if right$(inventory(a),1) = "0" then
                        inventory(a)=  "Blank"
                    end if
                   'if left$(right$(inventory(a),2),1) <> "X" then 
                    '    inventory(a) = "Blank"
                    'end if
                    goto InvFound
                end if
            next a
            'print "Didn't find it, so I'm going to line "; val(scriptvar(1))
            npcindex = val(scriptvar(1)) - 1
            InvFound:
            'sleep
        end if 
        
        
        
        
        
        
        
        
        
        
        
        
        
    
   ' 'INVUSE abcdefgh ### ###
   '     if mid$(scriptline(npcindex),1,7) = "INVUSE" then
   '         scriptvar(0) = mid$(scriptline(npcindex),9,8)
   '         scriptvar(1) = mid$(scriptline(npcindex),18,3)
   '         scriptvar(2) = mid$(scriptline(npcindex),22,3)
   '         if inventoryuse = scriptvar(0) then npcindex = val(scriptvar(1))-1 else npcindex = val(scriptvar(2))-1
   '     end if
    
    'SPCODE ## ## ###
        if mid$(scriptline(npcindex),1,6) = "SPCODE" then
            scriptvar(0) = mid$(scriptline(npcindex),8,2)
            scriptvar(1) = mid$(scriptline(npcindex),11,2)
            scriptvar(2) = mid$(scriptline(npcindex),14,3)
            scriptvar(3) = mid$(scriptline(npcindex),7,1)
            if scriptvar(3) <> "V" then spcode(val(scriptvar(0)),val(scriptvar(1))) = val(scriptvar(2))
            if scriptvar(3) = "V" then spcode(npcvar(val(scriptvar(0))),npcvar(val(scriptvar(1)))) = val(scriptvar(2))
        end if
    
    
    'SCREENSHOT
        if mid$(scriptline(npcindex),1,10) = "SCREENSHOT" then
            put (0,0), screenshot, TRANS
        end if
    
    'BATTLE ## ### ###
        if mid$(scriptline(npcindex),1,6) = "BATTLE" then
            npcbattle = 1
            scriptvar(0) = mid$(scriptline(npcindex),8,2)
            scriptvar(1) = mid$(scriptline(npcindex),11,3)
            scriptvar(2) = mid$(scriptline(npcindex),15,3)
            epick = val(scriptvar(0))
            bhp = hp
            color 15,0
            rpindex = 8: Battler
            RP8:
            color 15,0
            screenset 1,1
            if battlewin = 1 then npcindex = val(scriptvar(1))-1
            if battlewin = -1 then npcindex = val(scriptvar(2))-1
            color 15,0
        end if
        
   'COLLECT x..... ###
            if mid$(scriptline(npcindex),1,7) = "COLLECT" then
            index = 0
            do
                index = index + 1
            loop until mid$(scriptline(npcindex),9+index,1) = " "
            scriptvar(0) = mid$(scriptline(npcindex),9,index)
            scriptvar(1) = right$(scriptline(npcindex),3)
            
            InventoryChoice3:
            ninflag = 0
            FoundInventory2:


    
    MakeBox(0,480,288,639,500,3,15,0)
    MakeBox(2,17,30,18,39,1,15,0)
    BigPrint(17,30,"PLACE")
    
    
    
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
    if z = "q" or z = "Q" then cursor = 10
    
loop until z = " " or z = "q" or z = "Q" 

          
            ninflag = 0
            if cursor < 10 then
                if inventory(cursor) = "Blank" then 
                    inventory(cursor) = scriptvar(0) 
                 end if
                if left$(inventory(cursor),len(inventory(cursor))-3) = left$(scriptvar(0),len(scriptvar(0))-3) then
                    ninflag = 1
                    itemamt = val(right$(inventory(cursor),1))
                    inventory(cursor) = left$(inventory(cursor),len(inventory(cursor))-2) + "X" + str(itemamt+1)
                    goto Placed2
                end if
                if left$(inventory(cursor),len(inventory(cursor))-3) <> left$(scriptvar(0),len(scriptvar(0))-3) and inventory(cursor) <> "Blank" then 
                    goto InventoryChoice2
                end if
                Placed2:
                
                
                
    MakeBox(0,480,288,639,448,3,15,0)
    MakeBox(2,17,30,18,39,1,15,0)
    BigPrint(17,30,"PLACED")
    
    
    
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

                
                'MakeBox(1,16,7,26,35,1,15,7)
                'for aa = 1 to 9
                '    choice(aa) = ""
                '    for b as integer = 1 to len(inventory(aa))
                '        if mid$(inventory(aa),b,1) <> "." then choice(aa) =  choice(aa) + mid$(inventory(aa),b,1)
                '        if mid$(inventory(aa),b,1) = "." then choice(aa) = choice(aa) + " "
                '    next b
                '    choice(aa) = inventory(aa)
                '    choicer(aa) = 14+aa: choicec(aa) = 4
                '    BigPrint(choicer(aa),choicec(aa),choice(aa))
                'next aa
                sleep 1000
            end if
            if cursor = 10 then npcindex = val(scriptvar(1))-1
            spcode(tilexnote,tileynote) = 100
            
            if tilexnote < 10 and tileynote > 9 then gamecommand(numofcommands) = scriptvar(0) + " 0" + str(tilexnote) + " " + str(tileynote) + " 100"
            if tileynote < 10 and tilexnote > 9 then gamecommand(numofcommands) = scriptvar(0) + " " + str(tilexnote) + " 0" + str(tileynote) + " 100"
            if tilexnote < 10 and tileynote < 10 then gamecommand(numofcommands) = scriptvar(0) + " 0" + str(tilexnote) + " 0" + str(tileynote) + " 100"

            numofcommands = numofcommands + 1

           
        end if
    

    
    
    
    
    
    
    
    
    
        
        
    
    'ENDMODE
        if mid$(scriptline(npcindex),1,7) = "ENDMODE" then 
            npcactive = 0
            npcindex = 1
            goto EndofNPC
        end if
    
    'NEXTMODE
        if mid$(scriptline(npcindex),1,8) = "NEWMODE" then 
            npcmode = val(mid$(scriptline(npcindex),10,1))
        end if
    
    'WRITE
        if mid$(scriptline(npcindex),1,5) = "WRITE" then
            'index = 0
            'open "files\"+ activefile+".qst" for input as #1
            '    for a as integer = 1 to 11: input #1, crap(a): next a
            '    input #1, numofcommands
            '    for a as integer = 0 to numofcommands-1
            '        input #1, gamecommand(a)
            '    next a  
            'close #1
            'open "files\"+activefile+".qst" for output as #1
            '    for a as integer = 1 to 11: print #1, crap(a): next a
            '    numofcommands = numofcommands + 1
            '    print #1, numofcommands
            '    for a as integer = 0 to numofcommands-2
            '        print #1, gamecommand(a)
            '    next a
            gamecommand(numofcommands) = right$(scriptline(npcindex),len(scriptline(npcindex))-6)
            numofcommands = numofcommands + 1
            'close #1
        end if
    
    'IFLOC abcde CODE
        if mid$(scriptline(npcindex),1,5) = "IFLOC" then
            index = 0
            do
                index = index + 1
            loop until mid$(scriptline(npcindex),7+index,1) = " "
            if mapfilename = mid$(scriptline(npcindex),7,index) then
                scriptline(999) = right$(scriptline(npcindex),len(scriptline(npcindex))-(7+index))
                bunpcindex = npcindex
                npcindex = 999: goto SpecialCommand
            end if
        end if
        
    
    'START 
    'START HP ###/###
    'START ssp ###/###
    'START GOLD #####
    'START LVL ##
    'START IN SPACE
    'START AT abcdefgh ## ## ## ##
    'START INV 1 abcdefgh #
        if mid$(scriptline(npcindex),1,5) = "$TART" and startstatus = 1 then
            if mid$(scriptline(npcindex),7,2) = "HP" then
                hp = val(mid$(scriptline(npcindex),10,3))
                hpmax = val(mid$(scriptline(npcindex),14,3))
            end if
            if mid$(scriptline(npcindex),7,2) = "ssp" then
                ssp = val(mid$(scriptline(npcindex),10,3))
                spmax = val(mid$(scriptline(npcindex),14,3))
            end if
            if mid$(scriptline(npcindex),7,4) = "GOLD" then
                gold = val(mid$(scriptline(npcindex),12,5))
            end if
            if mid$(scriptline(npcindex),7,3) = "LVL" then
                level = val(mid$(scriptline(npcindex),11,2))
            end if
            if mid$(scriptline(npcindex),7,3) = "INV" then
                inventory(val(mid$(scriptline(npcindex),11,1))) = mid$(scriptline(npcindex),13,8)
                if inventory(val(mid$(scriptline(npcindex),11,1))) = "super" then inventorytitle(val(mid$(scriptline(npcindex),11,1))) = "Guaranola X" + mid$(scriptline(npcindex),22,1)
                if inventory(val(mid$(scriptline(npcindex),11,1))) = "stamina" then inventorytitle(val(mid$(scriptline(npcindex),11,1))) = "Muscle Patch X" + mid$(scriptline(npcindex),22,1)
                if inventory(val(mid$(scriptline(npcindex),11,1))) = "heal" then inventorytitle(val(mid$(scriptline(npcindex),11,1))) = "Ade X" + mid$(scriptline(npcindex),22,1)
                if inventory(val(mid$(scriptline(npcindex),11,1))) = "shield" then inventorytitle(val(mid$(scriptline(npcindex),11,1))) = "iShield X" + mid$(scriptline(npcindex),22,1)
                if inventory(val(mid$(scriptline(npcindex),11,1))) = "glasses" then inventorytitle(val(mid$(scriptline(npcindex),11,1))) = "Glasses X" + mid$(scriptline(npcindex),22,1)
                if inventory(val(mid$(scriptline(npcindex),11,1))) = "firework" then inventorytitle(val(mid$(scriptline(npcindex),11,1))) = "Fireworks X" + mid$(scriptline(npcindex),22,1)
                if inventory(val(mid$(scriptline(npcindex),11,1))) = "light" then inventorytitle(val(mid$(scriptline(npcindex),11,1))) = "Light Show X" + mid$(scriptline(npcindex),22,1)
                if inventory(val(mid$(scriptline(npcindex),11,1))) = "repel" then inventorytitle(val(mid$(scriptline(npcindex),11,1))) = "Repellant X" + mid$(scriptline(npcindex),22,1)
            end if
            if mid$(scriptline(npcindex),7,2) = "AT" then
                mapfilename = right$(scriptline(npcindex),len(scriptline(npcindex))-21)
                xstart = val(mid$(scriptline(npcindex),10,2))
                ystart = val(mid$(scriptline(npcindex),13,2))
                charx = val(mid$(scriptline(npcindex),16,2))*32
                chary = val(mid$(scriptline(npcindex),19,2))*32
                startstatus = 0
                npcactive = 0
                goto LoadFile0
            end if
            if mid$(scriptline(npcindex),7,8) = "IN SPACE" then
                start = 1
                startstatus = 0
                npcactive = 0
                goto LoopStart
            end if            
            
        end if

    'SPACE
        if mid$(scriptline(npcindex),1,5) = "SPACE" then 
            'fbs_Stop()
                    'FSound_StopSound('FSound_ALL)
        
            screenset 1,0
            npcactive = 0 
            goto LoopStart0
        end if

        EndofIndex:
        npcindex = npcindex + 1
        if npcindex = 1000 then npcindex = bunpcindex

    LOOP UNTIL npcindex = linecount+1
    EndofNPC:
    
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
    
    screenset 1,0
    npcactive = 0

end if
'************************************************************

sleep 5      'Delay.
if inkey$ = "q" then 
    end
end if

fpscount = fpscount + 1
if warpflag = 1 then 
    screenset 1,1
    for a as integer = 0 to 31
        for b as integer = 0 to 480 step 32
            line (0,b+a)-step(640,0),0
        next b
        sleep 25
    next a
    screenset 1,0
    goto LoadFile0
end if
if swordmode > 0 then swordmode = swordmode - 1
if start = 1 then start = 0: goto LoopStart
goto LoopStart2
'********END OF MAIN GAME LOOP*******************************






'**********************************************************



'if rpindex = 1 then goto RP1
'if rpindex = 2 then goto RP2
'if rpindex = 3 then goto RP3
'if rpindex = 4 then goto RP4
'if rpindex = 5 then goto RP5
'if rpindex = 6 then goto RP6
'if rpindex = 7 then goto RP7
'if rpindex = 8 then goto RP8












'*********LIST OF ITEMS************************************
data "blank","Blank","Nothing so far"
data "super","Guaranola","Triples your attack power."
data "stamina","Muscle Patch", "Restores 25SP."
data "heal","Ade","Restores 25HP."
data "shield","iShield", "Triples your defense power."
data "glasses","Glasses", "Provides 100% accuracy."
data "firework","Fireworks", "Distracts enemy for 2 turns."
data "light", "Light Show", "Distracts enemy for 3 turns."
data "repel", "Repellant", "Repels enemies for 60 seconds."
data "key","Key", "A regular key."
data "bosskey","Boss Key", "A boss key."
data "corndog", "Corn Dog", "Appeases the dork fish."










