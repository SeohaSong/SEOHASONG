cd $SHS_PATH
python.exe -m pip install --upgrade pip
python.exe -m venv $HOST_SHS_PATH/env/python
cmd.exe /c " \
    $HOST_SHS_PATH/env/python/Scripts/activate &\
    python -m pip install --upgrade pip &\
    pip install --upgrade tensorflow &\
    pip install --upgrade jupyter \
"
cmd.exe /c " \
    $HOST_SHS_PATH/env/python/Scripts/activate &\
    jupyter-notebook . \
"
cmd.exe /c " \
    $HOST_SHS_PATH/env/python/Scripts/activate &\
    pip show tensorflow \
"