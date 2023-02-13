{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_ab_split_opts_ab1') }}
select
    _airbyte_campaigns_hashid,
    cast(subject_a as {{ dbt_utils.type_string() }}) as subject_a,
    cast(subject_b as {{ dbt_utils.type_string() }}) as subject_b,
    cast(wait_time as {{ dbt_utils.type_bigint() }}) as wait_time,
    cast(split_size as {{ dbt_utils.type_bigint() }}) as split_size,
    cast(split_test as {{ dbt_utils.type_string() }}) as split_test,
    cast(wait_units as {{ dbt_utils.type_string() }}) as wait_units,
    cast(from_name_a as {{ dbt_utils.type_string() }}) as from_name_a,
    cast(from_name_b as {{ dbt_utils.type_string() }}) as from_name_b,
    cast(pick_winner as {{ dbt_utils.type_string() }}) as pick_winner,
    cast(send_time_a as {{ dbt_utils.type_string() }}) as send_time_a,
    cast(send_time_b as {{ dbt_utils.type_string() }}) as send_time_b,
    cast(reply_email_a as {{ dbt_utils.type_string() }}) as reply_email_a,
    cast(reply_email_b as {{ dbt_utils.type_string() }}) as reply_email_b,
    cast(send_time_winner as {{ dbt_utils.type_string() }}) as send_time_winner,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_ab_split_opts_ab1') }}
-- ab_split_opts at campaigns/ab_split_opts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

