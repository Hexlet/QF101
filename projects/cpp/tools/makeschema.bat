@echo off
schemetool makesrc -o FutInfoRepl.hpp -Dgen-namespaces=1 -O c --conn p2tcp://localhost:4001;app_name=stool --stream FORTS_FUTINFO_REPL
copy FutInfoRepl.hpp "..\src\cgate\FutInfoRepl.hpp" /y

@echo off
schemetool makesrc -o FullOrderLog.hpp -Dgen-namespaces=1 -O c --conn p2tcp://localhost:4001;app_name=stool --stream FORTS_ORDLOG_REPL
copy FullOrderLog.hpp "..\src\cgate\FullOrderLog.hpp" /y