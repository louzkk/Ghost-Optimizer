I_Icon := A_ScriptDir . "\Icon.ico"
IfExist, %I_Icon%
{
    Menu, Tray, Icon, %I_Icon%
    Menu, Tray, Tip, Ghost Optimizer | SOCD Cleaner
}
return

;;

#InstallKeybdhook
#SingleInstance
#UseHook On
#MaxHotkeysPerInterval 200

lastHorizontal := ""
lastVertical := ""

~a::
    lastHorizontal := "a"
    if GetKeyState("d", "P")
        SendInput {d up}
Return

~d::
    lastHorizontal := "d"
    if GetKeyState("a", "P")
        SendInput {a up}
Return

~a up::
    if (lastHorizontal = "a")
    {
        if GetKeyState("d", "P")
        {
            SendInput {d down}
            lastHorizontal := "d"
        }
        else
            lastHorizontal := ""
    }
Return

~d up::
    if (lastHorizontal = "d")
    {
        if GetKeyState("a", "P")
        {
            SendInput {a down}
            lastHorizontal := "a"
        }
        else
            lastHorizontal := ""
    }
Return

~w::
    lastVertical := "w"
    if GetKeyState("s", "P")
        SendInput {s up}
Return

~s::
    lastVertical := "s"
    if GetKeyState("w", "P")
        SendInput {w up}
Return

~w up::
    if (lastVertical = "w")
    {
        if GetKeyState("s", "P")
        {
            SendInput {s down}
            lastVertical := "s"
        }
        else
            lastVertical := ""
    }
Return

~s up::
    if (lastVertical = "s")
    {
        if GetKeyState("w", "P")
        {
            SendInput {w down}
            lastVertical := "w"
        }
        else
            lastVertical := ""
    }
Return

;; ! BSDK
