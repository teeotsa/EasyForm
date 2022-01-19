function Add-Click
{
  param(
    [Parameter(Mandatory = $True)]
    $Parent,

    [Parameter(Mandatory = $True)]
    [scriptblock]
    $ScriptBlock
  )

  $Parent.Add_Click(
    $ScriptBlock
  )
}

function Add-Check
{
  param(
    [Parameter(Mandatory = $True)]
    $Parent,

    [Parameter(Mandatory = $True)]
    [scriptblock]
    $ScriptBlock
  )

  $Parent.Add_CheckStateChanged(
    $ScriptBlock
  )
}

function Show-Form
{
  param(
    [Parameter(Mandatory = $True)]
      [ValidateScript({
        ($_ -ne $null)
      })]
    $Parent
  )

  $Parent.ShowDialog() | Out-Null
}

function New-Form
{
  param(
    [Parameter(Mandatory = $false)]
    [ValidateScript({
      (($_.Length -lt 50) -eq $True)
    })]
    [String]
    $Caption = "Form",

    [Parameter(Mandatory = $false)]
    [ValidateScript({
      (($_ -gt [System.Windows.Forms.SystemInformation]::VirtualScreen.Height) -eq $False)
      (($_ -lt 0) -eq $False)
    })]
    [Int]
    $Height = 100,

    [Parameter(Mandatory = $false)]
    [ValidateScript({
      (($_ -gt [System.Windows.Forms.SystemInformation]::VirtualScreen.Width) -eq $False)
      (($_ -lt 0) -eq $False)
    })]
    [Int]
    $Width = 100,

    [Parameter(Mandatory = $false)]
    [String]
    $Color,

    [Parameter(Mandatory = $false)]
    [ValidateSet("Fixed3D", "None", "FixedSingle")]
    [String]
    $BorderStyle = "Fixed3D",

    [Parameter(Mandatory = $false)]
    [Switch] $VisualStyles
  )

  Add-Type -AssemblyName "System.Windows.Forms";
  $Form = New-Object "System.Windows.Forms.Form";
  if($VisualStyles)
  {
    [System.Windows.Forms.Application]::EnableVisualStyles()
  }
  $Form.Height = $Height;
  $Form.Width = $Width;
  $Form.Text = $Caption;
  if($Color.Length -ge 1)
  {
    $Form.BackColor = $Color
  }
  $Form.FormBorderStyle = $BorderStyle;
  $Form.Add_Shown({$Form.Activate()})
  Return ($Form);
}

function New-Label
{
  param(
    [Parameter(Mandatory = $False)]
    [String]
    $Text = "Label",

    [Parameter(Mandatory = $True)]
    $Parent,

    [Parameter(Mandatory = $False)]
    [Int]
    $Left = 0,

    [Parameter(Mandatory = $False)]
    [Int]
    $Top = 0,

    [Parameter(Mandatory = $False)]
    [String]
    $Color = "White",

    [Parameter(Mandatory = $False)]
    [ValidateSet("Microsoft Sans Serif", "Arial", "Arial Black", "Arial Bold")]
    [String]
    $Font = "Microsoft Sans Serif",

    [Parameter(Mandatory = $False)]
    [ValidateRange(1, 72)]
    [Int]
    $FontSize = 12
  )

    $Label = New-Object System.Windows.Forms.Label
    $Label.AutoSize = $True
    $Label.ForeColor = $Color
    $Label.Text = $Text
    $Label.Left = $Left
    $Label.Top = $Top
    #$Label.Size = New-Object System.Drawing.Size($FontSize)
    $Label.Font = New-Object System.Drawing.Font($Font, $FontSize)
    if($Parent)
    {
      $Parent.Controls.Add($Label)
      Return ($Label)
    }
}

function New-Button
{
  param(
    [Parameter(Mandatory = $False)]
    [String]
    $Text,

    [Parameter(Mandatory = $True)]
    $Parent,

    [Parameter(Mandatory = $False)]
    [Int]
    $Left = 0,

    [Parameter(Mandatory = $False)]
    [Int]
    $Top = 0,

    [Parameter(Mandatory = $False)]
    [String]
    $Color = "White",

    [Parameter(Mandatory = $False)]
    [ValidateSet("Microsoft Sans Serif", "Arial", "Arial Black", "Arial Bold")]
    [String]
    $Font = "Microsoft Sans Serif",

    [Parameter(Mandatory = $False)]
    [ValidateRange(1, 72)]
    [Int]
    $FontSize = 12,

    [Parameter(Mandatory = $False)]
    [Int]
    $Width = 50,

    [Parameter(Mandatory = $False)]
    [Int]
    $Height = 50
  )

  $Button = New-Object System.Windows.Forms.Button
  if($Text.Length -ge 1)
  {
    $Button.Text = $Text
  }
  $Button.Left = $Left
  $Button.Top = $Top
  $Button.Size = New-Object System.Drawing.Size($Width, $Height)
  $Button.Font = New-Object System.Drawing.Font($Font, $FontSize)
  $Button.ForeColor = $Color
  if($Parent)
  {
    $Parent.Controls.Add($Button)
    Return $Button
  }
}

function New-Panel
{
  param(
    [Parameter(Mandatory = $False)]
    [String]
    $Text = "Panel",

    [Parameter(Mandatory = $True)]
    $Parent,

    [Parameter(Mandatory = $False)]
    [Int]
    $Left = 0,

    [Parameter(Mandatory = $False)]
    [Int]
    $Top = 0,

    [Parameter(Mandatory = $False)]
    [String]
    $Color = "White",

    [Parameter(Mandatory = $False)]
    [ValidateSet(
        "Arial", "Bahnschrift", "Calibri", "Cambria", "Cambria Math", "Candara", "Comic Sans MS",      
        "Consolas", "Constantia", "Corbel", "Courier New", "Ebrima", "Franklin Gothic", "Gabriola",             
        "Gadugi", "Georgia", "HoloLens MDL2 Assets", "Impact", "Ink Free", "Javanese Text", "Leelawadee UI",         
        "Lucida Console", "Lucida Sans Unicode", "Malgun Gothic", "Microsoft Himalaya", "Microsoft JhengHei",    
        "Microsoft JhengHei UI", "Microsoft New Tai Lue", "Microsoft PhagsPa", "Microsoft Sans Serif", "Microsoft Tai Le",      
        "Microsoft YaHei", "Microsoft YaHei UI", "Microsoft Yi Baiti", "MingLiU_HKSCS-ExtB", "MingLiU-ExtB", "Mongolian Baiti",       
        "MS Gothic", "MS PGothic", "MS UI Gothic", "MV Boli", "Myanmar Text", "Nirmala UI", "NSimSun", "Palatino Linotype",     
        "PMingLiU-ExtB", "Segoe Fluent Icons", "Segoe MDL2 Assets", "Segoe Print", "Segoe Script", "Segoe UI", "Segoe UI Emoji",        
        "Segoe UI Historic", "Segoe UI Symbol", "Segoe UI Variable", "SimSun", "SimSun-ExtB", "Sitka Text", "Sylfaen", "Symbol",               
        "Tahoma", "Times New Roman", "Trebuchet MS", "Verdana", "Webdings", "Wingdings", "Yu Gothic", "Yu Gothic UI", "Unispace",             
        "Courier", "Fixedsys", "Modern", "MS Sans Serif", "MS Serif", "Roman", "Script", "Small Fonts", "System", "Terminal"              
    )]
    [String]
    $Font = "Microsoft Sans Serif",

    [Parameter(Mandatory = $False)]
    [ValidateRange(1, 72)]
    [Int]
    $FontSize = 12,

    [Parameter(Mandatory = $False)]
    [Int]
    $Width = 50,

    [Parameter(Mandatory = $False)]
    [Int]
    $Height = 50,

    [Parameter(Mandatory = $False)]
    [Switch]
    $AutoSize
  )

  $Panel = New-Object System.Windows.Forms.Panel
  $Panel.ForeColor = $Color
  $Panel.Location = New-Object System.Drawing.Point($Left, $Top)
  $Panel.Size = New-Object System.Drawing.Size($Width, $Height)
  if($Text.Length -ge 1)
  {
    $Panel.Text = $Text
    $Panel.Font = New-Object System.Drawing.Font($Font, $FontSize)
  }
  if($AutoSize)
  {
    $Panel.AutoSize = $True
  }
  if($Parent)
  {
    $Parent.Controls.Add($Panel)
    Return $Panel
  }
}

function New-Checkbox
{
  param(
    [Parameter(Mandatory = $False)]
    [String]
    $Text = "Checkbox",

    [Parameter(Mandatory = $True)]
    $Parent,

    [Parameter(Mandatory = $False)]
    [Switch]
    $Checked,

    [Parameter(Mandatory = $False)]
    [Int]
    $Top,

    [Parameter(Mandatory = $False)]
    [Int]
    $Left
  )

  $Checkbox = New-Object System.Windows.Forms.CheckBox
  $Checkbox.Text = $Text
  $Checkbox.AutoSize = $True
  $Checkbox.Location = New-Object System.Drawing.Point($Left, $Top)

  if($Checked)
  {
    $Checkbox.Checked = $True
  }
  if($Parent)
  {
    $Parent.Controls.Add($Checkbox)
    Return $Checkbox
  }
}