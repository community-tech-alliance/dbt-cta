{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('emails_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ adapter.quote('to') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('to') }},
    cast(body as {{ dbt_utils.type_string() }}) as body,
    cast({{ adapter.quote('from') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('from') }},
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(stats as {{ dbt_utils.type_string() }}) as stats,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(subject as {{ dbt_utils.type_string() }}) as subject,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(reply_to as {{ dbt_utils.type_string() }}) as reply_to,
    cast(tag_list as {{ dbt_utils.type_string() }}) as tag_list,
    cast(tag_list as {{ dbt_utils.type_string() }}) as stream_id,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(send_date as {{ dbt_utils.type_string() }}) as send_date,
    cast(timezones as {{ dbt_utils.type_string() }}) as timezones,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(is_sending as {{ dbt_utils.type_bigint() }}) as is_sending,
    cast(pre_header as {{ dbt_utils.type_string() }}) as pre_header,
    cast(total_sent as {{ dbt_utils.type_bigint() }}) as total_sent,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(finish_send as {{ dbt_utils.type_bigint() }}) as finish_send,
    cast(builder_html as {{ dbt_utils.type_string() }}) as builder_html,
    cast(builder_json as {{ dbt_utils.type_string() }}) as builder_json,
    cast(button_color as {{ dbt_utils.type_string() }}) as button_color,
    cast(delivered_at as {{ dbt_utils.type_string() }}) as delivered_at,
    cast(actions_count as {{ dbt_utils.type_bigint() }}) as actions_count,
    cast(target_option as {{ dbt_utils.type_string() }}) as target_option,
    cast(typeface_color as {{ dbt_utils.type_string() }}) as typeface_color,
    cast(first_permalink as {{ dbt_utils.type_string() }}) as first_permalink,
    cast(inlined_content as {{ dbt_utils.type_string() }}) as inlined_content,
    cast(parent_email_id as {{ dbt_utils.type_bigint() }}) as parent_email_id,
    cast(button_text_color as {{ dbt_utils.type_string() }}) as button_text_color,
    cast(email_template_id as {{ dbt_utils.type_bigint() }}) as email_template_id,
    cast(administrative_title as {{ dbt_utils.type_string() }}) as administrative_title,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('emails_ab1') }}
-- emails
where 1 = 1
