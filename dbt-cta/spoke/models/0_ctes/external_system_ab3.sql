{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('external_system_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'type',
        'username',
        'synced_at',
        'created_at',
        'updated_at',
        'api_key_ref',
        'organization_id',
    ]) }} as _airbyte_external_system_hashid,
    tmp.*
from {{ ref('external_system_ab2') }} tmp
-- external_system
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

