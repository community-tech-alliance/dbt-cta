{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('companies_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'note',
        array_to_string('domains'),
        'industry',
        'created_at',
        'updated_at',
        'description',
        'account_tier',
        'health_score',
        'renewal_date',
        object_to_string('custom_fields'),
    ]) }} as _airbyte_companies_hashid,
    tmp.*
from {{ ref('companies_ab2') }} tmp
-- companies
where 1 = 1

