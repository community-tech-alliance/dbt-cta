{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_source') }}
select
    _airbyte_source_hashid,
    {{ json_extract_scalar('redirect', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('redirect', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('redirect', ['return_url'], ['return_url']) }} as return_url,
    {{ json_extract_scalar('redirect', ['failure_reason'], ['failure_reason']) }} as failure_reason,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_source') }} as table_alias
-- redirect at charges_base/source/redirect
where 1 = 1
and redirect is not null
{{ incremental_clause('_airbyte_emitted_at') }}

