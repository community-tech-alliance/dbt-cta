{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_service_charges') }}
select
    _airbyte_service_charges_hashid,
    {{ json_extract_scalar('applied_money', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('applied_money', ['currency'], ['currency']) }} as currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_service_charges_base') }}
-- applied_money at orders/service_charges/applied_money
where
    1 = 1
    and applied_money is not null
