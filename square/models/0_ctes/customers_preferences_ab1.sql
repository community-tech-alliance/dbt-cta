{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar('preferences', ['email_unsubscribed'], ['email_unsubscribed']) }} as email_unsubscribed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers') }} as table_alias
-- preferences at customers/preferences
where 1 = 1
and preferences is not null

