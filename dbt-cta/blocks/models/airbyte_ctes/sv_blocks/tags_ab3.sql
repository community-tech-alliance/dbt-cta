{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tags_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'name',
        'id',
        'taggings_count',
    ]) }} as _airbyte_tags_hashid,
    tmp.*
from {{ ref('tags_ab2') }} tmp
-- tags
where 1 = 1

