{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_recipients_ab1') }}
select
    _airbyte_campaigns_hashid,
    cast(list_id as {{ dbt_utils.type_string() }}) as list_id,
    cast(list_name as {{ dbt_utils.type_string() }}) as list_name,
    cast(segment_opts as {{ type_json() }}) as segment_opts,
    cast(segment_text as {{ dbt_utils.type_string() }}) as segment_text,
    {{ cast_to_boolean('list_is_active') }} as list_is_active,
    cast(recipient_count as {{ dbt_utils.type_bigint() }}) as recipient_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_recipients_ab1') }}
-- recipients at campaigns/recipients
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

