#!/bin/bash
#
mkdir temp
cd temp
rm *
f90split ../fd1d_heat_steady.f90
#
for FILE in `ls -1 *.f90`;
do
  gfortran -c -g $FILE >& compiler.txt
  if [ $? -ne 0 ]; then
    echo "Errors compiling " $FILE
    exit
  fi
  rm compiler.txt
done
rm *.f90
#
ar qc libfd1d_heat_steady.a *.o
rm *.o
#
mv libfd1d_heat_steady.a ~/lib/$ARCH
cd ..
rmdir temp
#
echo "Library installed as ~/lib/$ARCH/libfd1d_heat_steady.a"
