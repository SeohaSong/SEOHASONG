path=${DDD_PATH#/mnt/c}/env/python
if [ ! -d /mnt/c/$path ]; then
    /mnt/c/Users/seohasong/AppData/Local/Programs/Python/Python35/python.exe \
    -m venv $path; fi
shs exe python -m pip install -U pip
shs exe pip install -U setuptools
shs exe pip install -U pandas
shs exe pip install -U pylint
shs exe pip install -U jupyter
shs exe pip install -U tensorflow
shs exe pip install -U matplotlib
shs exe pip install -U pyinstaller
