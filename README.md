# Easy-Form

EasyForm allows you to create PowerShell GUIs easily without any messy code!

# Examples

Some of the examples are listed down below to help you create anything with this module!

```powershell
#--- Import Custom Module ---#

if (Test-Path (Join-Path -Path $PSScriptRoot -ChildPath "EasyForm.psm1"))
{ 
    Unblock-File -LiteralPath (Join-Path -Path $PSScriptRoot -ChildPath "EasyForm.psm1") `
    -ErrorAction SilentlyContinue | Out-Null

    Import-Module -Name (Join-Path -Path $PSScriptRoot -ChildPath "EasyForm.psm1") -DisableNameChecking `
    -Global -ErrorAction SilentlyContinue | Out-Null
}
```

```powershell
#--- Form Example ---#

$Form = New-Form -Caption "EasyForm Example"
$Form.ShowDialog() | Out-Null
```

```powershell
#--- Form Example ---#

$Form = New-Form -Caption "EasyForm Example"
Show-Form -Parent $Form  | Out-Null
```

```powershell
#--- Form Example ---#

$Form = New-Form -Caption "EasyForm Example" -Height 200 -Width 400 -Color Red -BorderStyle FixedSingle
Show-Form -Parent $Form | Out-Null
```

```powershell
#--- Button Example ---#

$ButtonFormExample = New-Form -Caption "Button Example" -Height 200 -Width 300 -VisualStyles
$Button = New-Button -Text "Press me!" -Parent $ButtonFormExample -Width 100 -Color Black -Left 20 -Top 20
Add-Click -Parent $Button -ScriptBlock {

    [System.Windows.Forms.MessageBox]::Show("Button example works?")

}
Show-Form -Parent $ButtonFormExample
```

```powershell
#--- Checkbox Example ---#

$MainForm = New-Form -Caption "LMAO" -Height 200 -Width 200
$Checkbox = New-Checkbox -Text "Dark Mode" -Parent ($MainForm) -Top 20 -Left 20
Add-Check -Parent $Checkbox -ScriptBlock {
    if ($Checkbox.Checked)
    {
        [System.Windows.Forms.MessageBox]::Show("Checked")
    }
    else{
        [System.Windows.Forms.MessageBox]::Show("Not Checked")
    }
}
Show-Form -Parent $MainForm
```
