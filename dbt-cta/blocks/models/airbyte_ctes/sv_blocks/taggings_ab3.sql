{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('taggings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'context',
        'tag_id',
        'created_at',
        'tagger_type',
        'id',
        'phone_banking_question_id',
        'taggable_id',
        'tagger_id',
        'taggable_type',
    ]) }} as _airbyte_taggings_hashid,
    tmp.*
from {{ ref('taggings_ab2') }} tmp
-- taggings
where 1 = 1

