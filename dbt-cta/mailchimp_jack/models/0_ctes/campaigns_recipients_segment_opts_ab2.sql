{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_recipients_segment_opts_ab1') }}
select
    _airbyte_recipients_hashid,
    cast(match as {{ dbt_utils.type_string() }}) as match,
    conditions,
    cast(saved_segment_id as {{ dbt_utils.type_bigint() }}) as saved_segment_id,
    cast(prebuilt_segment_id as {{ dbt_utils.type_string() }}) as prebuilt_segment_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_recipients_segment_opts_ab1') }}
-- segment_opts at campaigns/recipients/segment_opts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

