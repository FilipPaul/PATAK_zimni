import os
from pathlib import Path

paths = sorted(Path(R"C:\Users\Filip\Desktop\PATAK_zimni\MKC-SPR\prednasky").iterdir(), key=os.path.getmtime)
for path in paths:
    print(path.relative_to(R"C:\Users\Filip\Desktop\PATAK_zimni\MKC-SPR\prednasky"))
