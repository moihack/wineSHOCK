#!/bin/sh

echo 'SetTitleMatchMode, 2
WinWaitActive, World in Conflict - DEMO - InstallShield Wizard
Sleep 3000
Send, {PgDn 20}            ; scroll to the bottom of that license text
Sleep 3000
Send, {tab}                ; Get out of the richedit control
Sleep 3000
Send, an                   ; Accept license, next' > install_demo.ahk

unzip -o ahk.zip -d ./ahk
cd ahk
wine ./AutoHotKeyU64.exe ../install_demo.ahk &
cd ..

chmod +x ./nzd_wic_demo.exe
unzip -o nzd_wic_demo.exe -d ./wic_demo_setup_files
cd wic_demo_setup_files

echo '[InstallShield Silent]
Version=v7.00
File=Response File
[File Transfer]
OverwrittenReadOnly=NoToAll
[{D24CD157-E4C4-4184-9465-B5C025E736AD}-DlgOrder]
Dlg0={D24CD157-E4C4-4184-9465-B5C025E736AD}-SdWelcome-0
Count=3
Dlg1={D24CD157-E4C4-4184-9465-B5C025E736AD}-SdSetupTypeEx-0
Dlg2={D24CD157-E4C4-4184-9465-B5C025E736AD}-SdFinish-0
[{D24CD157-E4C4-4184-9465-B5C025E736AD}-SdWelcome-0]
Result=1
[{D24CD157-E4C4-4184-9465-B5C025E736AD}-SdSetupTypeEx-0]
Result=Default Installation
[Application]
Name=World in Conflict - DEMO
Version=1.0.0.0
Company=Massive Entertainment AB
Lang=0009
[{D24CD157-E4C4-4184-9465-B5C025E736AD}-SdFinish-0]
Result=1
bOpt1=0
bOpt2=0' > setup.iss

#finally install
wine ./setup.exe /s
cd ..

echo '#!/bin/sh

#get all parameters and output them in one var
#we want to output str="'$*'"
#we escape the single quote inside single quotes
str="'\''$*'\''"

#write config with ahk
cd ahk 
wine ./AutoHotKeyU64.exe ../run.ahk $str

#run game via wine
cd "$WINEPREFIX/drive_c/Program Files (x86)/Sierra Entertainment/World in Conflict - DEMO"
wine ./wic.exe -dx9 -benchmarksaveandexit
cd "$WINEPREFIX/drive_c/users/$USER/My Documents/World in Conflict - DEMO"
head -n3 fpsdata.txt > $LOG_FILE' > worldinconflict
chmod +x ./worldinconflict

echo '#NoEnv
EnvGet, wic_path, WICPATH

EnvGet, phpsleep, PHPSLEEP
sleep %PHPSLEEP%000

if (StrLen(wic_path) = 0)
{
    wic_path = C:\Program Files (x86)\Sierra Entertainment\World in Conflict - DEMO
}
IfNotExist, %wic_path%\wic.exe
{
    MsgBox, World in Conflict not found. Please set the environment variable WICPATH pointing to the installation directory.    
    exit
}

RegRead mydocs, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, Personal
FileDelete %mydocs%\World in Conflict - DEMO\fpsdata.txt

; Get the graphics card ID from the existing configfile
cfgfile = %mydocs%\World in Conflict - DEMO\Game Options.txt
FileRead, oldcfg, %cfgfile%
Last = borked
gpu_id = broken

Loop, PARSE, oldcfg, %A_Space%`n, `r
{
    param := A_LoopField
    if (param = "myGraphicsCardId")
    {
        Last = %param%
    }
    else if (Last = "myGraphicsCardId")
    {
        gpu_id = %param%
        Last = broken
    }
}

; Delete the old configfile so we can rewrite it
FileDelete %cfgfile%

Width   = 640
Height  = 480
Quality = Medium
Fullscreen = 1
Antialias = 0

Last = borked

Loop, %0%  ; For each parameter:
{
    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
    if(param = "-width" or param = "-height" or param = "-quality" or param = "-fullscreen"  or param = "-antialias")
    {
        Last = %param%
    }
    else
    {
        if(Last = "-width")
        {
            Width = %param%
        }
        if(Last = "-height")
        {
            Height = %param%
        }
        if(Last = "-quality")
        {
            Quality = %param%
        }
        if(Last = "-fullscreen")
        {
            Fullscreen = %param%
        }
        if(Last = "-antialias")
        {
            Antialias = %param%
        }
        Last = borked
    }
}

; Write the config file. This looks somewhat ugly...
FileAppend, myGraphicsCardId %gpu_id%`n, %cfgfile%
FileAppend, myWidth %Width%`n, %cfgfile%
FileAppend, myHeight %Height%`n, %cfgfile%
FileAppend, myFullscreenFlag %Fullscreen%`n, %cfgfile%
FileAppend, myFSAA %Antialias%`n, %cfgfile%

if (Quality = "VeryLow")
{
    FileAppend, myUsePixelShaderVersion 0`n, %cfgfile%
    FileAppend, myPhysicsDetail 0`n, %cfgfile%
    FileAppend, myAnisotropicFiltering 0`n, %cfgfile%
    FileAppend, myObjectLODLevelDistance 0`n, %cfgfile%
    FileAppend, myObjectLODLevelMeshLOD 0`n, %cfgfile%
    FileAppend, myParticleEmissionLevel 1`n, %cfgfile%
    FileAppend, myWaterReflectionSize 256`n, %cfgfile%
    FileAppend, myWiresQuality 0`n, %cfgfile%
    FileAppend, mySpeedTreeLodFactor 0.600000`n, %cfgfile%
    FileAppend, myShadowQuality 0`n, %cfgfile%
    FileAppend, myWaterQuality 0`n, %cfgfile%
    FileAppend, myTextureQuality 0`n, %cfgfile%
    FileAppend, myTerrainTextureQuality 0`n, %cfgfile%
    FileAppend, myUITextureQuality 0`n, %cfgfile%
    FileAppend, myUseHighestLod 0`n, %cfgfile%
    FileAppend, myDisplayWindowsMesh 0`n, %cfgfile%
    FileAppend, myDisplayDetailMesh 0`n, %cfgfile%
    FileAppend, myWreckFxFlag 0`n, %cfgfile%
    FileAppend, myUnitTracksFlag 0`n, %cfgfile%
    FileAppend, myUnitTracksLength 0`n, %cfgfile%
    FileAppend, myDecalsFlag 0`n, %cfgfile%
    FileAppend, myAutopropsFlag 0`n, %cfgfile%
    FileAppend, myGrassFlag 0`n, %cfgfile%
    FileAppend, myCratersFlag 0`n, %cfgfile%
    FileAppend, myHighQualityTerrainFlag 0`n, %cfgfile%
    FileAppend, myWaterReflectUnits 0`n, %cfgfile%
    FileAppend, myWaterReflectProps 0`n, %cfgfile%
    FileAppend, myWaterReflectEffects 0`n, %cfgfile%
    FileAppend, myWaterCrestsFlag 0`n, %cfgfile%
    FileAppend, myWaterTrailsFlag 0`n, %cfgfile%
    FileAppend, myRoadsFlag 0`n, %cfgfile%
    FileAppend, myCloudsFlag 0`n, %cfgfile%
    FileAppend, myCameraWarpEffectFlag 0`n, %cfgfile%
    FileAppend, myZFeatherFlag 0`n, %cfgfile%
    FileAppend, myParticlePhysicsFlag 0`n, %cfgfile%
    FileAppend, myPostFXFlag 0`n, %cfgfile%
    FileAppend, myPostFXSoftShadowsFlag 0`n, %cfgfile%
    FileAppend, myPostFXBloomFlag 0`n, %cfgfile%
    FileAppend, myPostFXHeatHazeFlag 0`n, %cfgfile%
    FileAppend, mySpeedTreeShadowsFlag 0`n, %cfgfile%
    FileAppend, mySpeedtreeHQShadersFlag 0`n, %cfgfile%
    FileAppend, myTransparencyAAFlag 0`n, %cfgfile%
    FileAppend, myVeryLowQualityFlag 1`n, %cfgfile%
    FileAppend, mySurfaceQuality 0`n, %cfgfile%
    FileAppend, myCloudShadowsFlag 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[0] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[1] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[2] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[3] 0`n, %cfgfile%
    FileAppend, myRotatingMinimapFlag 0`n, %cfgfile%
    FileAppend, myAlwaysShowObjectiveTextFlag 1`n, %cfgfile%
    FileAppend, myUnitWorldIconScale 1.000000`n, %cfgfile%
    FileAppend, myUnitBarIconScale 1.000000`n, %cfgfile%
    FileAppend, myUseMoodChangesFlag 1`n, %cfgfile%
    FileAppend, myStabilityFactor 0`n, %cfgfile%
    FileAppend, myACOfflineMode 1`n, %cfgfile%
    FileAppend, myQuadCoreLineOfSight 0`n, %cfgfile%
    FileAppend, myExplosionDebris 0`n, %cfgfile%
}
if (Quality = "Low")
{
    FileAppend, myUsePixelShaderVersion 0`n, %cfgfile%
    FileAppend, myPhysicsDetail 1`n, %cfgfile%
    FileAppend, myAnisotropicFiltering 0`n, %cfgfile%
    FileAppend, myObjectLODLevelDistance 1`n, %cfgfile%
    FileAppend, myObjectLODLevelMeshLOD 0`n, %cfgfile%
    FileAppend, myParticleEmissionLevel 1`n, %cfgfile%
    FileAppend, myWaterReflectionSize 256`n, %cfgfile%
    FileAppend, myWiresQuality 0`n, %cfgfile%
    FileAppend, mySpeedTreeLodFactor 0.600000`n, %cfgfile%
    FileAppend, myShadowQuality 0`n, %cfgfile%
    FileAppend, myWaterQuality 0`n, %cfgfile%
    FileAppend, myTextureQuality 0`n, %cfgfile%
    FileAppend, myTerrainTextureQuality 1`n, %cfgfile%
    FileAppend, myUITextureQuality 0`n, %cfgfile%
    FileAppend, myUseHighestLod 0`n, %cfgfile%
    FileAppend, myDisplayWindowsMesh 0`n, %cfgfile%
    FileAppend, myDisplayDetailMesh 0`n, %cfgfile%
    FileAppend, myWreckFxFlag 0`n, %cfgfile%
    FileAppend, myUnitTracksFlag 0`n, %cfgfile%
    FileAppend, myUnitTracksLength 1`n, %cfgfile%
    FileAppend, myDecalsFlag 0`n, %cfgfile%
    FileAppend, myAutopropsFlag 0`n, %cfgfile%
    FileAppend, myGrassFlag 0`n, %cfgfile%
    FileAppend, myCratersFlag 0`n, %cfgfile%
    FileAppend, myHighQualityTerrainFlag 0`n, %cfgfile%
    FileAppend, myWaterReflectUnits 0`n, %cfgfile%
    FileAppend, myWaterReflectProps 0`n, %cfgfile%
    FileAppend, myWaterReflectEffects 0`n, %cfgfile%
    FileAppend, myWaterCrestsFlag 0`n, %cfgfile%
    FileAppend, myWaterTrailsFlag 0`n, %cfgfile%
    FileAppend, myRoadsFlag 1`n, %cfgfile%
    FileAppend, myCloudsFlag 0`n, %cfgfile%
    FileAppend, myCameraWarpEffectFlag 0`n, %cfgfile%
    FileAppend, myZFeatherFlag 0`n, %cfgfile%
    FileAppend, myParticlePhysicsFlag 0`n, %cfgfile%
    FileAppend, myPostFXFlag 0`n, %cfgfile%
    FileAppend, myPostFXSoftShadowsFlag 0`n, %cfgfile%
    FileAppend, myPostFXBloomFlag 0`n, %cfgfile%
    FileAppend, myPostFXHeatHazeFlag 0`n, %cfgfile%
    FileAppend, mySpeedTreeShadowsFlag 0`n, %cfgfile%
    FileAppend, mySpeedtreeHQShadersFlag 0`n, %cfgfile%
    FileAppend, myTransparencyAAFlag 0`n, %cfgfile%
    FileAppend, myVeryLowQualityFlag 0`n, %cfgfile%
    FileAppend, mySurfaceQuality 0`n, %cfgfile%
    FileAppend, myCloudShadowsFlag 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[0] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[1] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[2] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[3] 0`n, %cfgfile%
    FileAppend, myRotatingMinimapFlag 0`n, %cfgfile%
    FileAppend, myAlwaysShowObjectiveTextFlag 1`n, %cfgfile%
    FileAppend, myUnitWorldIconScale 1.000000`n, %cfgfile%
    FileAppend, myUnitBarIconScale 1.000000`n, %cfgfile%
    FileAppend, myUseMoodChangesFlag 1`n, %cfgfile%
    FileAppend, myStabilityFactor 0`n, %cfgfile%
    FileAppend, myACOfflineMode 1`n, %cfgfile%
    FileAppend, myQuadCoreLineOfSight 0`n, %cfgfile%
    FileAppend, myExplosionDebris 0`n, %cfgfile%
}
if (Quality = "Medium")
{
    FileAppend, myUsePixelShaderVersion 1`n, %cfgfile%
    FileAppend, myPhysicsDetail 1`n, %cfgfile%
    FileAppend, myAnisotropicFiltering 0`n, %cfgfile%
    FileAppend, myObjectLODLevelDistance 1`n, %cfgfile%
    FileAppend, myObjectLODLevelMeshLOD 0`n, %cfgfile%
    FileAppend, myParticleEmissionLevel 2`n, %cfgfile%
    FileAppend, myWaterReflectionSize 256`n, %cfgfile%
    FileAppend, myWiresQuality 1`n, %cfgfile%
    FileAppend, mySpeedTreeLodFactor 0.800000`n, %cfgfile%
    FileAppend, myShadowQuality 1`n, %cfgfile%
    FileAppend, myWaterQuality 1`n, %cfgfile%
    FileAppend, myTextureQuality 1`n, %cfgfile%
    FileAppend, myTerrainTextureQuality 2`n, %cfgfile%
    FileAppend, myUITextureQuality 0`n, %cfgfile%
    FileAppend, myUseHighestLod 1`n, %cfgfile%
    FileAppend, myDisplayWindowsMesh 1`n, %cfgfile%
    FileAppend, myDisplayDetailMesh 1`n, %cfgfile%
    FileAppend, myWreckFxFlag 1`n, %cfgfile%
    FileAppend, myUnitTracksFlag 1`n, %cfgfile%
    FileAppend, myUnitTracksLength 1`n, %cfgfile%
    FileAppend, myDecalsFlag 0`n, %cfgfile%
    FileAppend, myAutopropsFlag 0`n, %cfgfile%
    FileAppend, myGrassFlag 1`n, %cfgfile%
    FileAppend, myCratersFlag 1`n, %cfgfile%
    FileAppend, myHighQualityTerrainFlag 1`n, %cfgfile%
    FileAppend, myWaterReflectUnits 0`n, %cfgfile%
    FileAppend, myWaterReflectProps 0`n, %cfgfile%
    FileAppend, myWaterReflectEffects 0`n, %cfgfile%
    FileAppend, myWaterCrestsFlag 0`n, %cfgfile%
    FileAppend, myWaterTrailsFlag 0`n, %cfgfile%
    FileAppend, myRoadsFlag 1`n, %cfgfile%
    FileAppend, myCloudsFlag 1`n, %cfgfile%
    FileAppend, myCameraWarpEffectFlag 0`n, %cfgfile%
    FileAppend, myZFeatherFlag 0`n, %cfgfile%
    FileAppend, myParticlePhysicsFlag 0`n, %cfgfile%
    FileAppend, myPostFXFlag 1`n, %cfgfile%
    FileAppend, myPostFXSoftShadowsFlag 0`n, %cfgfile%
    FileAppend, myPostFXBloomFlag 1`n, %cfgfile%
    FileAppend, myPostFXHeatHazeFlag 0`n, %cfgfile%
    FileAppend, mySpeedTreeShadowsFlag 0`n, %cfgfile%
    FileAppend, mySpeedtreeHQShadersFlag 0`n, %cfgfile%
    FileAppend, myTransparencyAAFlag 0`n, %cfgfile%
    FileAppend, myVeryLowQualityFlag 0`n, %cfgfile%
    FileAppend, mySurfaceQuality 1`n, %cfgfile%
    FileAppend, myCloudShadowsFlag 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[0] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[1] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[2] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[3] 0`n, %cfgfile%
    FileAppend, myRotatingMinimapFlag 0`n, %cfgfile%
    FileAppend, myAlwaysShowObjectiveTextFlag 1`n, %cfgfile%
    FileAppend, myUnitWorldIconScale 1.000000`n, %cfgfile%
    FileAppend, myUnitBarIconScale 1.000000`n, %cfgfile%
    FileAppend, myUseMoodChangesFlag 1`n, %cfgfile%
    FileAppend, myStabilityFactor 0`n, %cfgfile%
    FileAppend, myACOfflineMode 1`n, %cfgfile%
    FileAppend, myQuadCoreLineOfSight 0`n, %cfgfile%
    FileAppend, myExplosionDebris 0`n, %cfgfile%
}
if (Quality = "High")
{
    FileAppend, myUsePixelShaderVersion 1`n, %cfgfile%
    FileAppend, myPhysicsDetail 1`n, %cfgfile%
    FileAppend, myAnisotropicFiltering 2`n, %cfgfile%
    FileAppend, myObjectLODLevelDistance 3`n, %cfgfile%
    FileAppend, myObjectLODLevelMeshLOD 1`n, %cfgfile%
    FileAppend, myParticleEmissionLevel 3`n, %cfgfile%
    FileAppend, myWaterReflectionSize 512`n, %cfgfile%
    FileAppend, myWiresQuality 2`n, %cfgfile%
    FileAppend, mySpeedTreeLodFactor 1.000000`n, %cfgfile%
    FileAppend, myShadowQuality 1`n, %cfgfile%
    FileAppend, myWaterQuality 1`n, %cfgfile%
    FileAppend, myTextureQuality 2`n, %cfgfile%
    FileAppend, myTerrainTextureQuality 2`n, %cfgfile%
    FileAppend, myUITextureQuality 0`n, %cfgfile%
    FileAppend, myUseHighestLod 1`n, %cfgfile%
    FileAppend, myDisplayWindowsMesh 1`n, %cfgfile%
    FileAppend, myDisplayDetailMesh 1`n, %cfgfile%
    FileAppend, myWreckFxFlag 1`n, %cfgfile%
    FileAppend, myUnitTracksFlag 1`n, %cfgfile%
    FileAppend, myUnitTracksLength 2`n, %cfgfile%
    FileAppend, myDecalsFlag 1`n, %cfgfile%
    FileAppend, myAutopropsFlag 1`n, %cfgfile%
    FileAppend, myGrassFlag 1`n, %cfgfile%
    FileAppend, myCratersFlag 1`n, %cfgfile%
    FileAppend, myHighQualityTerrainFlag 1`n, %cfgfile%
    FileAppend, myWaterReflectUnits 1`n, %cfgfile%
    FileAppend, myWaterReflectProps 1`n, %cfgfile%
    FileAppend, myWaterReflectEffects 0`n, %cfgfile%
    FileAppend, myWaterCrestsFlag 1`n, %cfgfile%
    FileAppend, myWaterTrailsFlag 1`n, %cfgfile%
    FileAppend, myRoadsFlag 1`n, %cfgfile%
    FileAppend, myCloudsFlag 1`n, %cfgfile%
    FileAppend, myCameraWarpEffectFlag 1`n, %cfgfile%
    FileAppend, myZFeatherFlag 1`n, %cfgfile%
    FileAppend, myParticlePhysicsFlag 1`n, %cfgfile%
    FileAppend, myPostFXFlag 1`n, %cfgfile%
    FileAppend, myPostFXSoftShadowsFlag 1`n, %cfgfile%
    FileAppend, myPostFXBloomFlag 1`n, %cfgfile%
    FileAppend, myPostFXHeatHazeFlag 1`n, %cfgfile%
    FileAppend, mySpeedTreeShadowsFlag 1`n, %cfgfile%
    FileAppend, mySpeedtreeHQShadersFlag 1`n, %cfgfile%
    FileAppend, myTransparencyAAFlag 0`n, %cfgfile%
    FileAppend, myVeryLowQualityFlag 0`n, %cfgfile%
    FileAppend, mySurfaceQuality 2`n, %cfgfile%
    FileAppend, myCloudShadowsFlag 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[0] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[1] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[2] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[3] 0`n, %cfgfile%
    FileAppend, myRotatingMinimapFlag 0`n, %cfgfile%
    FileAppend, myAlwaysShowObjectiveTextFlag 1`n, %cfgfile%
    FileAppend, myUnitWorldIconScale 1.000000`n, %cfgfile%
    FileAppend, myUnitBarIconScale 1.000000`n, %cfgfile%
    FileAppend, myUseMoodChangesFlag 1`n, %cfgfile%
    FileAppend, myStabilityFactor 0`n, %cfgfile%
    FileAppend, myACOfflineMode 1`n, %cfgfile%
    FileAppend, myQuadCoreLineOfSight 0`n, %cfgfile%
    FileAppend, myExplosionDebris 0`n, %cfgfile%
}
if (Quality = "VeryHigh")
{
    FileAppend, myUsePixelShaderVersion 1`n, %cfgfile%
    FileAppend, myPhysicsDetail 2`n, %cfgfile%
    FileAppend, myAnisotropicFiltering 4`n, %cfgfile%
    FileAppend, myObjectLODLevelDistance 4`n, %cfgfile%
    FileAppend, myObjectLODLevelMeshLOD 1`n, %cfgfile%
    FileAppend, myParticleEmissionLevel 4`n, %cfgfile%
    FileAppend, myWaterReflectionSize 768`n, %cfgfile%
    FileAppend, myWiresQuality 3`n, %cfgfile%
    FileAppend, mySpeedTreeLodFactor 1.200000`n, %cfgfile%
    FileAppend, myShadowQuality 1`n, %cfgfile%
    FileAppend, myWaterQuality 1`n, %cfgfile%
    FileAppend, myTextureQuality 2`n, %cfgfile%
    FileAppend, myTerrainTextureQuality 2`n, %cfgfile%
    FileAppend, myUITextureQuality 1`n, %cfgfile%
    FileAppend, myUseHighestLod 1`n, %cfgfile%
    FileAppend, myDisplayWindowsMesh 1`n, %cfgfile%
    FileAppend, myDisplayDetailMesh 1`n, %cfgfile%
    FileAppend, myWreckFxFlag 1`n, %cfgfile%
    FileAppend, myUnitTracksFlag 1`n, %cfgfile%
    FileAppend, myUnitTracksLength 3`n, %cfgfile%
    FileAppend, myDecalsFlag 1`n, %cfgfile%
    FileAppend, myAutopropsFlag 1`n, %cfgfile%
    FileAppend, myGrassFlag 1`n, %cfgfile%
    FileAppend, myCratersFlag 1`n, %cfgfile%
    FileAppend, myHighQualityTerrainFlag 1`n, %cfgfile%
    FileAppend, myWaterReflectUnits 1`n, %cfgfile%
    FileAppend, myWaterReflectProps 1`n, %cfgfile%
    FileAppend, myWaterReflectEffects 1`n, %cfgfile%
    FileAppend, myWaterCrestsFlag 1`n, %cfgfile%
    FileAppend, myWaterTrailsFlag 1`n, %cfgfile%
    FileAppend, myRoadsFlag 1`n, %cfgfile%
    FileAppend, myCloudsFlag 1`n, %cfgfile%
    FileAppend, myCameraWarpEffectFlag 1`n, %cfgfile%
    FileAppend, myZFeatherFlag 1`n, %cfgfile%
    FileAppend, myParticlePhysicsFlag 1`n, %cfgfile%
    FileAppend, myPostFXFlag 1`n, %cfgfile%
    FileAppend, myPostFXSoftShadowsFlag 1`n, %cfgfile%
    FileAppend, myPostFXBloomFlag 1`n, %cfgfile%
    FileAppend, myPostFXHeatHazeFlag 1`n, %cfgfile%
    FileAppend, mySpeedTreeShadowsFlag 1`n, %cfgfile%
    FileAppend, mySpeedtreeHQShadersFlag 1`n, %cfgfile%
    FileAppend, myTransparencyAAFlag 1`n, %cfgfile%
    FileAppend, myVeryLowQualityFlag 0`n, %cfgfile%
    FileAppend, mySurfaceQuality 3`n, %cfgfile%
    FileAppend, myCloudShadowsFlag 1`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[0] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[1] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[2] 0`n, %cfgfile%
    FileAppend, myDisableFirstTimeTipFlags[3] 0`n, %cfgfile%
    FileAppend, myRotatingMinimapFlag 0`n, %cfgfile%
    FileAppend, myAlwaysShowObjectiveTextFlag 1`n, %cfgfile%
    FileAppend, myUnitWorldIconScale 1.000000`n, %cfgfile%
    FileAppend, myUnitBarIconScale 1.000000`n, %cfgfile%
    FileAppend, myUseMoodChangesFlag 1`n, %cfgfile%
    FileAppend, myStabilityFactor 0`n, %cfgfile%
    FileAppend, myACOfflineMode 1`n, %cfgfile%
    FileAppend, myQuadCoreLineOfSight 0`n, %cfgfile%
    FileAppend, myExplosionDebris 0`n, %cfgfile%
}

; And now the settings common to all presets
FileAppend, myCustomColors[0] 0:0:0`n, %cfgfile%
FileAppend, myCustomColors[1] 0:0:0`n, %cfgfile%
FileAppend, myCustomColors[2] 0:0:0`n, %cfgfile%
FileAppend, myCustomColors[3] 0:0:0`n, %cfgfile%
FileAppend, myCustomColors[4] 0:0:0`n, %cfgfile%
FileAppend, myCustomColors[5] 0:0:0`n, %cfgfile%
FileAppend, myCustomColors[6] 0:0:0`n, %cfgfile%
FileAppend, myCustomColors[7] 0:0:0`n, %cfgfile%
FileAppend, myShowBatteryLevelsFlag 1`n, %cfgfile%
FileAppend, myShowWirelessFlag 0`n, %cfgfile%
FileAppend, myAdapterId 0`n, %cfgfile%
FileAppend, myBrightnessValue 0`n, %cfgfile%
FileAppend, myGammaValue 0`n, %cfgfile%
FileAppend, myXPos 0`n, %cfgfile%
FileAppend, myYPos 0`n, %cfgfile%
FileAppend, myRefreshRate 60`n, %cfgfile%
FileAppend, mySoundEffectsVolume 9`n, %cfgfile%
FileAppend, myMusicVolume 7`n, %cfgfile%
FileAppend, myMovieVolume 10`n, %cfgfile%
FileAppend, myVoiceVolume 7`n, %cfgfile%
FileAppend, myVoipInVolume 10`n, %cfgfile%
FileAppend, myVoipOutVolume 10`n, %cfgfile%
FileAppend, myVoipThreshold 0.076000`n, %cfgfile%
FileAppend, mySoundTroubleShootingValue 1`n, %cfgfile%
FileAppend, myCameraRotateSpeedModifier 3`n, %cfgfile%
FileAppend, myCameraMoveSpeedModifier 3`n, %cfgfile%
FileAppend, myCameraMaxHeight 60`n, %cfgfile%
FileAppend, myForcePipelineSync 0`n, %cfgfile%
FileAppend, myUseVertexShaderVersion 0`n, %cfgfile%
FileAppend, myShowCutsceneSubtitles 1`n, %cfgfile%
FileAppend, myAlternativeColorProfileFlag 0`n, %cfgfile%
FileAppend, myVSyncFlag 0`n, %cfgfile%
FileAppend, myQualityScreenShotsFlag 1`n, %cfgfile%
FileAppend, myAutoActivateVoipFlag 0`n, %cfgfile%
FileAppend, myMuteVOIPFlag 0`n, %cfgfile%
FileAppend, myHighlightOnVOIPFlag 1`n, %cfgfile%
FileAppend, myMaxFPS 0`n, %cfgfile%
FileAppend, myDualScreenFlag 0`n, %cfgfile%
FileAppend, myDualScreenWidth 0`n, %cfgfile%
FileAppend, myDualScreenHeight 0`n, %cfgfile%
FileAppend, myDX10Flag 0`n, %cfgfile%
FileAppend, myShowAllHealthbarsFlag 0`n, %cfgfile%
FileAppend, myDisableHelpTipsFlag 0`n, %cfgfile%
FileAppend, mySkipTutorialFlag 0`n, %cfgfile%
FileAppend, myWaterReflectClouds 0`n, %cfgfile%' > run.ahk

#Run the benchmark once to create the configuration directory
cd "$WINEPREFIX/drive_c/Program Files (x86)/Sierra Entertainment/World in Conflict - DEMO"
wine ./wic.exe -dx9 -benchmarksaveandexit
