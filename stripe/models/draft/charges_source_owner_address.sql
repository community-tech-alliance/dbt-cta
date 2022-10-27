{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_source_owner_address_ab3') }}
select
    _airbyte_owner_hashid,
    city,
    line1,
    line2,
    state,
    country,
    postal_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_address_hashid
from {{ ref('charges_source_owner_address_ab3') }}
-- address at charges/source/owner/address from {{ ref('charges_source_owner') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

