{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('canned_responses_ab3') }}
select
    id,
    title,
    content,
    folder_id,
    created_at,
    updated_at,
    attachments,
    content_html,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_canned_responses_hashid
from {{ ref('canned_responses_ab3') }}
-- canned_responses from {{ source('freshdesk_partner_a', '_airbyte_raw_canned_responses') }}
where 1 = 1

