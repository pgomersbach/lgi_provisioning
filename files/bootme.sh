PROVISIONING_REPO=lgi_provisoning.git
REPO_PROVIDER=https://github.com/pgomersbach
OS_MAJOR=7

## Code start ##
# check admin
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root." >&2
    exit 1
fi

function provision_rhel() {
    # install dependencies
    sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo yum update -y -q
    sudo yum install -y -q git ansible
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

# clone or update repo
git clone ${REPO_PROVIDER}/${PROVISIONING_REPO} 

# install terraform using ansible

# install packer using ansible

