{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('organizations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'settings',
        'subdomain',
        'created_at',
        'updated_at',
        boolean_to_string('api_enabled'),
        'country_code',
        'default_country',
        'administrator_user_id',
    ]) }} as _airbyte_organizations_hashid,
    tmp.*
from {{ ref('organizations_ab2') }} tmp
-- organizations
where 1 = 1

