import sys
from shs.gardener import clear_current_dir

blacklist = [
    '.DS_Store',
    '__pycache__',
    '.ipynb_checkpoints',
    '.vscode',
    'nohup.out'
]

args = sys.argv
if len(args) == 2 and args[1] == "git":
    blacklist += [
        '.git',
        '.gitkeep',
        '.gitignore',
        '.gitmodules',
    ]

clear_current_dir('.', blacklist)
