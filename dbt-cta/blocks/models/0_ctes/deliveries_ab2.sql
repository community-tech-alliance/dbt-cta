{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('deliveries_ab1') }}
select
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(batch_number as {{ dbt_utils.type_string() }}) as batch_number,
    cast({{ empty_string_to_null('form_filter_registration_date_start') }} as {{ type_date() }}) as form_filter_registration_date_start,
    cast(canvasser_id as {{ dbt_utils.type_bigint() }}) as canvasser_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(form_filter_turf_id as {{ dbt_utils.type_bigint() }}) as form_filter_turf_id,
    cast(form_filter_counties as {{ dbt_utils.type_string() }}) as form_filter_counties,
    cast(clerk_receipt_data as {{ dbt_utils.type_string() }}) as clerk_receipt_data,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    cast(office_id as {{ dbt_utils.type_bigint() }}) as office_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(turn_in_location_id as {{ dbt_utils.type_bigint() }}) as turn_in_location_id,
    cast(delivery_method as {{ dbt_utils.type_string() }}) as delivery_method,
    cast(runner_receipt_data as {{ dbt_utils.type_string() }}) as runner_receipt_data,
    cast({{ empty_string_to_null('form_filter_registration_date_end') }} as {{ type_date() }}) as form_filter_registration_date_end,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ empty_string_to_null('turn_in_date') }} as {{ type_date() }}) as turn_in_date,
    {{ cast_to_boolean('form_filters_no_county') }} as form_filters_no_county,
    cast(form_filter_qc_statuses as {{ dbt_utils.type_string() }}) as form_filter_qc_statuses,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('deliveries_ab1') }}
-- deliveries
where 1 = 1

