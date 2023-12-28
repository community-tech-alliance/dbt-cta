{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('delivery_forms_exclusions_ab1') }}
select
    cast(voter_registration_scan_id as {{ dbt_utils.type_bigint() }}) as voter_registration_scan_id,
    cast(delivery_id as {{ dbt_utils.type_bigint() }}) as delivery_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('delivery_forms_exclusions_ab1') }}
-- delivery_forms_exclusions
where 1 = 1
