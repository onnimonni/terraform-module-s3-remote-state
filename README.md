# Terraform S3 Remote State with Dynamodb locking module

This module can be used to create terraform s3 remote state with dynamodb locking.

## How to use

You can create the needed s3 bucket and dynamodb by running this one liner:
```
$ terraform apply github.com/onnimonni/terraform-module-s3-remote-state -auto-approve -var 'state_name=terraform-example-remote-state'
...
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:


aws_region = eu-west-1
dynamodb_table = terraform_example_remote_state
s3_bucket = terraform-example-remote-state
```

You need to select a state_name variable so that the required dynamodb table and s3 bucket will be available.
This module will automatically convert `'_' => '-'` for s3 bucket  and `'-' => '_'` for dynamodb_table.

After you have created you s3 bucket and dynamodb table you need to start using them in your terraform project like this:
```hcl
terraform {
	backend “s3” {
	 	encrypt = true
	 	bucket = "terraform-example-remote-state"
	 	dynamodb_table = "terraform_example_remote_state"
	 	region = eu-west-1
	 	key = your-project-name-here/terraform/state
 	}
}
```

## Author
[Onni Hakala](https://github.com/onnimonni)

## License
MIT