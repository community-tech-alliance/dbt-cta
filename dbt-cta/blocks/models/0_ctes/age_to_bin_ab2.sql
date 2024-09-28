{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('age_to_bin_ab1') }}
select
    cast(label as {{ dbt_utils.type_string() }}) as label,
    cast(age as {{ dbt_utils.type_bigint() }}) as age,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('age_to_bin_ab1') }}
-- age_to_bin
where 1 = 1
