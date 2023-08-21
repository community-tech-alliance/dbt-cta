{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('external_services_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'client_id',
        'created_at',
        'expires_in',
        'updated_at',
        'workflow_id',
        'access_token',
        'service_name',
        'client_secret',
        'token_updated_at',
    ]) }} as _airbyte_external_services_hashid,
    tmp.*
from {{ ref('external_services_ab2') }} as tmp
-- external_services
where 1 = 1
