{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('canvassers_ab3') }}
select
    notes,
    address,
    county,
    extras,
    last_name,
    created_at,
    created_by_user_id,
    archived,
    updated_at,
    turf_id,
    organization_id,
    vdrs,
    phone_number,
    id,
    first_name,
    slug,
    email,
    person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_canvassers_hashid
from {{ ref('canvassers_ab3') }}
-- canvassers from {{ source('sv_blocks', '_airbyte_raw_canvassers') }}

