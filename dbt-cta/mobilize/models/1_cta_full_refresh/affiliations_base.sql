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
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('affiliations_ab4') }}
-- 
select
    id,
    source,
    user_id,
    blocked_date,
    created_date,
    deleted_date,
    user__region,
    modified_date,
    user__locality,
    organization_id,
    user__given_name,
    user__family_name,
    user__postal_code,
    user__phone_number,
    user__email_address,
    user__modified_date,
    committed_to_host_date,
    host_commitment_source,
    user__globally_blocked_date,
    declined_to_commit_to_host_date,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_affiliations_hashid,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('affiliations_ab4') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
