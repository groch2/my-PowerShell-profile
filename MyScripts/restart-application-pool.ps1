param ($server_domain_name, $application_pool_name)
$server_host_name = (Resolve-DnsName -Name $server_domain_name).NameHost
Write-Output ('server host name: {0}' -f $server_host_name)
Invoke-Command -ComputerName $server_host_name -ScriptBlock {
  Write-Output ('begin invoke command on computer: {0}' -f $Using:server_host_name)
  $application_pool_name = $Using:application_pool_name
  $application_pool_state = (Get-WebAppPoolState -Name $application_pool_name).Value
  Write-Output ('application_pool_state: {0}' -f $application_pool_state)
  Restart-WebAppPool -Name $application_pool_name
}
