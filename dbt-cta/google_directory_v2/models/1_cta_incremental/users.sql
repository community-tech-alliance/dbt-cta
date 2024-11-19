{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}

-- Final base SQL model
-- depends_on: {{ ref('users_ab3') }}
select
    id,
    org,
    orgSubUnit,
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_users_hashid,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('users_ab3') }}