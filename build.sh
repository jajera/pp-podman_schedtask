dnf update -y
dnf install -y curl wget git jq gnupg hostname net-tools initscripts iputils bind-utils yum-utils sshpass make gcc openssl-devel bzip2-devel libffi-devel zlib-devel
dnf -y install https://yum.puppetlabs.com/puppet-release-el-8.noarch.rpm
dnf install -y puppet-agent
