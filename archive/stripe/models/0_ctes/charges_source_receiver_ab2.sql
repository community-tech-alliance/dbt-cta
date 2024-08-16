{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_source_receiver_ab1') }}
select
    _airbyte_source_hashid,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(amount_charged as {{ dbt_utils.type_bigint() }}) as amount_charged,
    cast(amount_received as {{ dbt_utils.type_bigint() }}) as amount_received,
    cast(amount_returned as {{ dbt_utils.type_bigint() }}) as amount_returned,
    cast(refund_attributes_method as {{ dbt_utils.type_string() }}) as refund_attributes_method,
    cast(refund_attributes_status as {{ dbt_utils.type_string() }}) as refund_attributes_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_source_receiver_ab1') }}
-- receiver at charges_base/source/receiver
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

