{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('message_media_ab5') }}
select
    sid,
    uri,
    parent_sid,
    account_sid,
    content_type,
    date_created,
    date_updated,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_message_media_hashid
from {{ ref('message_media_ab5') }}
-- message_media from {{ source('cta', '_airbyte_raw_message_media') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

