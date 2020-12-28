from . import os, re, csv

def printUTF8(str_):
    utf8stdout = open(1, 'w', encoding='utf8', closefd=False)
    print(str_, file=utf8stdout)

def findGlobalFiles(root, key=None):
    def parse(path, paths):
        for name in os.listdir(path):
            path_ = os.path.join(path, name)
            if os.path.isdir(path_):
                parse(path_, paths)
            else:
                paths.append(path_)
    paths = []
    parse(root, paths)
    if key:
        proc = re.compile(key)
        paths = [v for v in paths if proc.match(v)]
    paths = sorted(paths)
    return paths

def findLine(key, path):
    with open(path, encoding='utf8') as f:
        try:
            lines = f.readlines()
        except:
            return 0
    for idx, line in enumerate(lines):
        if key in line:
            return idx + 1
    return 0

def findFile(key, root, file_key=None):
    paths = findGlobalFiles(root, file_key)
    for path in paths:
        val = findLine(key, path)
        if val:
            return path, val
    return ()

def readTable(file_, sep, header_chk):
    with open(file_, encoding='utf8') as f:
        rows = [v for v in csv.reader(f, delimiter=sep)]
    if header_chk:
        header = rows[0]
        rows = rows[1:]
        return header, rows
    return rows

def dumpTable(file_, header, rows, sep):
    if header:
        rows = [header] + rows
    with open(file_, 'w', encoding='utf8') as f:
        writer = csv.writer(f, delimiter=sep)
        writer.writerows(rows)

def isVoidTable(file_):
    if not os.path.isfile(file_):
        return True
    if readTable(file_, '\t', True)[1]:
        return False
    return True
