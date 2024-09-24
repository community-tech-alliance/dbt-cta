{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('zip_code_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'zip',
        'city',
        'latitude',
        'timezone_offset',
        'state',
        boolean_to_string('has_dst'),
        'longitude',
    ]) }} as _airbyte_zip_code_hashid,
    tmp.*
from {{ ref('zip_code_ab2') }} as tmp
-- zip_code
where 1 = 1
