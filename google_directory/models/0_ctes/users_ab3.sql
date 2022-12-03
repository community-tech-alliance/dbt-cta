
with __dbt__cte__users_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users._airbyte_raw_users
select
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['kind']") as kind,
    
        json_extract(table_alias._airbyte_data, "$['name']")
     as name,
    json_extract_array(_airbyte_data, "$['emails']") as emails,
    json_extract_array(_airbyte_data, "$['phones']") as phones,
    array(
        select ifnull(x, "NULL")
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
    json_extract_array(_airbyte_data, "$['organizations']") as organizations,
    json_extract_scalar(_airbyte_data, "$['isMailboxSetup']") as isMailboxSetup,
    json_extract_scalar(_airbyte_data, "$['isDelegatedAdmin']") as isDelegatedAdmin,
    array(
        select ifnull(x, "NULL")
        from unnest(json_value_array(_airbyte_data, '$."nonEditableAliases"')) as x
    ) as nonEditableAliases,
    json_extract_scalar(_airbyte_data, "$['changePasswordAtNextLogin']") as changePasswordAtNextLogin,
    json_extract_scalar(_airbyte_data, "$['includeInGlobalAddressList']") as includeInGlobalAddressList,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users._airbyte_raw_users as table_alias
-- users
where 1 = 1

),  __dbt__cte__users_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__users_ab1
select
    cast(id as 
    string
) as id,
    cast(kind as 
    string
) as kind,
    cast(name as 
    string
) as name,
    emails,
    phones,
    aliases,
    cast(isAdmin as boolean) as isAdmin,
    cast(username as 
    string
) as username,
    relations,
    cast(suspended as boolean) as suspended,
    cast(customerId as 
    string
) as customerId,
    externalIds,
    cast(orgUnitPath as 
    string
) as orgUnitPath,
    cast(creationTime as 
    string
) as creationTime,
    cast(hashFunction as 
    string
) as hashFunction,
    cast(agreedToTerms as boolean) as agreedToTerms,
    cast(ipWhitelisted as boolean) as ipWhitelisted,
    cast(lastLoginTime as 
    string
) as lastLoginTime,
    organizations,
    cast(isMailboxSetup as boolean) as isMailboxSetup,
    cast(isDelegatedAdmin as boolean) as isDelegatedAdmin,
    nonEditableAliases,
    cast(changePasswordAtNextLogin as boolean) as changePasswordAtNextLogin,
    cast(includeInGlobalAddressList as boolean) as includeInGlobalAddressList,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from __dbt__cte__users_ab1
-- users
where 1 = 1

)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__users_ab2
select
    to_hex(md5(cast(concat(coalesce(cast(id as 
    string
), ''), '-', coalesce(cast(kind as 
    string
), ''), '-', coalesce(cast(name as 
    string
), ''), '-', coalesce(cast(array_to_string(emails, "|", "") as 
    string
), ''), '-', coalesce(cast(array_to_string(phones, "|", "") as 
    string
), ''), '-', coalesce(cast(array_to_string(aliases, "|", "") as 
    string
), ''), '-', coalesce(cast(isAdmin as 
    string
), ''), '-', coalesce(cast(username as 
    string
), ''), '-', coalesce(cast(array_to_string(relations, "|", "") as 
    string
), ''), '-', coalesce(cast(suspended as 
    string
), ''), '-', coalesce(cast(customerId as 
    string
), ''), '-', coalesce(cast(array_to_string(externalIds, "|", "") as 
    string
), ''), '-', coalesce(cast(orgUnitPath as 
    string
), ''), '-', coalesce(cast(creationTime as 
    string
), ''), '-', coalesce(cast(hashFunction as 
    string
), ''), '-', coalesce(cast(agreedToTerms as 
    string
), ''), '-', coalesce(cast(ipWhitelisted as 
    string
), ''), '-', coalesce(cast(lastLoginTime as 
    string
), ''), '-', coalesce(cast(array_to_string(organizations, "|", "") as 
    string
), ''), '-', coalesce(cast(isMailboxSetup as 
    string
), ''), '-', coalesce(cast(isDelegatedAdmin as 
    string
), ''), '-', coalesce(cast(array_to_string(nonEditableAliases, "|", "") as 
    string
), ''), '-', coalesce(cast(changePasswordAtNextLogin as 
    string
), ''), '-', coalesce(cast(includeInGlobalAddressList as 
    string
), '')) as 
    string
))) as _airbyte_users_hashid,
    tmp.*
from __dbt__cte__users_ab2 tmp
-- users
where 1 = 1
