{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_quality_control_flags_views_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('quality_control_flags_views_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('quality_control_flags_views_ab2') }}
