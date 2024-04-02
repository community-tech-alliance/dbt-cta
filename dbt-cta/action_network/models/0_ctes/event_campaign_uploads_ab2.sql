{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('event_campaign_uploads_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ adapter.quote('rows') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('rows') }},
    cast(failure as {{ dbt_utils.type_bigint() }}) as failure,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(upload_type as {{ dbt_utils.type_string() }}) as upload_type,
    cast(fail_message as {{ dbt_utils.type_string() }}) as fail_message,
    cast(csv_file_name as {{ dbt_utils.type_string() }}) as csv_file_name,
    cast(csv_file_size as {{ dbt_utils.type_bigint() }}) as csv_file_size,
    cast(csv_content_type as {{ dbt_utils.type_string() }}) as csv_content_type,
    cast(event_campaign_id as {{ dbt_utils.type_bigint() }}) as event_campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('event_campaign_uploads_ab1') }}
-- event_campaign_uploads
where 1 = 1
