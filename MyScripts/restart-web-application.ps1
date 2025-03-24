param ($server_name, $website_name, $application_pool_name)
Write-Output ('server_name: {0}' -f $server_name)
Write-Output ('website_name: {0}' -f $website_name)
Write-Output ('application_pool_name: {0}' -f $application_pool_name)
$server_host_name = (Resolve-DnsName -Name $server_name).NameHost
Write-Output ('server host name: {0}' -f $server_host_name)
Invoke-Command -ComputerName $server_host_name -ScriptBlock {
  Write-Output ('begin invoke command on computer: {0}' -f $Using:server_host_name)

  $website_name = $Using:website_name
  $application_pool_name = $Using:application_pool_name

  $website_state = (Get-WebsiteState -Name $website_name).Value
  Write-Output ('website_state_1: {0}' -f $website_state)

  Stop-Website -Name $website_name
  $website_state = (Get-WebsiteState -Name $website_name).Value
  Write-Output ('website_state_2: {0}' -f $website_state)

  $application_pool_state = (Get-WebAppPoolState -Name $application_pool_name).Value
  Write-Output ('application_pool_state_1: {0}' -f $application_pool_state)

  Restart-WebAppPool -Name $application_pool_name
  $application_pool_state = (Get-WebAppPoolState -Name $application_pool_name).Value
  Write-Output ('application_pool_state_2: {0}' -f $application_pool_state)

  Start-Website -Name $website_name
  $website_state = (Get-WebsiteState -Name $website_name).Value
  Write-Output ('website_state_3: {0}' -f $website_state)
}
