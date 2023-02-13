{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_recipients_segment_opts_conditions_ab1') }}
select
    _airbyte_segment_opts_hashid,
    cast(op as {{ dbt_utils.type_string() }}) as op,
    cast(field as {{ dbt_utils.type_string() }}) as field,
    cast(value as {{ dbt_utils.type_string() }}) as value,
    cast(condition_type as {{ dbt_utils.type_string() }}) as condition_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_recipients_segment_opts_conditions_ab1') }}
-- conditions at campaigns/recipients/segment_opts/conditions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

