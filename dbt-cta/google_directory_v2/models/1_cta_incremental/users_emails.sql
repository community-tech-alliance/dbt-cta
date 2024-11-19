{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_emails_ab3') }}, {{ ref('users') }}
select
    _airbyte_users_hashid,
    type,
    address,
    primary,
    customType,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_emails_hashid
from {{ ref('users_emails_ab3') }}