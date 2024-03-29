{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- depends_on: {{ ref('addresses_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sid',
        'uri',
        'city',
        'region',
        'street',
        boolean_to_string('verified'),
        boolean_to_string('validated'),
        'account_sid',
        'iso_country',
        'postal_code',
        'date_created',
        'date_updated',
        'customer_name',
        'friendly_name',
        'street_secondary',
        boolean_to_string('emergency_enabled'),
    ]) }} as _airbyte_addresses_hashid,
    tmp.*
from {{ ref('addresses_ab2') }} as tmp
-- addresses
where 1 = 1
