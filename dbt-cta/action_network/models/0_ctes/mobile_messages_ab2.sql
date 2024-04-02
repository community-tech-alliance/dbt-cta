{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('mobile_messages_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(body as {{ dbt_utils.type_string() }}) as body,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(stats as {{ dbt_utils.type_string() }}) as stats,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(tag_list as {{ dbt_utils.type_string() }}) as tag_list,
    cast(media_url as {{ dbt_utils.type_string() }}) as media_url,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(send_date as {{ dbt_utils.type_string() }}) as send_date,
    cast(timezones as {{ dbt_utils.type_string() }}) as timezones,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(is_sending as {{ dbt_utils.type_bigint() }}) as is_sending,
    cast(total_sent as {{ dbt_utils.type_bigint() }}) as total_sent,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(finish_send as {{ dbt_utils.type_bigint() }}) as finish_send,
    cast(delivered_at as {{ dbt_utils.type_string() }}) as delivered_at,
    cast(actions_count as {{ dbt_utils.type_bigint() }}) as actions_count,
    cast(first_permalink as {{ dbt_utils.type_string() }}) as first_permalink,
    cast(administrative_title as {{ dbt_utils.type_string() }}) as administrative_title,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('mobile_messages_ab1') }}
-- mobile_messages
where 1 = 1
