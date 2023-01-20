{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('all_tag_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'title',
        'author_id',
        boolean_to_string('is_system'),
        'created_at',
        'deleted_at',
        'text_color',
        'updated_at',
        'description',
        'webhook_url',
        boolean_to_string('is_assignable'),
        'on_apply_script',
        'organization_id',
        'background_color',
        array_to_string('confirmation_steps'),
    ]) }} as _airbyte_all_tag_hashid,
    tmp.*
from {{ ref('all_tag_ab2') }} tmp
-- all_tag
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

