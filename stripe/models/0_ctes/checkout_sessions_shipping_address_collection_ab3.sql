{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_shipping_address_collection_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_checkout_sessions_hashid',
        array_to_string('allowed_countries'),
    ]) }} as _airbyte_shipping_address_collection_hashid,
    tmp.*
from {{ ref('checkout_sessions_shipping_address_collection_ab2') }} tmp
-- shipping_address_collection at checkout_sessions_base/shipping_address_collection
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

