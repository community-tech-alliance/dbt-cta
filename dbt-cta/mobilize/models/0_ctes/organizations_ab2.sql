{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to cast each column to its adequate SQL type converted from the JSON
-- schema type
-- depends_on: {{ ref("organizations_ab1") }}

select
    cast(id as int64) as id,
    cast(name as string) as name,
    cast(slug as string) as slug,
    cast(committee_id as int64) as committee_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref("organizations_ab1") }}
-- organizations
where 1 = 1
