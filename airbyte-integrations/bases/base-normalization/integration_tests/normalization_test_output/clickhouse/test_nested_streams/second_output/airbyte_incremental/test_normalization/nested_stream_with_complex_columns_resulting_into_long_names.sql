
      insert into test_normalization.nested_stream_with_complex_columns_resulting_into_long_names ("_airbyte_unique_key", "id", "date", "partition", "_airbyte_ab_id", "_airbyte_emitted_at", "_airbyte_normalized_at", "_airbyte_nested_stream_with_complex_columns_resulting_into_long_names_hashid")
  select "_airbyte_unique_key", "id", "date", "partition", "_airbyte_ab_id", "_airbyte_emitted_at", "_airbyte_normalized_at", "_airbyte_nested_stream_with_complex_columns_resulting_into_long_names_hashid"
  from nested_stream_with_complex_columns_resulting_into_long_names__dbt_tmp
  