
      insert into test_normalization.nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA ("_airbyte_partition_hashid", "currency", "_airbyte_ab_id", "_airbyte_emitted_at", "_airbyte_normalized_at", "_airbyte_DATA_hashid")
  select "_airbyte_partition_hashid", "currency", "_airbyte_ab_id", "_airbyte_emitted_at", "_airbyte_normalized_at", "_airbyte_DATA_hashid"
  from nested_stream_with_complex_columns_resulting_into_long_names_partition_DATA__dbt_tmp
  