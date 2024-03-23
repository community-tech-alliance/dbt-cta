{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('delivery_targets_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(bioid as {{ dbt_utils.type_string() }}) as bioid,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(message as {{ dbt_utils.type_string() }}) as message,
    cast(subject as {{ dbt_utils.type_string() }}) as subject,
    cast(form_data as {{ dbt_utils.type_string() }}) as form_data,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(captcha_uid as {{ dbt_utils.type_string() }}) as captcha_uid,
    cast(captcha_url as {{ dbt_utils.type_string() }}) as captcha_url,
    cast(delivery_id as {{ dbt_utils.type_bigint() }}) as delivery_id,
    cast(target_name as {{ dbt_utils.type_string() }}) as target_name,
    cast(target_party as {{ dbt_utils.type_string() }}) as target_party,
    cast(target_state as {{ dbt_utils.type_string() }}) as target_state,
    cast(delivery_method as {{ dbt_utils.type_string() }}) as delivery_method,
    cast(target_district as {{ dbt_utils.type_string() }}) as target_district,
    cast(target_position as {{ dbt_utils.type_string() }}) as target_position,
    cast(captcha_required as {{ dbt_utils.type_bigint() }}) as captcha_required,
    cast(letter_template_id as {{ dbt_utils.type_bigint() }}) as letter_template_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('delivery_targets_ab1') }}
-- delivery_targets
where 1 = 1
