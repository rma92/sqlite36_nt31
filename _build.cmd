@REM call "%vcvars%" x86
@REM cl shell.c sqlite3.c /link /FIXED:NO /subsystem:console,3.10 /ENTRY:_start
@REM cl /O1 /Op /QIfist /DSQLITE_OMIT_FLOATING_POINT -U SQLITE_WIN32_HAS_WIDE shell.c sqlite3.c
@REM Run this in a VC6 command prompt. This builds using Visual C++ 6 compiler, the link libraries from Visual C++ 1.0 for NT (MSVCNT)
@REM Extract the Visual C++ 1.0 for NT LIB files somewhere so that they can be linked against, thus making a universal executable that only links against NT 3.1's Kernel32.dll/NTDLL.DLL for C library functions.
@REM If Long File Names are available, the DLL can be called winsqlite3.dll.
@REM set LIB=C:\MSVC4\LIB
@echo Compile and Link DLL as Sqlite3.dll
set LIB=C:\MSVCNT\LIB
cl sqlite3.c -DSQLITE_API=__declspec(dllexport) -link /FIXED:NO /subsystem:windows,3.10 -dll -out:sqlite3.dll
REM cl sqlite3.c -DSQLITE_API=__declspec(dllexport) -link /FIXED:NO /subsystem:windows,3.10 -dll -out:winsqlite3.dll
@REM cl 37shell\shell.c sqlite3.lib /LINK /OUT:shell_shared.exe
@echo Compile shared linked shell for sqlite3
cl /c 37shell\shell.c
link shell.obj sqlite3.lib /out:shell_sqlite3.exe /FIXED:NO /SUBSYSTEM:console,3.10
REM link shell.obj winsqlite3.lib /out:shell_winsqlite3.exe /FIXED:NO /SUBSYSTEM:console,3.10
@REM C:\MSVCNT\BIN\link32 shell.obj sqlite3.lib /out:shell_shared.exe /FIXED:NO /SUBSYSTEM:console,3.10

@echo build static binary
@REM cl 37shell\shell.c sqlite3.c -link /FIXED:NO /SUBSYSTEM:console,3.10 -out:x.exe
cl /c 37shell\shell.c sqlite3.c
LINK.EXE shell.obj sqlite3.obj /subsystem:console,3.10 /out:shell_static.exe
@REM C:\MSVCNT\BIN\LINK.EXE shell.obj sqlite3.obj /subsystem:console,3.10 /out:shell2.exe
@rem C:\msvc4\BIN\LINK.EXE shell.obj sqlite3.obj /FIXED:NO /subsystem:console,3.10
@REM LINK.EXE shell.obj sqlite3.obj /FIXED:NO /subsystem:console,3.10
