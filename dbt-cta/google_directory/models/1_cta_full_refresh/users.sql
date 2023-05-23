{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_users_hashid
from {{ ref('users_ab3') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}