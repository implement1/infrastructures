export
TF_WORKSPACE_KEY_PREFIX=infras-infrastructure

us-west-2-uat:
	$(eval export AWS_REGION=us-west-2)
	$(eval export AWS_DYNAMODB_TABLE=terraform-backend.lock)
	$(eval export AWS_S3_BUCKET=infras-uat-terraform-backend-us-west-2)
	$(eval export ENV_NAME=uat)
	@true

us-west-2-prod:
	$(eval export AWS_REGION=us-west-2)
	$(eval export AWS_DYNAMODB_TABLE=terraform-backend.lock)
	$(eval export AWS_S3_BUCKET=infras-prod-terraform-backend-us-west-2)
	$(eval export ENV_NAME=prod)
	@true

terraform-clean:
	rm -rf \
		terraform.tfstate.d \
		.terraform/environment \
		.terraform/terraform.tfstate

init: terraform-clean
	terraform init \
		-backend-config="bucket=${AWS_S3_BUCKET}" \
		-backend-config="workspace_key_prefix=${AWS_REGION}/${TF_WORKSPACE_KEY_PREFIX}" \
		-backend-config="dynamodb_table=${AWS_DYNAMODB_TABLE}" \
		-backend-config="region=${AWS_REGION}"
	- terraform workspace new ${ENV_NAME}
	terraform workspace select ${ENV_NAME}

show: init
	terraform show

plan: init
	terraform plan \
		-var-file=./${AWS_REGION}/${ENV_NAME}/terraform.tfvars \
		-var 'aws_region=${AWS_REGION}'

apply: init
	terraform apply \
		-var-file=./${AWS_REGION}/${ENV_NAME}/terraform.tfvars \
		-var 'aws_region=${AWS_REGION}'
