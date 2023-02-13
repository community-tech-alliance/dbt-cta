{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_variate_settings_combinations_ab1') }}
select
    _airbyte_variate_settings_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(reply_to as {{ dbt_utils.type_bigint() }}) as reply_to,
    cast(from_name as {{ dbt_utils.type_bigint() }}) as from_name,
    cast(send_time as {{ dbt_utils.type_bigint() }}) as send_time,
    cast(recipients as {{ dbt_utils.type_bigint() }}) as recipients,
    cast(subject_line as {{ dbt_utils.type_bigint() }}) as subject_line,
    cast(content_description as {{ dbt_utils.type_bigint() }}) as content_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_variate_settings_combinations_ab1') }}
-- combinations at campaigns/variate_settings/combinations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

