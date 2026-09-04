' QA Tracker — Claude Edition — installed launcher
' Runs silently: starts the local server using the bundled Python runtime
' (installed alongside this script), then opens the app in the default browser.
Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

installDir = fso.GetParentFolderName(WScript.ScriptFullName)
bundledPython = installDir & "\python\python.exe"

If fso.FileExists(bundledPython) Then
    pythonCmd = """" & bundledPython & """"
Else
    ' Fallback: bundled runtime missing for some reason — try system Python
    pythonCmd = ""
    For Each cmd In Array("python", "py", "python3")
        On Error Resume Next
        ret = WshShell.Run("cmd /c " & cmd & " --version", 0, True)
        If Err.Number = 0 And ret = 0 Then
            pythonCmd = cmd
            Exit For
        End If
        On Error GoTo 0
    Next
    If pythonCmd = "" Then
        MsgBox "Python غير موجود ولم يتم العثور على نسخة مضمّنة." & vbCrLf & _
               "يرجى إعادة تثبيت QA Tracker.", vbCritical, "QA Tracker"
        WScript.Quit
    End If
End If

' Kill any existing server on 8080 silently (e.g. from a previous session)
WshShell.Run "cmd /c for /f ""tokens=5"" %a in ('netstat -aon ^| find "":8080""') do taskkill /F /PID %a", 0, True

' Start server silently in the background, serving the install directory
WshShell.Run "cmd /c cd /d """ & installDir & """ && " & pythonCmd & " -m http.server 8080", 0, False

WScript.Sleep 1200
WshShell.Run "http://localhost:8080/qa_tracker.html"
