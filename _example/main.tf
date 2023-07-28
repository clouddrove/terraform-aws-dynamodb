##---------------------------------------------------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
##--------------------------------------------------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

##---------------------------------------------------------------------------------------------------------------------------
## Amazon DynamoDB is a fully managed, serverless, key-value NoSQL database designed to run high-performance applications at any scale.
##--------------------------------------------------------------------------------------------------------------------------
module "dynamodb" {
  source = "../"

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

  # autoscaler
  enable_autoscaler = true
  dynamodb_indexes  = ["DailyAverageIndex"]

  # enable replica and streams
  enable_streams   = true
  stream_view_type = "KEYS_ONLY"
}