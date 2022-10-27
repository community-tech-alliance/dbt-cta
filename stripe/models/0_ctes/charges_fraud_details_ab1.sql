{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges') }}
select
    _airbyte_charges_hashid,
    {{ json_extract_scalar('fraud_details', ['stripe_report'], ['stripe_report']) }} as stripe_report,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges') }} as table_alias
-- fraud_details at charges/fraud_details
where 1 = 1
and fraud_details is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

