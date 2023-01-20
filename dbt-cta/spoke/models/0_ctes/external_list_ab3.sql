{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('external_list_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'name',
        'system_id',
        'created_at',
        'door_count',
        'list_count',
        'updated_at',
        'description',
        'external_id',
    ]) }} as _airbyte_external_list_hashid,
    tmp.*
from {{ ref('external_list_ab2') }} tmp
-- external_list
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

