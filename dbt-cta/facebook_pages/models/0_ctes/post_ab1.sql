{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta','post') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'created_time',
        'name',
        'id',
        'message',
        'permalink_url',
    ]) }} as _airbyte_post_hashid,
    tmp.*
from {{ source('cta','post') }} as tmp
-- post
where 1 = 1
