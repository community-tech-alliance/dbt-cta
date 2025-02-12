{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_users" %}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['primaryEmail']") as primaryEmail,

    json_extract_scalar(_airbyte_data, "$['recoveryEmail']") as recoveryEmail,
    json_extract_scalar(_airbyte_data, "$['kind']") as kind,
    json_extract(table_alias._airbyte_data, "$['name']")
        as name,
    json_extract_array(_airbyte_data, "$['emails']") as emails,
    json_extract_array(_airbyte_data, "$['phones']") as phones,
    array(
        select coalesce(x, "NULL")
        from unnest(json_value_array(_airbyte_data, '$."aliases"')) as x
    ) as aliases,
    json_extract_scalar(_airbyte_data, "$['isAdmin']") as isAdmin,
    json_extract_scalar(_airbyte_data, "$['username']") as username,
    json_extract_array(_airbyte_data, "$['relations']") as relations,
    json_extract_scalar(_airbyte_data, "$['suspended']") as suspended,
    json_extract_scalar(_airbyte_data, "$['customerId']") as customerId,
    json_extract_array(_airbyte_data, "$['externalIds']") as externalIds,
    json_extract_scalar(_airbyte_data, "$['orgUnitPath']") as orgUnitPath,
    json_extract_scalar(_airbyte_data, "$['creationTime']") as creationTime,
    json_extract_scalar(_airbyte_data, "$['hashFunction']") as hashFunction,
    json_extract_scalar(_airbyte_data, "$['agreedToTerms']") as agreedToTerms,
    json_extract_scalar(_airbyte_data, "$['ipWhitelisted']") as ipWhitelisted,
    json_extract_scalar(_airbyte_data, "$['lastLoginTime']") as lastLoginTime,
    json_extract_scalar(_airbyte_data, "$['isMailboxSetup']") as isMailboxSetup,
    json_extract_scalar(_airbyte_data, "$['isDelegatedAdmin']") as isDelegatedAdmin,
    array(
        select coalesce(x, "NULL")
        from unnest(json_value_array(_airbyte_data, '$."nonEditableAliases"')) as x
    ) as nonEditableAliases,
    json_extract_scalar(_airbyte_data, "$['changePasswordAtNextLogin']") as changePasswordAtNextLogin,
    json_extract_scalar(_airbyte_data, "$['includeInGlobalAddressList']") as includeInGlobalAddressList,
    current_timestamp() as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
where 1 = 1
