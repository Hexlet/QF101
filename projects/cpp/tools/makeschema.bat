@echo off
schemetool makesrc -o FutInfoRepl.hpp -Dgen-namespaces=1 -O c --conn p2tcp://localhost:4001;app_name=stool --stream FORTS_FUTINFO_REPL
copy FutInfoRepl.hpp "..\src\cgate\FutInfoRepl.hpp" /y

schemetool makesrc -o OptInfoRepl.hpp -Dgen-namespaces=1 -O c --conn p2tcp://localhost:4001;app_name=stool --stream FORTS_OPTINFO_REPL
copy OptInfoRepl.hpp "..\src\cgate\OptInfoRepl.hpp" /y

schemetool makesrc -o FullOrderLog.hpp -Dgen-namespaces=1 -O c --conn p2tcp://localhost:4001;app_name=stool --stream FORTS_ORDLOG_REPL
copy FullOrderLog.hpp "..\src\cgate\FullOrderLog.hpp" /y

schemetool makesrc -o Messages.hpp -Dgen-namespaces=1 -O c p2fortsgate_messages.ini message
copy Messages.hpp "..\src\cgate\Messages.hpp" /y

del *.hpp