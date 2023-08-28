{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('invoice_line_items_period_ab1') }}
select
    _airbyte_invoice_line_items_hashid,
    cast({{ adapter.quote('end') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('end') }},
    cast(start as {{ dbt_utils.type_bigint() }}) as start,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoice_line_items_period_ab1') }}
-- period at invoice_line_items_base/period
where 1 = 1
