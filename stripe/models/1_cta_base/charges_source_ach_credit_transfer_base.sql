{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_source_ach_credit_transfer_ab3') }}
select
    _airbyte_source_hashid,
    bank_name,
    swift_code,
    fingerprint,
    account_number,
    routing_number,
    refund_account_number,
    refund_routing_number,
    refund_account_holder_name,
    refund_account_holder_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ach_credit_transfer_hashid
from {{ ref('charges_source_ach_credit_transfer_ab3') }}
-- ach_credit_transfer at charges/source/ach_credit_transfer from {{ ref('charges_source') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

