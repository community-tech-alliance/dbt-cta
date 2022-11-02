{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('agents') }}
select
    _airbyte_agents_hashid,
    {{ json_extract_scalar('contact', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('contact', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('contact', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('contact', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('contact', ['mobile'], ['mobile']) }} as mobile,
    {{ json_extract_scalar('contact', ['language'], ['language']) }} as language,
    {{ json_extract_scalar('contact', ['job_title'], ['job_title']) }} as job_title,
    {{ json_extract_scalar('contact', ['time_zone'], ['time_zone']) }} as time_zone,
    {{ json_extract_scalar('contact', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('contact', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('contact', ['last_login_at'], ['last_login_at']) }} as last_login_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('agents') }} as table_alias
-- contact at agents/contact
where 1 = 1
and contact is not null

