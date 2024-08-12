{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_activities_export_ab1') }}
select
    cast(performs as {{ dbt_utils.type_bigint() }}) as performs,
    cast(user_email as {{ dbt_utils.type_string() }}) as user_email,
    cast(utm_campaign as {{ dbt_utils.type_string() }}) as utm_campaign,
    cast(user_last_name as {{ dbt_utils.type_string() }}) as user_last_name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(testimonial_note as {{ dbt_utils.type_string() }}) as testimonial_note,
    {{ cast_to_boolean('completed') }} as completed,
    cast(impressions as {{ dbt_utils.type_bigint() }}) as impressions,
    cast(user_fullname as {{ dbt_utils.type_string() }}) as user_fullname,
    cast({{ empty_string_to_null('user_last_seen_at') }} as {{ type_timestamp_without_timezone() }}) as user_last_seen_at,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast(user_first_name as {{ dbt_utils.type_string() }}) as user_first_name,
    cast(testimonial_media_url as {{ dbt_utils.type_string() }}) as testimonial_media_url,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(activity_id as {{ dbt_utils.type_bigint() }}) as activity_id,
    cast(clicks as {{ dbt_utils.type_bigint() }}) as clicks,
    cast(user_phone as {{ dbt_utils.type_string() }}) as user_phone,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ empty_string_to_null('published_at') }} as {{ type_timestamp_without_timezone() }}) as published_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(utm_source as {{ dbt_utils.type_string() }}) as utm_source,
    cast(activity_title as {{ dbt_utils.type_string() }}) as activity_title,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_activities_export_ab1') }}
-- user_activities_export
where 1 = 1

