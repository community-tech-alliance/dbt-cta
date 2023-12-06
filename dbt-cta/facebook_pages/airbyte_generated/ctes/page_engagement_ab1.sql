{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_scalar('engagement', ['social_sentence_without_like'], ['social_sentence_without_like']) }} as social_sentence_without_like,
    {{ json_extract_scalar('engagement', ['count_string'], ['count_string']) }} as count_string,
    {{ json_extract_scalar('engagement', ['social_sentence_with_like'], ['social_sentence_with_like']) }} as social_sentence_with_like,
    {{ json_extract_scalar('engagement', ['count_string_without_like'], ['count_string_without_like']) }} as count_string_without_like,
    {{ json_extract_scalar('engagement', ['count'], ['count']) }} as count,
    {{ json_extract_scalar('engagement', ['count_string_with_like'], ['count_string_with_like']) }} as count_string_with_like,
    {{ json_extract_scalar('engagement', ['social_sentence'], ['social_sentence']) }} as social_sentence,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- engagement at page/engagement
where 1 = 1
and engagement is not null

