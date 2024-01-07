{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'age_to_bin') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    label,
    age,
   {{ dbt_utils.surrogate_key([
     'label',
    'age'
    ]) }} as _airbyte_age_to_bin_hashid
from {{ source('cta', 'age_to_bin') }}
