{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('quality_control_phone_verification_scripts_ab3') }}
select
    turf_id,
    language,
    id,
    structure,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_quality_control_phone_verification_scripts_hashid
from {{ ref('quality_control_phone_verification_scripts_ab3') }}
-- quality_control_phone_verification_scripts from {{ source('cta', '_airbyte_raw_quality_control_phone_verification_scripts') }}

