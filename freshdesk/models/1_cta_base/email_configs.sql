{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_configs_ab3') }}
select
    id,
    name,
    active,
    group_id,
    to_email,
    created_at,
    product_id,
    updated_at,
    reply_email,
    primary_role,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_configs_hashid
from {{ ref('email_configs_ab3') }}
-- email_configs from {{ source('freshdesk_partner_a', '_airbyte_raw_email_configs') }}
where 1 = 1

