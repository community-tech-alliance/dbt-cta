{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_tracking') }}
select
    _airbyte_tracking_hashid,
    {{ json_extract_scalar('salesforce', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('salesforce', ['campaign'], ['campaign']) }} as campaign,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_tracking') }} as table_alias
-- salesforce at campaigns/tracking/salesforce
where 1 = 1
and salesforce is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

