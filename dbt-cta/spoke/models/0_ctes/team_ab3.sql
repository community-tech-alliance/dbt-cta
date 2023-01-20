{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('team_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'title',
        'author_id',
        'created_at',
        'text_color',
        'updated_at',
        'description',
        'assignment_type',
        'organization_id',
        'background_color',
        'max_request_count',
        'assignment_priority',
        boolean_to_string('is_assignment_enabled'),
    ]) }} as _airbyte_team_hashid,
    tmp.*
from {{ ref('team_ab2') }} tmp
-- team
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

