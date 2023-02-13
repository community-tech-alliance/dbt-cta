{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_recipients') }}
select
    _airbyte_recipients_hashid,
    {{ json_extract_scalar('segment_opts', ['match'], ['match']) }} as match,
    {{ json_extract_array('segment_opts', ['conditions'], ['conditions']) }} as conditions,
    {{ json_extract_scalar('segment_opts', ['saved_segment_id'], ['saved_segment_id']) }} as saved_segment_id,
    {{ json_extract_scalar('segment_opts', ['prebuilt_segment_id'], ['prebuilt_segment_id']) }} as prebuilt_segment_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_recipients') }} as table_alias
-- segment_opts at campaigns/recipients/segment_opts
where 1 = 1
and segment_opts is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

