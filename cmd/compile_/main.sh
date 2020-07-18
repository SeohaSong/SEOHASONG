shs __trap__
ls *.cpp
filenames=$( echo $( ls *.cpp ) )
name=${filenames%%'.cpp'*}
bat_filepath="\
/Program^ Files^ ^(x86^)\
/Microsoft^ Visual^ Studio/2019/Community/Common7/Tools/VsDevCmd.bat"
cmd.exe /c "$bat_filepath & cl /EHsc $filenames"
if [ -f "$name.exe" ]; then
    echo
    ./$name.exe
    rm $name.exe
else echo "Compilation failed."; fi
for v in $filenames; do [ -f ${v%%.*}.obj ] && rm ${v%%.*}.obj; done
