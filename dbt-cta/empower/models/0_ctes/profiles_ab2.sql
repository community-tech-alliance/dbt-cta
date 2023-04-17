{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_empower_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('profiles_ab1') }}
select
    cast(zip as {{ dbt_utils.type_string() }}) as zip,
    cast(lastUsedEmpowerMts as {{ dbt_utils.type_bigint() }}) as lastUsedEmpowerMts,
    cast(eid as {{ dbt_utils.type_string() }}) as eid,
    cast(lastName as {{ dbt_utils.type_string() }}) as lastName,
    canvassedByCtaId,
    cast(role as {{ dbt_utils.type_string() }}) as role,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(myCampaignVanId as {{ dbt_utils.type_bigint() }}) as myCampaignVanId,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    address2,
    cast(createdMts as {{ dbt_utils.type_bigint() }}) as createdMts,
    cast(parentEid as {{ dbt_utils.type_string() }}) as parentEid,
    activeCtaIds,
    cast(firstName as {{ dbt_utils.type_string() }}) as firstName,
    cast(currentCtaId as {{ dbt_utils.type_bigint() }}) as currentCtaId,
    vanId,
    cast(updatedMts as {{ dbt_utils.type_bigint() }}) as updatedMts,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(regionId as {{ dbt_utils.type_bigint() }}) as regionId,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(relationship as {{ dbt_utils.type_string() }}) as relationship,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('profiles_ab1') }}
-- profiles
where 1 = 1

