{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_source_receiver_ab3') }}
select
    _airbyte_source_hashid,
    address,
    amount_charged,
    amount_received,
    amount_returned,
    refund_attributes_method,
    refund_attributes_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_receiver_hashid
from {{ ref('charges_source_receiver_ab3') }}
-- receiver at charges/source/receiver from {{ ref('charges_source') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

