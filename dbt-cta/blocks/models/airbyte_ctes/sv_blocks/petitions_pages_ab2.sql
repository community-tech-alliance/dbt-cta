{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('petitions_pages_ab1') }}
select
    cast({{ empty_string_to_null('date') }} as {{ type_date() }}) as date,
    {{ cast_to_boolean('possible_fraud') }} as possible_fraud,
    cast(box_number as {{ dbt_utils.type_string() }}) as box_number,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast({{ empty_string_to_null('notary_date') }} as {{ type_date() }}) as notary_date,
    cast(notary_id as {{ dbt_utils.type_bigint() }}) as notary_id,
    cast(signatures_count as {{ dbt_utils.type_bigint() }}) as signatures_count,
    {{ cast_to_boolean('notary_seal') }} as notary_seal,
    cast(petition_book_id as {{ dbt_utils.type_bigint() }}) as petition_book_id,
    cast(canvasser_id as {{ dbt_utils.type_bigint() }}) as canvasser_id,
    cast(county as {{ dbt_utils.type_string() }}) as county,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    {{ cast_to_boolean('notary_signature') }} as notary_signature,
    cast(signers_county as {{ dbt_utils.type_string() }}) as signers_county,
    cast(scan_file_data as {{ dbt_utils.type_string() }}) as scan_file_data,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    cast(scan_number as {{ dbt_utils.type_string() }}) as scan_number,
    {{ cast_to_boolean('canvasser_signature') }} as canvasser_signature,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(notary_county as {{ dbt_utils.type_string() }}) as notary_county,
    cast(shift_id as {{ dbt_utils.type_bigint() }}) as shift_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('petitions_pages_ab1') }}
-- petitions_pages
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

