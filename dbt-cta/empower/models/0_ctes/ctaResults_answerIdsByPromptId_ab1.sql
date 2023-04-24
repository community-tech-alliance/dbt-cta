{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('ctaresults_base') }}
select
    _airbyte_ctaresults_hashid,
    {{ json_extract_string_array('answeridsbypromptid', ['13805'], ['13805']) }} as _13805,
    {{ json_extract_string_array('answeridsbypromptid', ['13198'], ['13198']) }} as _13198,
    {{ json_extract_string_array('answeridsbypromptid', ['13683'], ['13683']) }} as _13683,
    {{ json_extract_string_array('answeridsbypromptid', ['13197'], ['13197']) }} as _13197,
    {{ json_extract_string_array('answeridsbypromptid', ['13684'], ['13684']) }} as _13684,
    {{ json_extract_string_array('answeridsbypromptid', ['13800'], ['13800']) }} as _13800,
    {{ json_extract_string_array('answeridsbypromptid', ['13303'], ['13303']) }} as _13303,
    {{ json_extract_string_array('answeridsbypromptid', ['13304'], ['13304']) }} as _13304,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctaresults_base') }} as table_alias
-- answeridsbypromptid at ctaresults/answeridsbypromptid
where 1 = 1
and answeridsbypromptid is not null

