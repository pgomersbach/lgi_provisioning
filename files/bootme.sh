PROVISIONING_REPO=lgi_provisioning
REPO_PROVIDER=https://github.com/pgomersbach
OS_MAJOR=7
TERRAFORM_VERSION=0.11.7
PACKER_VERSION=1.2.3

## Code start ##
# check root
if [ "$(id -u)" != "0" ]; then
    # no roor, check sudo
    if ! timeout 2 sudo id > /dev/null; then 
        echo "This script must be run as root or sudo access." >&2
        exit 1
    fi
fi

function provision_rhel() {
    # install dependencies
    sudo yum install -y -q https://dl.fedoraproject.org/pub/epel/epel-release-latest-${RH_MAJOR}.noarch.rpm 2>/dev/null
    sudo yum update -y -q
    sudo yum install -y -q git ansible unzip make
}

# check os and release
if [ -f /etc/redhat-release ]; then
    # get release info
    source /etc/os-release
    RH_MAJOR=$(echo $VERSION_ID | cut -f1 -d.)
    RH_MINOR=$(echo $VERSION_ID | cut -f2 -d.)
    if [ $RH_MAJOR -eq $OS_MAJOR ]; then
        provision_rhel
    else
        echo “Please use RedHat 7.x, installation aborted”
        exit 1
    fi
else
    echo “Please use RedHat 7.x, installation aborted”
    exit 1
fi 

# get or update repo
if [ -d $PROVISIONING_REPO ]; then
  echo "Update repo"
  cd $PROVISIONING_REPO
  git pull
else
  echo "Cloning repo"
  git clone ${REPO_PROVIDER}/${PROVISIONING_REPO} $PROVISIONING_REPO
  cd $PROVISIONING_REPO
fi

# install terraform
curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -s -o /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo unzip -o -q /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/

# install packer
curl https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -s -o /tmp/packer_${PACKER_VERSION}_linux_amd64.zip
sudo unzip -o -q /tmp/packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin/

