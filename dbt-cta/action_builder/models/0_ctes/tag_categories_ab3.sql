{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tag_categories_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'name',
        'type',
        boolean_to_string('locked'),
        'target_id',
        'created_at',
        'created_by',
        'updated_at',
        'target_type',
        'tag_group_id',
        boolean_to_string('multiselectable'),
        boolean_to_string('read_only_category'),
        boolean_to_string('attachments_enabled'),
        'allow_create_tag_type',
        'multiselect_same_tag_behavior',
    ]) }} as _airbyte_tag_categories_hashid,
    tmp.*
from {{ ref('tag_categories_ab2') }} as tmp
-- tag_categories
where 1 = 1
