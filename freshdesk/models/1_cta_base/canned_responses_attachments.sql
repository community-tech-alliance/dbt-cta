{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('canned_responses_attachments_ab3') }}
select
    _airbyte_canned_responses_hashid,
    id,
    name,
    size,
    thumb_url,
    created_at,
    updated_at,
    content_type,
    attachment_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_attachments_hashid
from {{ ref('canned_responses_attachments_ab3') }}
-- attachments at canned_responses/attachments from {{ ref('canned_responses') }}
where 1 = 1

