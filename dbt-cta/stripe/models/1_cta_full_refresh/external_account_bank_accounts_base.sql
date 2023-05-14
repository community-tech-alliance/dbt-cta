{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('external_account_bank_accounts_ab3') }}
select
    id,
    last4,
    object,
    status,
    account,
    country,
    currency,
    metadata,
    bank_name,
    fingerprint,
    account_type,
    routing_number,
    account_holder_name,
    account_holder_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_external_account_bank_accounts_hashid
from {{ ref('external_account_bank_accounts_ab3') }}
-- external_account_bank_accounts from {{ source('cta', '_airbyte_raw_external_account_bank_accounts') }}
where 1 = 1

