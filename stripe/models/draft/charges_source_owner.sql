{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_source_owner_ab3') }}
select
    _airbyte_source_hashid,
    name,
    email,
    phone,
    address,
    verified_name,
    verified_email,
    verified_phone,
    verified_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_owner_hashid
from {{ ref('charges_source_owner_ab3') }}
-- owner at charges/source/owner from {{ ref('charges_source') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

