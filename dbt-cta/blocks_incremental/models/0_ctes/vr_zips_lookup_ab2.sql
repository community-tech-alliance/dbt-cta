{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('vr_zips_lookup_ab1') }}
select
    cast(voter_age as {{ dbt_utils.type_float() }}) as voter_age,
    cast(voter_gender as {{ dbt_utils.type_string() }}) as voter_gender,
    cast(turnout_score_avg as {{ dbt_utils.type_float() }}) as turnout_score_avg,
    cast(count as {{ dbt_utils.type_bigint() }}) as count,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(zip5 as {{ dbt_utils.type_string() }}) as zip5,
    cast(support_avg as {{ dbt_utils.type_float() }}) as support_avg,
    cast(party_score_avg as {{ dbt_utils.type_float() }}) as party_score_avg,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('vr_zips_lookup_ab1') }}
-- vr_zips_lookup
where 1 = 1

