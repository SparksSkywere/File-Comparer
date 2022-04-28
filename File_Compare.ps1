Clear-Host
#File comparer of text files
#Import Library for forms
Add-Type -AssemblyName System.Windows.Forms
#Opens dialogbox to grab a file
function Open-DialogBox {

    Param (
    [Parameter(Mandatory=$False)]
    [string] $InitialDirectory
    )
    
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.InitialDirectory = $InitialDirectory
    $OpenFileDialog.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.FileName
}
#Opens dialogbox to grab another file
function Open-DialogBox {

    Param (
    [Parameter(Mandatory=$False)]
    [string] $InitialDirectory2
    )
    
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.InitialDirectory = $InitialDirectory2
    $OpenFileDialog.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.FileName
}
#The two files can now be compared, this can be made to more than one if you add more lines above and below to correspond the changes
    $File1 = Open-DialogBox -InitialDirectory C:\
    $File2 = Open-DialogBox -InitialDirectory2 C:\

    $compareref = Get-Content $File1
    $comparediff = Get-Content $File2
    $ComparedExport = Compare-Object $compareref $comparediff -PassThru
#Save-As 
    $SaveChooser = New-Object -Typename System.Windows.Forms.SaveFileDialog
    $SaveChooser.Title = "Save as"
    $SaveChooser.FileName = "Files Compared"
    $SaveChooser.DefaultExt = ".txt"
    $SaveChooser.Filter = 'Text Documents (*.txt)|*.txt'
    $SaveResult = $SaveChooser.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true }))
#Save file to the chosen directory
if($SaveResult){
    $ComparedExport | Out-File -FilePath $SaveChooser.FileName
}
exit
#Created by Chris Masters