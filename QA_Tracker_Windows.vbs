' QA Tracker v3 — Windows Launcher
' Double-click to start. Requires Python 3 on PATH.
Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

folder = fso.GetParentFolderName(WScript.ScriptFullName)

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
    MsgBox "Python غير مثبت." & vbCrLf & vbCrLf & _
           "يرجى تثبيت Python 3 من: python.org" & vbCrLf & _
           "تأكد من تفعيل خيار 'Add Python to PATH' أثناء التثبيت.", _
           vbCritical, "QA Tracker"
    WScript.Quit
End If

' Kill any existing server on 8080 silently
WshShell.Run "cmd /c for /f ""tokens=5"" %a in ('netstat -aon ^| find "":8080""') do taskkill /F /PID %a", 0, True

' Start server silently in background
WshShell.Run "cmd /c cd /d """ & folder & """ && " & pythonCmd & " -m http.server 8080", 0, False

WScript.Sleep 1200
WshShell.Run "http://localhost:8080/qa_tracker.html"
