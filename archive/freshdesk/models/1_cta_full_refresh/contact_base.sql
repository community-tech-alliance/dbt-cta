{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    partitions = partitions_to_replace
) }}
-- Final base SQL model
-- depends_on: {{ ref('contact_ab2') }}
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
from {{ ref('contact_ab2') }}
-- contacts from {{ source('cta', '_airbyte_raw_contacts') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


