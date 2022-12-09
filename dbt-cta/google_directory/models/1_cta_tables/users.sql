-- Final base SQL model
-- depends_on: {{ ref('users_ab3') }}
select
    id,
    orgUnitPath,
    primaryEmail,
    recoveryEmail,
    kind,
    name,
    emails,
    phones,
    aliases,
    isAdmin,
    username,
    relations,
    suspended,
    customerId,
    externalIds,
    orgUnitPath,
    creationTime,
    hashFunction,
    agreedToTerms,
    ipWhitelisted,
    lastLoginTime,
    isMailboxSetup,
    isDelegatedAdmin,
    nonEditableAliases,
    changePasswordAtNextLogin,
    includeInGlobalAddressList,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_users_hashid
from {{ ref('users_ab3') }}
where 1 = 1
and cast(_airbyte_emitted_at as timestamp) >= cast('2022-12-02 10:00:40+00:00' as timestamp)
