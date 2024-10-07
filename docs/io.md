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
