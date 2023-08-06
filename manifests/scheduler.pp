# @summary manage pagerduty file presence on the system.
#
# @param service
#   Desired systemd service and timer configurations.
#
# @param data
#   Desired systemd service and timer data in orchestration.
#
include stdlib

function validate_hash($value) {
  unless $value =~ Hash {
    fail("parameter expected to be a hash, received: ${value}")
  }
}
#
class systemd::scheduler (
  Hash $service = {},
  Hash $data = {},
) {
  include pagerduty::file

  validate_hash($service)

  validate_hash($data)

  unless 'name' in $service {
    fail("service 'name' parameter is required")
  }

  unless 'enable' in $service {
    fail("service 'enable' parameter is required")
  }

  unless 'ensure' in $service {
    fail("service 'ensure' parameter is required")
  }

  unless $service['enable']  in ['false', 'true'] {
    fail("service 'enable' acceptable values are ['false' 'true'], got `${service['enable']}`")
  }

  unless $service['ensure']  in ['absent', 'present'] {
    fail("service 'ensure' acceptable values are ['absent' 'present'], got `${service['ensure']}`")
  }

  if $service['ensure'] == 'present' {
    unless 'service' in $data and 'timer' in $data {
      fail("data parameter expects to include both 'service', 'timer'")
    }
  }

  $file_ensure = $service['ensure'] ? {
    'present' => 'file',
    default   => 'absent',
  }

  $service_ensure = $service['ensure'] ? {
    'present' => 'running',
    default   => 'stopped',
  }

  file { "/usr/lib/systemd/system/${service['name']}.timer":
    ensure  => $file_ensure,
    content => $data['timer'],
    notify  => Service["${service['name']}.timer"],
  }

  file { "/usr/lib/systemd/system/${service['name']}.service":
    ensure  => $file_ensure,
    content => $data['service'],
    notify  => Service["${service['name']}.timer"],
  }

  exec { "systemctl restart ${service['name']}.service":
    refreshonly => true,
    command     => "/bin/systemctl restart ${service['name']}.service",
  }

  exec { "systemctl restart ${service['name']}.timer":
    refreshonly => true,
    command     => "/bin/systemctl restart ${service['name']}.timer",
    notify      => Exec["systemctl restart ${service['name']}.service"],
  }

  exec { 'systemd-daemon-reload':
    refreshonly => true,
    command     => '/bin/systemctl daemon-reload',
    notify      => Exec["systemctl restart ${service['name']}.timer"],
  }

  service { "${service['name']}.timer":
    ensure => $service_ensure,
    enable => false,
    notify => Exec['systemd-daemon-reload'],
  }
}
