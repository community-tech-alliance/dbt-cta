-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_ab1') }}
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
from {{ ref('users_ab1') }}
where 1 = 1