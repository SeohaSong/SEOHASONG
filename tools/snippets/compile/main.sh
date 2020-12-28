ls *.cpp
files=$( echo $( ls *.cpp ) )
name=${files%%'.cpp'*}

bat_file="\
/Program^ Files^ ^(x86^)\
/Microsoft^ Visual^ Studio/2019/Community/Common7/Tools/VsDevCmd.bat"
cmd.exe /c "$bat_file & cl /EHsc $files"

echo
./$name.exe
rm $name.exe

for v in $files
do
    [ -f ${v%%.*}.obj ] && rm ${v%%.*}.obj
done
