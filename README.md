# terraform-infrastructure

Creates the primary infrastructure for each account. This includes the following:

1. One VPC
2. One Aurora cluster (credentials stored in secrets manager, endpoints stored in ssm parameter store)
3. One KMS key for use across applications
4. Two SNS topics (non-critical/ critical)

## Usage

To use this, first login to your SSO account and copy your export credentials to the command line:

```
export AWS_ACCESS_KEY_ID="<access_key>"
export AWS_SECRET_ACCESS_KEY="<secret_key>"
export AWS_SESSION_TOKEN="<session_token>"
```

** ALWAYS GET NEW KEYS BEFORE DEPLOYING CHANGES **
** If your token expires during deployment, there might be some clean up **

Once you have done that, you can now check your terraform changes:

```
make us-ca-central-<env> plan  # Where <env> is the env for the VPC
```

Once you believe your changes are correct, you can now deploy your changes:

```
make us-ca-central-<env> apply  # Where <env> is the env for the VPC
```

Once the above apply is finished, terraform will output details that can be used in deploying your application(s)
