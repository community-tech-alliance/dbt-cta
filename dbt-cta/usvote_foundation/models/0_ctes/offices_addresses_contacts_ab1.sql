{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('offices_addresses') }}
{{ unnest_cte(ref('offices_addresses'), 'addresses', 'contacts') }}
select
    _airbyte_addresses_hashid,
    {{ json_extract_scalar(unnested_column_value('contacts'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('contacts'), ['address_uri'], ['address_uri']) }} as address_uri,
    {{ json_extract_scalar(unnested_column_value('contacts'), ['official_uri'], ['official_uri']) }} as official_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('offices_addresses') }}
-- contacts at offices/addresses/contacts
{{ cross_join_unnest('addresses', 'contacts') }}
where
    1 = 1
    and contacts is not null
