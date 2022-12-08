{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('canned_responses') }}
{{ unnest_cte(ref('canned_responses'), 'canned_responses', 'attachments') }}
select
    _airbyte_canned_responses_hashid,
    {{ json_extract_scalar(unnested_column_value('attachments'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('attachments'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('attachments'), ['size'], ['size']) }} as size,
    {{ json_extract_scalar(unnested_column_value('attachments'), ['thumb_url'], ['thumb_url']) }} as thumb_url,
    {{ json_extract_scalar(unnested_column_value('attachments'), ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar(unnested_column_value('attachments'), ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar(unnested_column_value('attachments'), ['content_type'], ['content_type']) }} as content_type,
    {{ json_extract_scalar(unnested_column_value('attachments'), ['attachment_url'], ['attachment_url']) }} as attachment_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('canned_responses') }} as table_alias
-- attachments at canned_responses/attachments
{{ cross_join_unnest('canned_responses', 'attachments') }}
where 1 = 1
and attachments is not null

