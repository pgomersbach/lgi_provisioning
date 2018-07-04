PACKER := $(shell packer --version 2>/dev/null)
TERRAFORM := $(shell terraform --version 2>/dev/null)

check:
ifeq (,$(wildcard ~/.ssh/id_rsa.terraform))
	@echo "~/.ssh/id_rsa.terraform not found, please install rsa key or run 'make keys'"
	@exit 1
else
	@echo "~/.ssh/id_rsa.terraform exists"
endif
ifdef PACKER
	@echo "Found packer version $(PACKER)"
else
	@echo "Packer Not found in path"
	@exit 1
endif
ifdef TERRAFORM
	@echo "Found terraform version $(TERRAFORM)"
else
	@echo "Terraform Not found in path"
	@exit 1
endif
ifndef AWS_ACCESS_KEY_ID
	@echo "AWS_ACCESS_KEY_ID not defined"
	@exit 1
endif
ifndef AWS_SECRET_ACCESS_KEY
	@echo "AWS_SECRET_ACCESS_KEY not defined"
	@exit 1
endif
	@packer validate packer-app.json
	@packer validate packer-jump.json
	@ansible-playbook -i 'localhost,' ansible-app.yml --syntax-check
	@ansible-playbook -i 'localhost,' ansible-jump.yml --syntax-check
	@TF_VAR_access_key="${AWS_ACCESS_KEY_ID}"  TF_VAR_secret_key="${AWS_SECRET_ACCESS_KEY}" terraform validate

help:
	@more README.md
keys:
ifeq (,$(wildcard ~/.ssh/id_rsa.terraform))
	@ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa.terraform
else
	@echo "~/.ssh/id_rsa.terraform already exists"
endif

ami:
	@packer validate packer-app.json
	packer build packer-app.json

jump_ami:
	@packer validate packer-jump.json
	packer build packer-jump.json

tf_plan:
	@TF_VAR_access_key="${AWS_ACCESS_KEY_ID}"  TF_VAR_secret_key="${AWS_SECRET_ACCESS_KEY}" terraform validate
	@TF_VAR_access_key="${AWS_ACCESS_KEY_ID}"  TF_VAR_secret_key="${AWS_SECRET_ACCESS_KEY}" terraform plan

tf_apply:
	@TF_VAR_access_key="${AWS_ACCESS_KEY_ID}"  TF_VAR_secret_key="${AWS_SECRET_ACCESS_KEY}" terraform validate
	@TF_VAR_access_key="${AWS_ACCESS_KEY_ID}"  TF_VAR_secret_key="${AWS_SECRET_ACCESS_KEY}" terraform apply

tf_destroy:
	@TF_VAR_access_key="${AWS_ACCESS_KEY_ID}"  TF_VAR_secret_key="${AWS_SECRET_ACCESS_KEY}" terraform destroy

