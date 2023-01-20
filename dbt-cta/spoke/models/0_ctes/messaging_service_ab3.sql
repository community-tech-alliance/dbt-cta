{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('messaging_service_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'name',
        boolean_to_string('active'),
        boolean_to_string('is_default'),
        'updated_at',
        'account_sid',
        'service_type',
        'organization_id',
        'encrypted_auth_token',
        'messaging_service_sid',
    ]) }} as _airbyte_messaging_service_hashid,
    tmp.*
from {{ ref('messaging_service_ab2') }} tmp
-- messaging_service
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

