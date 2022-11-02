{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('agents_contact_ab3') }}
select
    _airbyte_agents_hashid,
    name,
    email,
    phone,
    active,
    mobile,
    language,
    job_title,
    time_zone,
    created_at,
    updated_at,
    last_login_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_contact_hashid
from {{ ref('agents_contact_ab3') }}
-- contact at agents/contact from {{ ref('agents') }}
where 1 = 1

