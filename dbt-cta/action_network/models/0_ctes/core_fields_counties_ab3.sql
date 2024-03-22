{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('core_fields_counties_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'county_id',
        'core_field_id',
    ]) }} as _airbyte_core_fields_counties_hashid,
    tmp.*
from {{ ref('core_fields_counties_ab2') }} as tmp
-- core_fields_counties
where 1 = 1
