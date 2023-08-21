{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('taggable_logbook_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'notes',
        'tag_id',
        boolean_to_string('available'),
        'created_at',
        'created_by',
        'deleted_at',
        'deleted_by',
        'updated_at',
        'campaign_id',
        'interact_id',
        'taggable_id',
        'signature_id',
        'taggable_type',
        'updated_by_id',
    ]) }} as _airbyte_taggable_logbook_hashid,
    tmp.*
from {{ ref('taggable_logbook_ab2') }} as tmp
-- taggable_logbook
where 1 = 1
