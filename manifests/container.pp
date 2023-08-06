# @summary manage podman container presence on the system.
#
# @param names
#   Desired podman container configurations to be created or removed.
#
class podman::container (
  Hash $names = {},
) {
  include podman::package

  $names.each |$name, $prop| {
    case $prop['ensure'] {
      'present': {
        exec { $name:
          command => "/usr/bin/podman container create --name  ${prop['name']} ${prop['image']}",
          unless  => "/usr/bin/podman container exists ${prop['name']}",
        }
      }
      'absent': {
        exec { $name:
          command => "/usr/bin/podman rm -f ${prop['name']}",
          onlyif  => "/usr/bin/podman container exists ${prop['name']}",
        }
      }
      default: {
        fail('"ensure" must be "present" or "absent"')
      }
    }
  }
}
