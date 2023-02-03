{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('notification_settings_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(action_id as {{ dbt_utils.type_bigint() }}) as action_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(action_type as {{ dbt_utils.type_string() }}) as action_type,
    cast(third_parties_emails as {{ dbt_utils.type_string() }}) as third_parties_emails,
    cast(notificate_third_parties as {{ dbt_utils.type_bigint() }}) as notificate_third_parties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notification_settings_ab1') }}
-- notification_settings
where 1 = 1

