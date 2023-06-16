{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('phone_banking_scripts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'updated_at',
        'organization_id',
        'extras',
        'created_at',
        'id',
        'cause_statement',
        'created_by_user_id',
    ]) }} as _airbyte_phone_banking_scripts_hashid,
    tmp.*
from {{ ref('phone_banking_scripts_ab2') }} tmp
-- phone_banking_scripts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

