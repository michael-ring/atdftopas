#!/bin/sh
FPCSRCDIR=$HOME/devel/freepascal/
FPCDIR=$HOME/fpcupdeluxe/fpc/bin/$(uname -m | sed "s,arm64,aarch64,g")-$(uname | tr '[:upper:]' '[:lower:]')/
FPCTARGET=freertos
PACKDIR=test/
CURDIR=$(pwd)
mkdir tmp 2>/dev/null
rm -f tmp/* 2>/dev/null

PATH=$FPCDIR:$PATH
export PATH

function compilesam {
  PLATFORM=$1
  case $PLATFORM in
    SAMD21) comp=armv6m ;
            fpu=none ;
            filebase=ATSAMD21 ;;
    SAMD51) comp=armv7em ;
            fpu=FPV4_SP_D16 ;
            filebase=ATSAMD51 ;;
  esac
  
  for mainheader in $PACKDIR/${filebase}*.atdf; do
    filename=$(basename $mainheader | tr '[:upper:]' '[:lower:]' | sed -e "s,\.atdf,,g" -e "s,atsam,sam,g")
    controller=$(basename $mainheader | tr '[:lower:]' '[:upper:]' | sed -e "s,\.ATDF,,g" )
    if [ -f patches/${filename}.patch ]; then
      cd tmp
      patch -p1 --no-backup-if-mismatch < ../patches/${filename}.patch
      cd ..
    fi
    python3 src/atdftopas.py --chip=${controller} --atdfdir=$PACKDIR >tmp/${filename}.pp
    echo Compiling $filename.pp ...
    fpc.sh -I$FPCSRCDIR/rtl/$FPCTARGET/arm -Tfreertos -Parm -Cp${comp} -Cf${fpu} -s tmp/${filename}.pp
    [ "$?" = 0 ] || exit 1
    rm -f tmp/*.s tmp/*.ppu
  done
}

#compilesam SAMD21
compilesam SAMD51
#exit 1
