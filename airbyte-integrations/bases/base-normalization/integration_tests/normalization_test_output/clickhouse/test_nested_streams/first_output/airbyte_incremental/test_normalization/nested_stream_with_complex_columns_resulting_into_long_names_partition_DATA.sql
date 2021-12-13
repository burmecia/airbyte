
      

  
    create table test_normalization.nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA
    
  
    
    engine = MergeTree()
    
    order by (tuple())
    
  as (
    
with __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: test_normalization.nested_stream_with_complex_columns_resulting_into_long_names_partition

select
    _airbyte_partition_hashid,
    JSONExtractRaw(DATA, 'currency') as currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from test_normalization.nested_stream_with_complex_columns_resulting_into_long_names_partition as table_alias
-- DATA at nested_stream_with_complex_columns_resulting_into_long_names/partition/DATA
array join DATA
where 1 = 1
and DATA is not null

),  __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA_ab1
select
    _airbyte_partition_hashid,
    nullif(accurateCastOrNull(trim(BOTH '"' from currency), 'String'), 'null') as currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA_ab1
-- DATA at nested_stream_with_complex_columns_resulting_into_long_names/partition/DATA
where 1 = 1

),  __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA_ab2
select
    assumeNotNull(hex(MD5(
            
                toString(_airbyte_partition_hashid) || '~' ||
            
            
                toString(currency)
            
    ))) as _airbyte_DATA_hashid,
    tmp.*
from __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA_ab2 tmp
-- DATA at nested_stream_with_complex_columns_resulting_into_long_names/partition/DATA
where 1 = 1

)-- Final base SQL model
-- depends_on: __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA_ab3
select
    _airbyte_partition_hashid,
    currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_DATA_hashid
from __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA_ab3
-- DATA at nested_stream_with_complex_columns_resulting_into_long_names/partition/DATA from test_normalization.nested_stream_with_complex_columns_resulting_into_long_names_partition
where 1 = 1

  )
  