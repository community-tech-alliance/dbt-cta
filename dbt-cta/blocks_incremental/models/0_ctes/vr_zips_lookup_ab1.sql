{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_vr_zips_lookup') }}
select
    {{ json_extract_scalar('_airbyte_data', ['voter_age'], ['voter_age']) }} as voter_age,
    {{ json_extract_scalar('_airbyte_data', ['voter_gender'], ['voter_gender']) }} as voter_gender,
    {{ json_extract_scalar('_airbyte_data', ['turnout_score_avg'], ['turnout_score_avg']) }} as turnout_score_avg,
    {{ json_extract_scalar('_airbyte_data', ['count'], ['count']) }} as count,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['zip5'], ['zip5']) }} as zip5,
    {{ json_extract_scalar('_airbyte_data', ['support_avg'], ['support_avg']) }} as support_avg,
    {{ json_extract_scalar('_airbyte_data', ['party_score_avg'], ['party_score_avg']) }} as party_score_avg,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_vr_zips_lookup') }} as table_alias
-- vr_zips_lookup
where 1 = 1

