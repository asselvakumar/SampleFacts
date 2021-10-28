# Configure IIS
iis_application_pool { 'Accounting':
  ensure                  => 'present',
  state                   => 'started',
  managed_pipeline_mode   => 'Integrated',
  managed_runtime_version => 'v4.0',
}

# Create Directories

file { 'c:\\inetpub\\Accounting':
  ensure => 'directory'
}


# Create Site
iis_site { 'Accounting':
  ensure          => 'started',
  physicalpath    => 'c:\\inetpub\\Accounting',
  applicationpool => 'Accounting',
  enabledprotocols => 'http',
  logflags             => ['ClientIP', 'Date', 'HttpStatus', 'HttpSubStatus', 'Method', 'Referer', 'ServerIP', 'ServerPort', 'Time', 'TimeTaken', 'UriQuery', 'UriStem', 'UserAgent', 'UserName', 'Win32Status'],
  logformat            => 'W3C',
  loglocaltimerollover => 'false',
  logpath              => 'C:\\inetpub\\logs\\LogFiles',
  logperiod            => 'Daily',
  preloadenabled       => false,
  serviceautostart     => true,
  authenticationinfo   => {
    'anonymous' => true,
    'basic' => false,
    'clientCertificateMapping' => false,
    'digest' => false,
    'iisClientCertificateMapping' => false,
    'windows' => false
  },
  limits               => {
    'maxconnections' => 4294967295,
    'connectiontimeout' => 120,
    'maxbandwidth' => 4294967295
  },
  bindings        => [
	{
      'bindinginformation'   => '*:443:accounting-dev.net.conning.coms',
      'protocol'             => 'https',
      'certificatehash'      => '3598FAE5ADDB8BA32A061C5579829B359409856F',
      'certificatestorename' => 'massive-ranking.delivery.puppet.com',
      'sslflags'             => 1,
    },
	{
	  'bindinginformation'   => '*:80:accounting-dev.net.conning.com',
      'protocol'             => 'http',
	},
	{
    'bindinginformation' => '*:9001:localhost',
    'protocol' => 'http'
	}
  ],
  require => File['c:\\inetpub\\Accounting'],
}

