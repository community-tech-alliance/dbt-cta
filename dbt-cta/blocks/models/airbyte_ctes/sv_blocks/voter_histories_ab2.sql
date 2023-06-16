{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('voter_histories_ab1') }}
select
    cast(pct_label as {{ dbt_utils.type_string() }}) as pct_label,
    cast(vtd_label as {{ dbt_utils.type_string() }}) as vtd_label,
    cast(county as {{ dbt_utils.type_string() }}) as county,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(voter_reg_number as {{ dbt_utils.type_string() }}) as voter_reg_number,
    cast(voter_state as {{ dbt_utils.type_string() }}) as voter_state,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(voted_party_code as {{ dbt_utils.type_string() }}) as voted_party_code,
    cast(voted_county_id as {{ dbt_utils.type_bigint() }}) as voted_county_id,
    cast(election_id as {{ dbt_utils.type_bigint() }}) as election_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(voting_method as {{ dbt_utils.type_string() }}) as voting_method,
    cast(person_id as {{ dbt_utils.type_bigint() }}) as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('voter_histories_ab1') }}
-- voter_histories
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

