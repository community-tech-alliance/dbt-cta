{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('groups_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'created_at',
        'group_type',
        'updated_at',
        'description',
        'escalate_to',
        'unassigned_for',
        'business_hour_id',
        'auto_ticket_assign',
    ]) }} as _airbyte_groups_hashid,
    tmp.*
from {{ ref('groups_ab2') }} tmp
-- groups
where 1 = 1

