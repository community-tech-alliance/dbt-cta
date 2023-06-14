{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tag_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        boolean_to_string('is_deleted'),
        'updated_at',
        'organization_id',
        'name',
        'created_at',
        'description',
        'id',
        adapter.quote('group'),
    ]) }} as _airbyte_tag_hashid,
    tmp.*
from {{ ref('tag_ab2') }} tmp
-- tag
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

