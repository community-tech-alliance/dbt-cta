{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ctaresults_ab1') }}
select
    cast(profileEid as {{ dbt_utils.type_string() }}) as profileEid,
    cast(ctaId as {{ dbt_utils.type_bigint() }}) as ctaId,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(contactedMts as {{ dbt_utils.type_bigint() }}) as contactedMts,
    cast(answers as {{ type_json() }}) as answers,
    cast(answeridsbypromptid as {{ type_json() }}) as answeridsbypromptid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctaresults_ab1') }}
-- ctaresults
where 1 = 1

