{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('core_fields_ocdids_ab3') }}
select
    id,
    ocdid_id,
    core_field_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_core_fields_ocdids_hashid
from {{ ref('core_fields_ocdids_ab3') }}
-- core_fields_ocdids from {{ source('cta', '_airbyte_raw_core_fields_ocdids') }}
where 1 = 1

