{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('creatives_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(headline as {{ dbt_utils.type_string() }}) as headline,
    {{ cast_to_boolean('shareable') }} as shareable,
    cast(ad_product as {{ dbt_utils.type_string() }}) as ad_product,
    cast(brand_name as {{ dbt_utils.type_string() }}) as brand_name,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(render_type as {{ dbt_utils.type_string() }}) as render_type,
    cast(ad_account_id as {{ dbt_utils.type_string() }}) as ad_account_id,
    cast(review_status as {{ dbt_utils.type_string() }}) as review_status,
    cast(call_to_action as {{ dbt_utils.type_string() }}) as call_to_action,
    cast(packaging_status as {{ dbt_utils.type_string() }}) as packaging_status,
    cast(top_snap_media_id as {{ dbt_utils.type_string() }}) as top_snap_media_id,
    cast(web_view_properties as {{ type_json() }}) as web_view_properties,
    cast(review_status_details as {{ dbt_utils.type_string() }}) as review_status_details,
    cast(top_snap_crop_position as {{ dbt_utils.type_string() }}) as top_snap_crop_position,
    cast(forced_view_eligibility as {{ dbt_utils.type_string() }}) as forced_view_eligibility,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('creatives_ab1') }}
-- creatives
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

