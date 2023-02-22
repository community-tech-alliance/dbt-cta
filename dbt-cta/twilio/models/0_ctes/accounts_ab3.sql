{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('accounts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sid',
        'uri',
        'type',
        'status',
        'auth_token',
        'date_created',
        'date_updated',
        'friendly_name',
        object_to_string('subresource_uris'),
        'owner_account_sid',
    ]) }} as _airbyte_accounts_hashid,
    tmp.*
from {{ ref('accounts_ab2') }} tmp
-- accounts
where 1 = 1

