@echo off
set out=D:\out\
set geojson=%out%geojson\

for %%i in (%geojson%*) do (
    echo Creating mbtile for %%~ni.geojson
    docker run -it --rm -v %geojson%:/data tippecanoe:latest tippecanoe -b 0 -zg -ab --simplification=10 --drop-densest-as-needed --increase-gamma-as-needed -pS -S 10 -l %%~ni -o /data/%%~ni.mbtiles /data/%%~ni.geojson
    REM More aggressive simplification with -r and -g
    REM docker run -it --rm -v %geojson%:/data tippecanoe:latest tippecanoe -b 0 -zg -ab -r 5 -g 3 --simplification=10 --increase-gamma-as-needed -pS -S 10 -l %%~ni -o /data/%%~ni.mbtiles /data/%%~ni.geojson
    REM Only drop densest
    REM docker run -it --rm -v %geojson%:/data tippecanoe:latest tippecanoe -b 0 -zg -ab --drop-densest-as-needed -pS -S 10 -l %%~ni -o /data/%%~ni.mbtiles /data/%%~ni.geojson
)
mkdir %out%\polygon\
move %geojson%*.mbtiles %out%\polygon\