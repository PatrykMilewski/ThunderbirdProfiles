function Use-SimpleLogger {
	Class SimpleLogger {
		[String]$logFileName
		[String]$logFileLocation

		SimpleLogger ([String]$logFIleName, [String]$logFileLocation) {
			Write-Verbose ("Constructing SimpleLogger Class instance with parameters 1: $logFileName 2: $logFileLocation")
			$this.logFileName = $logFileName
			$this.logFileLocation = $logFileLocation
			$this.Initialize()
		}

		Initialize() {
			Write-Verbose "Initializing Logger instance"
			if (!(Test-Path $this.logFileLocation)) {
				Write-Verbose "Log file not found, creating a new one"
				New-item -ItemType File $this.logFileLocation -Force
				$this.AddLog("Log file created.")
			}
		}

		AddLog([String]$newLog) {
			Write-Verbose ("Adding a new log: " + $newLog)
			"[" + (Get-Date) + ":] " + $newLog | Add-Content $this.logFileLocation
		}
	}
}s