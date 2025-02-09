'' Code example for loading all common image types using FreeImage.
'' The example loads an image passed as a command line argument.

'' The function FI_Load returns a null pointer (0) if there was an error during
'' loading.  Otherwise it returns a 32-bit PUT compatible buffer.

#include "FreeImage.bi"
#include "crt.bi"
#include "fbgfx.bi"

Function FI_Load(filename As String) As Any Ptr
    If Len(filename) = 0 Then
        Return NULL
    End If

    '' Find out the image format
    Dim As FREE_IMAGE_FORMAT form = FreeImage_GetFileType(StrPtr(filename), 0)
    If form = FIF_UNKNOWN Then
        form = FreeImage_GetFIFFromFilename(StrPtr(filename))
    End If

    '' Exit if unknown
    If form = FIF_UNKNOWN Then
        Return NULL
    End If

    '' Always load jpegs accurately
    Dim As UInteger flags = 0
    If form = FIF_JPEG Then
        flags = JPEG_ACCURATE
    End If

    '' Load the image into memory
    Dim As FIBITMAP Ptr image = FreeImage_Load(form, StrPtr(filename), flags)
    If image = NULL Then
        '' FreeImage failed to read in the image
        Return NULL
    End If

    '' Flip the image so it matches FB's coordinate system
    FreeImage_FlipVertical(image)

    '' Convert to 32 bits per pixel
    Dim As FIBITMAP Ptr image32 = FreeImage_ConvertTo32Bits(image)

    '' Get the image's size
    Dim As UInteger w = FreeImage_GetWidth(image)
    Dim As UInteger h = FreeImage_GetHeight(image)

    '' Create an FB image of the same size
    Dim As fb.Image Ptr sprite = ImageCreate(w, h)

    Dim As Byte Ptr target = CPtr(Byte Ptr, sprite + 1)
    Dim As Integer target_pitch = sprite->pitch

    Dim As Any Ptr source = FreeImage_GetBits(image32)
    Dim As Integer source_pitch = FreeImage_GetPitch(image32)

    '' And copy over the pixels, row by row
    For y As Integer = 0 To (h - 1)
        memcpy(target + (y * target_pitch), _
               source + (y * source_pitch), _
               w * 4)
    Next

    FreeImage_Unload(image32)
    FreeImage_Unload(image)

    Return sprite
End Function


ScreenRes 640, 480,32
'screen 18,,2

Dim As String filename = Command(1)

Dim As Any Ptr image = FI_Load("fmod_logo.png")



If image <> 0 Then
    
    Put (0, 0), image
Else
    Print "Problem while loading file : " & filename
End If
locate 10,1: print "WAS PREVIOUSLY USED IN THIS GAME.  THE GAME IS NOW SILENT."

sleep 4000






'Have a nice day and God Bless!
'John 1:1, 3:16, Acts 10:38
'ScreenRes 640, 480, 8,2 
'SCREEN 18, 32, 8, 1
'#INCLUDE "fmod.bi"
' Initialise FMOD with 48000Hz, 8 channels.

dim shared spacebgmusic as integer
dim shared npcsay as integer
dim shared mars as integer
dim shared tackle as integer
dim shared laser as integer
dim shared pigup as integer
dim shared blanketbomb as integer
'Game originally used FMOD.

dim shared explode as integer
dim shared quan as integer
dim shared ix as integer
dim shared iy as integer
dim shared password as string
dim shared inumbers(3072) as integer
dim shared cheatactive as integer
dim shared warpchoice as string
dim shared mshipactive as integer
dim shared scheck as integer

'0: Infinite HP/Finite HP
'1: Infinite SP/Finite SP
'2: Infinite Money/ Finite Money
'3: No battles/Battles
'4: Warp by pressing PGDN
dim shared cheatmode(6) as integer
for a as integer = 0 to 5
    cheatmode(a) = 0
next a
cheatactive = 0

'npcsay = FSOUND_Sample_Load(FSOUND_FREE, "audio\npcsay.mp3", 0, 0, 0)
'mars = FSOUND_Sample_Load(FSOUND_FREE, "audio\mars.mp3", 0, 0, 0)
'tackle = FSOUND_Sample_Load(FSOUND_FREE, "audio\tackle.mp3", 0, 0, 0)
'laser = FSOUND_Sample_Load(FSOUND_FREE, "audio\laser.mp3", 0, 0, 0)
'pigup = FSOUND_Sample_Load(FSOUND_FREE, "audio\pigup.mp3",0,0,0)
'blanketbomb = FSOUND_Sample_Load(FSOUND_FREE, "audio\blanketbomb.mp3",0,0,0)
'explode = FSOUND_Sample_Load(FSOUND_FREE, "audio\explode.mp3",0,0,0)

'backgroundMusic = FMUSIC_LoadSong("uw2-07.mid")
'mars = FMUSIC_LoadSong("audio\mars.mid")




'FSOUND_Init(48000, 8, 0)




screen 18,,2
cls




#include "rpg2010.bi"
#include "battler.bi"
#include "rpgstart.bi"
#include "space.bi"
#include "actrpg.bi"
#include "npccode.bi"

