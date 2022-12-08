{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ad_account_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'owner',
        'tax_id',
        'partner',
        'account_id'
    ]) }} as _airbyte_ad_account_hashid,
    tmp.*
from {{ ref('ad_account_ab2') }} tmp
-- ad_account
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

