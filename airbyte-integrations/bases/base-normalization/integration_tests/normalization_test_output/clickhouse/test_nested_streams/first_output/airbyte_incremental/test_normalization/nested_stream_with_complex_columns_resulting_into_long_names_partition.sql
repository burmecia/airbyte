
      

  
    create table test_normalization.nested_stream_with_complex_columns_resulting_into_long_names_partition
    
  
    
    engine = MergeTree()
    
    order by (tuple())
    
  as (
    
with __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: test_normalization.nested_stream_with_complex_columns_resulting_into_long_names_scd
select
    _airbyte_nested_stream_with_complex_columns_resulting_into_long_names_hashid,
    JSONExtractArrayRaw(assumeNotNull(partition), 'double_array_data') as double_array_data,
    JSONExtractArrayRaw(assumeNotNull(partition), 'DATA') as DATA,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from test_normalization.nested_stream_with_complex_columns_resulting_into_long_names_scd as table_alias
-- partition at nested_stream_with_complex_columns_resulting_into_long_names/partition
where 1 = 1
and partition is not null

),  __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_ab1
select
    _airbyte_nested_stream_with_complex_columns_resulting_into_long_names_hashid,
    double_array_data,
    DATA,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_ab1
-- partition at nested_stream_with_complex_columns_resulting_into_long_names/partition
where 1 = 1

),  __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_ab2
select
    assumeNotNull(hex(MD5(
            
                toString(_airbyte_nested_stream_with_complex_columns_resulting_into_long_names_hashid) || '~' ||
            
            
                toString(arrayStringConcat(double_array_data)) || '~' ||
            
            
                toString(arrayStringConcat(DATA))
            
    ))) as _airbyte_partition_hashid,
    tmp.*
from __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_ab2 tmp
-- partition at nested_stream_with_complex_columns_resulting_into_long_names/partition
where 1 = 1

)-- Final base SQL model
-- depends_on: __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_ab3
select
    _airbyte_nested_stream_with_complex_columns_resulting_into_long_names_hashid,
    double_array_data,
    DATA,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_partition_hashid
from __dbt__cte__nested_stream_with_complex_columns_resulting_into_long_names_partition_ab3
-- partition at nested_stream_with_complex_columns_resulting_into_long_names/partition from test_normalization.nested_stream_with_complex_columns_resulting_into_long_names_scd
where 1 = 1

  )
  