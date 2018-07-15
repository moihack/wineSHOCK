#!/bin/sh

echo '#!/bin/sh

cd "C:/Users/$USERNAME/My Documents/My Games/Far Cry 2/Benchmarks/Results"
rm BenchmarkReport1.csv

cd "C:\Program Files (x86)\Steam\steamapps\common\Far Cry 2\bin"

#this game does not require Steam to be running to launch the benchmark, plus
#Steam has a limit on the command line arguments that be passed to an executable so we launch the game directly
#command line parameters obtained from FC2BenchmarkTool

./FarCry2.exe -benchmark path -world world1 -spawnpos 1876.16,3523.59,34.81 -spawnangle -13.0094,0.0,-172.572 -benchmarkinputname "Benchmark_Small" -benchmarkloop 1 -benchmarkid "Run 1" -RenderProfile_ResolutionX 1280 -RenderProfile_ResolutionY 720 -RenderProfile_RefreshRate 60 -RenderProfile_MultiSampleMode 0 -RenderProfile_MultiSampleLevel 0 -RenderProfile_AlphaToCoverage 0 -RenderProfile_Fullscreen 0 -RenderProfile_VSync 0 -3dplatform d3d9 -RenderProfile_Quality custom -RenderProfile_CustomQuality_quality_VegetationQuality veryhigh -RenderProfile_CustomQuality_quality_WaterQuality high -RenderProfile_CustomQuality_quality_TerrainQuality ultrahigh -RenderProfile_CustomQuality_quality_GeometryQuality ultrahigh -RenderProfile_CustomQuality_quality_PostFxQuality medium -RenderProfile_CustomQuality_quality_TextureResolutionQuality ultrahigh -RenderProfile_CustomQuality_quality_ShadowQuality high -RenderProfile_CustomQuality_quality_AmbientQuality medium -RenderProfile_CustomQuality_quality_Hdr 0 -RenderProfile_CustomQuality_quality_Bloom 0 -RenderProfile_CustomQuality_quality_EnvironmentQuality high -RenderProfile_CustomQuality_quality_TextureQuality high -RenderProfile_CustomQuality_quality_DepthPassQuality ultrahigh -RenderProfile_CustomQuality_quality_id custom -GameProfile_FireConfig_QualitySetting Medium -EngineProfile_PhysicConfig_QualitySetting Medium -RealTreeProfile_Quality VeryHigh

while [ ! -f "C:/Users/$USERNAME/My Documents/My Games/Far Cry 2/Benchmarks/Results/BenchmarkReport1.csv" ]
do
  sleep 5 #check again in 5 seconds if benchmark finished running
done

#wait for file to be written successfully
sleep 5

cd "C:/Users/$USERNAME/My Documents/My Games/Far Cry 2/Benchmarks/Results"
#remove first line , take the 2nd column (delimiter is , character) and calculate avg fps with awk
tail -n +2 BenchmarkReport1.csv | cut -d "," -f 2 | awk '\''{ total += $1; count++ } END { print total/count }'\'' > $LOG_FILE' > far_cry_2

chmod +x ./far_cry_2
