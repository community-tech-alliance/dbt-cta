{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
) }}
-- Final base SQL model
-- depends_on: {{ ref('contacts_ab2') }}
select
    id,
    company_id,
    active,
    address,
    description,
    email,
    job_title,
    language,
    mobile,
    name,
    phone,
    time_zone,
    twitter_id,
    SAFE_CAST(created_at as timestamp) as created_at,
    SAFE_CAST(updated_at as timestamp) as updated_at,
    csat_rating,
    facebook_id,
    JSON_EXTRACT_SCALAR(custom_fields, '$.affiliate_organization') as custom_affiliate_organization,
    preferred_source,
    unique_external_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
from {{ ref('contacts_ab2') }}
-- contacts from {{ source('cta', '_airbyte_raw_contacts') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

