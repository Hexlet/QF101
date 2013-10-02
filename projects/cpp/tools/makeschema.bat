@echo off
schemetool makesrc -o FutInfoRepl.c -O c --conn p2tcp://localhost:4001;app_name=stool --stream FORTS_FUTINFO_REPL
copy FutInfoRepl.c "..\src\cgate\FutInfoRepl.c" /y