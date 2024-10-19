# aws backup module

This module adds the following to the account:

1. vault
2. iam role for use with aws backup policy
3. region settings to enable all backup services

## Manual work

Currently, there is some manual work needed for this module to work.

### Create org backup policy

Create an org backup policy that uses the IAM role name that is found in the `locals.tf` variable `name_prefix`

### Create the vault and IAM role in the account where backups will be copied too

Next, you will need to create the backup vault and IAM role in the new account. If this is setup with Control Tower, use the audit account.

#### backup vault

Create the backup vault with the name found in the `locals.tf` variable `name_prefix`

After this is done, set the policy to allow access from the organization

#### IAM role

Create the IAM role with the two policies found in `iam_roles.tf` and name it the same name found in the `locals.tf` variable `name_prefix`

After that is complete, add the following trust permission to the IAM role:

```

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "aws:PrincipalOrgID": "<INSERT ORG ID HERE>"
        }
      }
    }
  ]
}
```
