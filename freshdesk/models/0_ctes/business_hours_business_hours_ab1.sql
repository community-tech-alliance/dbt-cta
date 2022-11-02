{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('business_hours') }}
select
    _airbyte_business_hours_hashid,
    {{ json_extract('table_alias', 'business_hours', ['friday'], ['friday']) }} as friday,
    {{ json_extract('table_alias', 'business_hours', ['monday'], ['monday']) }} as monday,
    {{ json_extract('table_alias', 'business_hours', ['sunday'], ['sunday']) }} as sunday,
    {{ json_extract('table_alias', 'business_hours', ['tuesday'], ['tuesday']) }} as tuesday,
    {{ json_extract('table_alias', 'business_hours', ['saturday'], ['saturday']) }} as saturday,
    {{ json_extract('table_alias', 'business_hours', ['thursday'], ['thursday']) }} as thursday,
    {{ json_extract('table_alias', 'business_hours', ['wednesday'], ['wednesday']) }} as wednesday,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('business_hours') }} as table_alias
-- business_hours at business_hours/business_hours
where 1 = 1
and business_hours is not null

