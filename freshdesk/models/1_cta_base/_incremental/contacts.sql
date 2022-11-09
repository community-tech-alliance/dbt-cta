{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('contacts_ab3') }}
select
    id,
    name,
    email,
    phone,
    active,
    mobile,
    address,
    language,
    job_title,
    time_zone,
    company_id,
    created_at,
    twitter_id,
    updated_at,
    csat_rating,
    description,
    facebook_id,
    custom_fields,
    preferred_source,
    unique_external_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_contacts_hashid
from {{ ref('contacts_ab3') }}
-- contacts from {{ source('cta', '_airbyte_raw_contacts') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

