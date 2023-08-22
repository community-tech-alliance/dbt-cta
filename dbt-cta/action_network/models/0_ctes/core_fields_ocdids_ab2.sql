{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('core_fields_ocdids_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(ocdid_id as {{ dbt_utils.type_bigint() }}) as ocdid_id,
    cast(core_field_id as {{ dbt_utils.type_bigint() }}) as core_field_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('core_fields_ocdids_ab1') }}
-- core_fields_ocdids
where 1 = 1
