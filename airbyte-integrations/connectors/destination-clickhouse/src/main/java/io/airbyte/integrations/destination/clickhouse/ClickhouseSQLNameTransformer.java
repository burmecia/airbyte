/*
 * Copyright (c) 2021 Airbyte, Inc., all rights reserved.
 */

package io.airbyte.integrations.destination.clickhouse;

import io.airbyte.integrations.destination.ExtendedNameTransformer;

public class ClickhouseSQLNameTransformer extends ExtendedNameTransformer {

  // These constants must match those in destination_name_transformer.py
  public static final int MAX_CLICKHOUSE_NAME_LENGTH = 128;
  // DBT appends a suffix to table names
  public static final int TRUNCATE_DBT_RESERVED_SIZE = 12;
  // 4 characters for 1 underscore and 3 suffix (e.g. _ab1)
  // 4 characters for 1 underscore and 3 schema hash
  public static final int TRUNCATE_RESERVED_SIZE = 8;
  public static final int TRUNCATION_MAX_NAME_LENGTH = MAX_CLICKHOUSE_NAME_LENGTH - TRUNCATE_DBT_RESERVED_SIZE - TRUNCATE_RESERVED_SIZE;

  @Override
  public String getIdentifier(final String name) {
    // Table columns (identifiers) are truncated but not changed to lower case. 
    // Airbyte does not use lower case table names as a standard
    String identifier = super.getIdentifier(name);
    return truncateName(identifier, TRUNCATION_MAX_NAME_LENGTH);
  }

  @Override
  public String getTmpTableName(final String streamName) {
    // Table names are truncated and the character case is normalized
    final String tmpTableName = applyDefaultTableCase(super.getTmpTableName(streamName));
    return truncateName(tmpTableName, TRUNCATION_MAX_NAME_LENGTH);
  }

  @Override
  public String getRawTableName(final String streamName) {
    // Table names are truncated and the character case is normalized
    final String rawTableName = applyDefaultTableCase(super.getRawTableName(streamName));
    return truncateName(rawTableName, TRUNCATION_MAX_NAME_LENGTH);
  }

  static String truncateName(final String name, final int maxLength) {
    if (name.length() <= maxLength) {
      return name;
    }

    final int allowedLength = maxLength - 2;
    final String prefix = name.substring(0, allowedLength / 2);
    final String suffix = name.substring(name.length() - allowedLength / 2);
    return prefix + "__" + suffix;
  }

  protected String applyDefaultTableCase(final String input) {
    return input.toLowerCase();
  }
}
