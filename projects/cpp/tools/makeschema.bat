@echo off
schemetool makesrc -o FutInfoRepl.c -Dgen-namespaces=1 -O c --conn p2tcp://localhost:4001;app_name=stool --stream FORTS_FUTINFO_REPL
copy FutInfoRepl.c "..\src\cgate\FutInfoRepl.hpp" /y

@echo off
schemetool makesrc -o FullOrderLog.c -Dgen-namespaces=1 -O c --conn p2tcp://localhost:4001;app_name=stool --stream FORTS_ORDLOG_REPL
copy FullOrderLog.c "..\src\cgate\FullOrderLog.hpp" /y