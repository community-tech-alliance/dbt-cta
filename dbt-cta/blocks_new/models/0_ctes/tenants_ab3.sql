{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tenants_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'contact_phone',
        'logo_data',
        'created_at',
        'leaderboard_metrics',
        'logo_old',
        'contact_email',
        'updated_at',
        'shift_times',
        'name',
        'options',
        'subdomain',
        'contact_last_name',
        'id',
        'contact_first_name',
        'status'
    ]) }} as _airbyte_tenants_hashid,
    tmp.*
from {{ ref('tenants_ab2') }} tmp
-- tenants
where 1 = 1

