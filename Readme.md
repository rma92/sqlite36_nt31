# SQlite 3.6 (+3.7 shell) for Windows NT 3.1 and later
This is a slightly modified sqlite 3.6 + the shell from an early 3.7 version that is able to be compiled and run on Windows NT 3.1 and Windows 95, thus having no dependencies on anything other than KERNEL32.dll and NTDLL.DLL.

## Build requirements
* Microsoft Visual C++ 1.0 for NT's Library files
* Microsoft Visual C++ 6.0 compiler, headers, and link.exe

The easiest way to set this up is to install Visual C++ 1.0 for NT, then install Visual Studio 6/Visual C++ 6.0.  Only the build tools are required.  I compiled this on Windows Server 2003.

## Building
* Open a Visual C++ 6 command prompt (`%windir%\system32\cmd.exe /k "C:\Program Files\Microsoft Visual Studio\VC98\Bin\vcvars32.bat"`)
* Check that the path to the Visual C++ 1.0 LIB files is correct in `_build.cmd`. (the SET LIB line)
* CD to the directory with the code and run `_build.cmd` from the Visual C++ 6 command prompt
* `_clean.cmd` can be used to delete the build artifacts.

## Other considerations
* It doesn't seem to be a drop in replacement for winsqlite3.dll on Windows 10 yet.  It is possible that dynamically loading the required ordinals may allow a program to use either this sqlite3.dll or winsqlite3.dll that ships with Windows 10.
* Visual C++ 1.0's "LIBC.LIB", which is in the repo, only references kernel32.dll, not any separate C runtime DLL, even though crtdll.dll exists on the system, and there is an msvcrt.lib that references a DLL with that name.  To confirm this, `dumpbin LIBC.lib /ALL` will show only references to kernel32.dll.
* patch.h in the shell directory implements two functions that were missing in Sqlite 3.6 but the shell looks for.
* Some minor changes were made to shell.c and sqlite3.c by commenting out a few OS functions that require newer systems.  This is made easier since SQLite 3.6 still officially supported Windows CE's very limited API.
* The Win32s (on Windows 3.1) don't support console applications.  I haven't tested if the DLL will run on the Win32s.
