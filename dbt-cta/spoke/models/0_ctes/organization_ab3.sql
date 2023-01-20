{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('organization_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'uuid',
        'features',
        'created_at',
        'deleted_at',
        'deleted_by',
        'updated_at',
        'autosending_mps',
        'texting_hours_end',
        'default_texting_tz',
        'texting_hours_start',
        'monthly_message_limit',
        boolean_to_string('texting_hours_enforced'),
    ]) }} as _airbyte_organization_hashid,
    tmp.*
from {{ ref('organization_ab2') }} tmp
-- organization
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

