{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_cover_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_page_hashid',
        'id',
        'source',
        'cover_id',
        'offset_x',
        'offset_y',
    ]) }} as _airbyte_cover_hashid,
    tmp.*
from {{ ref('page_cover_ab2') }} tmp
-- cover at page/cover
where 1 = 1

