{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('nested_stream_with_complex_columns_resulting_into_long_names_ab1') }}
select
    nullif(accurateCastOrNull(trim(BOTH '"' from id), '{{ dbt_utils.type_string() }}'), 'null') as id,
    nullif(accurateCastOrNull(trim(BOTH '"' from date), '{{ dbt_utils.type_string() }}'), 'null') as date,
    accurateCastOrNull(partition, '{{ type_json() }}') as partition,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('nested_stream_with_complex_columns_resulting_into_long_names_ab1') }}
-- nested_stream_with_complex_columns_resulting_into_long_names
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

