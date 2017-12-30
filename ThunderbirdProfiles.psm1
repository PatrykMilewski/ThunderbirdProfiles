# Get public and private function definition files.
    $Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
    $Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
    $ModuleRoot = $PSScriptRoot
	
# Import files
    Foreach($import in @($Public + $Private)) {
        Try {
            . $import.fullname
        }
        Catch {
            Write-Error -Message "Failed to import function $($import.fullname): $_"
        }
    }
	
Export-ModuleMember -Function Import-ThunderbirdProfile 
Export-ModuleMember -Function Export-ThunderbirdProfile