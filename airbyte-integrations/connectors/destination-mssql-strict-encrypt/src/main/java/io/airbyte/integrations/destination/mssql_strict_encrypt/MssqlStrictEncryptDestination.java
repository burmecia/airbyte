/*
 * Copyright (c) 2021 Airbyte, Inc., all rights reserved.
 */

package io.airbyte.integrations.destination.mssql_strict_encrypt;

import com.fasterxml.jackson.databind.JsonNode;
import io.airbyte.integrations.BaseConnector;
import io.airbyte.integrations.base.AirbyteMessageConsumer;
import io.airbyte.integrations.base.Destination;
import io.airbyte.integrations.base.IntegrationRunner;
import io.airbyte.protocol.models.AirbyteConnectionStatus;
import io.airbyte.protocol.models.AirbyteMessage;
import io.airbyte.protocol.models.ConfiguredAirbyteCatalog;
import java.util.function.Consumer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MssqlStrictEncryptDestination extends BaseConnector implements Destination {

  private static final Logger LOGGER = LoggerFactory.getLogger(MssqlStrictEncryptDestination.class);

  public static void main(String[] args) throws Exception {
    new IntegrationRunner(new MssqlStrictEncryptDestination()).run(args);
  }

  @Override
  public AirbyteConnectionStatus check(JsonNode config) {
    // TODO
    return null;
  }

  @Override
  public AirbyteMessageConsumer getConsumer(JsonNode config,
                                            ConfiguredAirbyteCatalog configuredCatalog,
                                            Consumer<AirbyteMessage> outputRecordCollector) {
    // TODO
    return null;
  }

}
