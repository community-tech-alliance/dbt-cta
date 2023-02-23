{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('conferences_ab3') }}
select
    sid,
    uri,
    region,
    status,
    account_sid,
    api_version,
    date_created,
    date_updated,
    friendly_name,
    subresource_uris,
    reason_conference_ended,
    call_sid_ending_conference,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_conferences_hashid
from {{ ref('conferences_ab3') }}
-- conferences from {{ source('cta', '_airbyte_raw_conferences') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

