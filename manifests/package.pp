# @summary manage podman package presence on the system.
#
# @param ensure
#   Desired target state of the podman package. Defaults `present` if not set.
#
# @param uninstall_options
#   Optional uninstallation parameters podman package if necessary. 
#   Defaults to nothing and only in use on uninstallation.
#
class podman::package (
  Enum['present', 'absent', 'purge', 'disabled',
  'installed', 'latest'] $ensure = 'present',
  Array $uninstall_options = [],
) {
  package { 'podman':
    ensure            => $ensure,
    name              => 'podman',
    uninstall_options => $uninstall_options,
  }

  package { 'podman-plugins':
    ensure            => $ensure,
    name              => 'podman-plugins',
    uninstall_options => $uninstall_options,
  }
}
