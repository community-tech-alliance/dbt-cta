{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('settings_ab3') }}
select
    portal_languages,
    primary_language,
    supported_languages,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_settings_hashid
from {{ ref('settings_ab3') }}
-- settings from {{ source('freshdesk_partner_a', '_airbyte_raw_settings') }}
where 1 = 1

