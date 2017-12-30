function Use-EmailAutoresponder {
	Class EmailAutoresponder {
		[String]$from
		[String]$to
		[pscredential]$credential
		[String]$subject
		[String]$smtp
		[String]$port
		[String]$body = ""
		[Switch]$sendMail = $False
		[Switch]$isEmpty = $True
		
		EmailAutoresponder([String]$from, [String]$to, [String]$password, [String]$subject, [String]$smtp, [String]$port) {
			Write-Verbose ("Constructing EmailAutoresponder instance with parameters 1: $from 2: $to 3: $password 4: $subject 5: $smtp 6: $port")
			$this.from = $from
			$this.to = $to
			$secureString = ConvertTo-SecureString $password -AsPlainText -Force
			$this.credential = New-Object System.Management.Automation.PSCredential ($this.from, $secureString)
			$this.subject = $subject
			$this.smtp = $smtp
			$this.port = $port
		}

		[bool]SendEmail() {
			if ($this.isEmpty -eq $True) {
				Write-Verbose "Email autoresponder body is empty, not sending an email."
				return $False
			}

			try {
				Write-Verbose ("Sending email notification with body: " + $this.body)
				Send-MailMessage -From $this.from -To $this.to -Credential $this.credential -Subject $this.subject -Body $this.body -SmtpServer $this.smtp -Port $this.port -UseSsl -Encoding UTF8 -ErrorAction Stop
				Write-Verbose "Successfully sent notification"
				return $True
			}
			catch {
				Write-Verbose "Failed to send notification"
				return $False
			}
		}

		AppendToBody($body) {
			if ($this.sendMail -eq $True) {
				Write-Verbose ("Appending to email body new text: " + $body)
				$this.body += $body
				$this.isEmpty = $False
			}
			else {
				Write-Verbose "Not appending to email body a new text, because of sendMail switch set to false."
			}
		}
	}
}