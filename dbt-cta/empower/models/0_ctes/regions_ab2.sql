{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('regions_ab1') }}
select
    cast(organizationId as {{ dbt_utils.type_bigint() }}) as organizationId,
    cast(inviteCodeCreatedMts as {{ dbt_utils.type_bigint() }}) as inviteCodeCreatedMts,
    cast(ctaId as {{ dbt_utils.type_bigint() }}) as ctaId,
    cast(inviteCode as {{ dbt_utils.type_string() }}) as inviteCode,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('regions_ab1') }}
-- regions
where 1 = 1
