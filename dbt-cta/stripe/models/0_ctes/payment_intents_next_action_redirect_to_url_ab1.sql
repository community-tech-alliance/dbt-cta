{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_next_action_base') }}
select
    _airbyte_next_action_hashid,
    {{ json_extract_scalar('redirect_to_url', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('redirect_to_url', ['return_url'], ['return_url']) }} as return_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_next_action_base') }} as table_alias
-- redirect_to_url at payment_intents_base/next_action/redirect_to_url
where 1 = 1
and redirect_to_url is not null
{{ incremental_clause('_airbyte_emitted_at') }}

