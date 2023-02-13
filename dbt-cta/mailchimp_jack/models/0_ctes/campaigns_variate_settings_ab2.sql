{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_variate_settings_ab1') }}
select
    _airbyte_campaigns_hashid,
    contents,
    cast(test_size as {{ dbt_utils.type_bigint() }}) as test_size,
    cast(wait_time as {{ dbt_utils.type_bigint() }}) as wait_time,
    from_names,
    send_times,
    combinations,
    subject_lines,
    cast(winner_criteria as {{ dbt_utils.type_string() }}) as winner_criteria,
    reply_to_addresses,
    cast(winning_campaign_id as {{ dbt_utils.type_string() }}) as winning_campaign_id,
    cast(winning_combination_id as {{ dbt_utils.type_string() }}) as winning_combination_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_variate_settings_ab1') }}
-- variate_settings at campaigns/variate_settings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

