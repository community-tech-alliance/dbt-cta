{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_scalar('restaurant_specialties', ['lunch'], ['lunch']) }} as lunch,
    {{ json_extract_scalar('restaurant_specialties', ['coffee'], ['coffee']) }} as coffee,
    {{ json_extract_scalar('restaurant_specialties', ['drinks'], ['drinks']) }} as drinks,
    {{ json_extract_scalar('restaurant_specialties', ['breakfast'], ['breakfast']) }} as breakfast,
    {{ json_extract_scalar('restaurant_specialties', ['dinner'], ['dinner']) }} as dinner,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- restaurant_specialties at page/restaurant_specialties
where 1 = 1
and restaurant_specialties is not null

