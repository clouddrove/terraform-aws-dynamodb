<!-- This file was automatically generated by the `geine`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform AWS DynamoDB
</h1>

<p align="center" style="font-size: 1.2rem;"> 
    Terraform module to create dynamodb resource on AWS.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/Terraform-v1.1.7-green" alt="Terraform">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-APACHE-blue.svg" alt="Licence">
</a>
<a href="https://github.com/clouddrove/terraform-aws-dynamodb/actions/workflows/tfsec.yml">
  <img src="https://github.com/clouddrove/terraform-aws-dynamodb/actions/workflows/tfsec.yml/badge.svg" alt="tfsec">
</a>
<a href="https://github.com/clouddrove/terraform-aws-dynamodb/actions/workflows/terraform.yml">
  <img src="https://github.com/clouddrove/terraform-aws-dynamodb/actions/workflows/terraform.yml/badge.svg" alt="static-checks">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/clouddrove/terraform-aws-dynamodb'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AWS+DynamoDB&url=https://github.com/clouddrove/terraform-aws-dynamodb'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+AWS+DynamoDB&url=https://github.com/clouddrove/terraform-aws-dynamodb'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>


We eat, drink, sleep and most importantly love **DevOps**. We are working towards strategies for standardizing architecture while ensuring security for the infrastructure. We are strong believer of the philosophy <b>Bigger problems are always solved by breaking them into smaller manageable problems</b>. Resonating with microservices architecture, it is considered best-practice to run database, cluster, storage in smaller <b>connected yet manageable pieces</b> within the infrastructure. 

This module is basically combination of [Terraform open source](https://www.terraform.io/) and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.

We have [*fifty plus terraform modules*][terraform_modules]. A few of them are comepleted and are available for open source usage while a few others are in progress.




## Prerequisites

This module has a few dependencies: 

- [Terraform 1.x.x](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)
- [github.com/stretchr/testify/assert](https://github.com/stretchr/testify)
- [github.com/gruntwork-io/terratest/modules/terraform](https://github.com/gruntwork-io/terratest)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/clouddrove/terraform-aws-dynamodb/releases).


### Simple Example
Here is an example of how you can use this module in your inventory structure:
  ```hcl
module "dynamodb" {
source      = "clouddrove/terraform-aws-dynamodb/aws"
version     = "1.0.1"
name        = "dynamodb"
environment = "test"
label_order = ["environment", "name"]
hash_key    = "HashKey"
range_key   = "RangeKey"

dynamodb_attributes = [
{
  name = "DailyAverage"
  type = "N"
},
{
  name = "HighWater"
  type = "N"
},
{
  name = "Timestamp"
  type = "S"
}
]

local_secondary_index_map = [
{
  name               = "TimestampSortIndex"
  range_key          = "Timestamp"
  projection_type    = "INCLUDE"
  non_key_attributes = ["HashKey", "RangeKey"]
},
{
  name               = "HighWaterIndex"
  range_key          = "Timestamp"
  projection_type    = "INCLUDE"
  non_key_attributes = ["HashKey", "RangeKey"]
}
]

global_secondary_index_map = [
{
  name               = "DailyAverageIndex"
  hash_key           = "DailyAverage"
  range_key          = "HighWater"
  write_capacity     = 5
  read_capacity      = 5
  projection_type    = "INCLUDE"
  non_key_attributes = ["HashKey", "RangeKey"]
}
]

#autoscaler
enable_autoscaler = true
dynamodb_indexes  = ["DailyAverageIndex"]

#enable replica and streams
enable_streams   = true
stream_view_type = "KEYS_ONLY"
}

  ```






## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| autoscale\_max\_read\_capacity | DynamoDB autoscaling max read capacity | `number` | `20` | no |
| autoscale\_max\_write\_capacity | DynamoDB autoscaling max write capacity | `number` | `20` | no |
| autoscale\_min\_read\_capacity | DynamoDB autoscaling min read capacity | `number` | `5` | no |
| autoscale\_min\_write\_capacity | DynamoDB autoscaling min write capacity | `number` | `5` | no |
| autoscale\_read\_target | The target value (in %) for DynamoDB read autoscaling | `number` | `50` | no |
| autoscale\_write\_target | The target value (in %) for DynamoDB write autoscaling | `number` | `50` | no |
| autoscaler\_attributes | Additional attributes for the autoscaler module | `list(string)` | `[]` | no |
| autoscaler\_tags | Additional resource tags for the autoscaler module | `map(string)` | `{}` | no |
| billing\_mode | DynamoDB Billing mode. Can be PROVISIONED or PAY\_PER\_REQUEST | `string` | `"PROVISIONED"` | no |
| dynamodb\_attributes | Additional DynamoDB attributes in the form of a list of mapped values | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | `[]` | no |
| dynamodb\_indexes | List of DynamoDB indexes | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| enable\_autoscaler | Flag to enable/disable DynamoDB autoscaling | `bool` | `false` | no |
| enable\_encryption | Enable DynamoDB server-side encryption | `bool` | `true` | no |
| enable\_point\_in\_time\_recovery | Enable DynamoDB point in time recovery | `bool` | `true` | no |
| enable\_streams | Enable DynamoDB streams | `bool` | `false` | no |
| enabled | This is bool option for enable or disabled | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| global\_secondary\_index\_map | Additional global secondary indexes in the form of a list of mapped values | <pre>list(object({<br>    hash_key           = string<br>    name               = string<br>    non_key_attributes = list(string)<br>    projection_type    = string<br>    range_key          = string<br>    read_capacity      = number<br>    write_capacity     = number<br>  }))</pre> | `[]` | no |
| hash\_key | DynamoDB table Hash Key | `string` | n/a | yes |
| hash\_key\_type | Hash Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data | `string` | `"S"` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| local\_secondary\_index\_map | Additional local secondary indexes in the form of a list of mapped values | <pre>list(object({<br>    name               = string<br>    non_key_attributes = list(string)<br>    projection_type    = string<br>    range_key          = string<br>  }))</pre> | `[]` | no |
| managedby | ManagedBy, eg 'CloudDrove' | `string` | `"hello@clouddrove.com"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| range\_key | DynamoDB table Range Key | `string` | `""` | no |
| range\_key\_type | Range Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data | `string` | `"S"` | no |
| replicas | List of regions to create replica | `list(string)` | `[]` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-dynamodb"` | no |
| server\_side\_encryption\_kms\_key\_arn | The ARN of the CMK that should be used for the AWS KMS encryption. This attribute should only be specified if the key is different from the default DynamoDB CMK, alias/aws/dynamodb. | `string` | `null` | no |
| stream\_view\_type | When an item in the table is modified, what information is written to the stream. Valid values are KEYS\_ONLY, NEW\_IMAGE, OLD\_IMAGE, NEW\_AND\_OLD\_IMAGES. | `string` | `""` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(any)` | `{}` | no |
| ttl\_attribute | DynamoDB table TTL attribute | `string` | `"Expires"` | no |
| ttl\_enabled | Set to false to disable DynamoDB table TTL | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| global\_secondary\_index\_names | DynamoDB secondary index names |
| local\_secondary\_index\_names | DynamoDB local index names |
| table\_arn | DynamoDB table ARN |
| table\_id | DynamoDB table ID |
| table\_name | DynamoDB table name |
| table\_stream\_arn | DynamoDB table stream ARN |
| table\_stream\_label | DynamoDB table stream label |
| tags | A mapping of tags to assign to the resource. |




## Testing
In this module testing is performed with [terratest](https://github.com/gruntwork-io/terratest) and it creates a small piece of infrastructure, matches the output like ARN, ID and Tags name etc and destroy infrastructure in your AWS account. This testing is written in GO, so you need a [GO environment](https://golang.org/doc/install) in your system. 

You need to run the following command in the testing folder:
```hcl
  go test -run Test
```



## Feedback 
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/clouddrove/terraform-aws-dynamodb/issues), or feel free to drop us an email at [hello@clouddrove.com](mailto:hello@clouddrove.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/clouddrove/terraform-aws-dynamodb)!

## About us

At [CloudDrove][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/clouddrove">Open Source</a> and you can check out <a href="https://github.com/clouddrove">our other modules</a> to get help with your new Cloud ideas.</p>

  [website]: https://clouddrove.com
  [github]: https://github.com/clouddrove
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://twitter.com/clouddrove/
  [email]: https://clouddrove.com/contact-us.html
  [terraform_modules]: https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=
