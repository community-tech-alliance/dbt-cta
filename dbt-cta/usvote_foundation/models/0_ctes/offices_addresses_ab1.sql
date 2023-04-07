{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('offices') }}
{{ unnest_cte(ref('offices'), 'offices', 'addresses') }}
select
    _airbyte_offices_hashid,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['zip'], ['zip']) }} as zip,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['city'], ['city']) }} as city,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['zip4'], ['zip4']) }} as zip4,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['state'], ['state']) }} as state,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['street1'], ['street1']) }} as street1,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['street2'], ['street2']) }} as street2,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['website'], ['website']) }} as website,
    {{ json_extract_array(unnested_column_value('addresses'), ['contacts'], ['contacts']) }} as contacts,
    {{ json_extract_array(unnested_column_value('addresses'), ['functions'], ['functions']) }} as functions,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['address_to'], ['address_to']) }} as address_to,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['main_email'], ['main_email']) }} as main_email,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['is_physical'], ['is_physical']) }} as is_physical,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['resource_uri'], ['resource_uri']) }} as resource_uri,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['is_regular_mail'], ['is_regular_mail']) }} as is_regular_mail,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['main_fax_number'], ['main_fax_number']) }} as main_fax_number,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['main_phone_number'], ['main_phone_number']) }} as main_phone_number,
    {{ json_extract_scalar(unnested_column_value('addresses'), ['primary_contact_uri'], ['primary_contact_uri']) }} as primary_contact_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('offices') }} as table_alias
-- addresses at offices/addresses
{{ cross_join_unnest('offices', 'addresses') }}
where 1 = 1
and addresses is not null

