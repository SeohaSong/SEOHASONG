echo $1
echo $@
echo $( eval $INTRO )

seohasong
mv data/boilerplate/.git data/SEOHASONG/boilerplate
rm -r data/boilerplate
mv data/SEOHASONG/boilerplate data
