{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('denominations_organizations_ab1') }}
select
    cast(denomination_id as {{ dbt_utils.type_bigint() }}) as denomination_id,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('denominations_organizations_ab1') }}
-- denominations_organizations
where 1 = 1

