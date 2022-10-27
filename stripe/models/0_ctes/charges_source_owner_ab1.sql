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
    {{ json_extract_scalar('owner', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('owner', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('owner', ['phone'], ['phone']) }} as phone,
    {{ json_extract('table_alias', 'owner', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('owner', ['verified_name'], ['verified_name']) }} as verified_name,
    {{ json_extract_scalar('owner', ['verified_email'], ['verified_email']) }} as verified_email,
    {{ json_extract_scalar('owner', ['verified_phone'], ['verified_phone']) }} as verified_phone,
    {{ json_extract_scalar('owner', ['verified_address'], ['verified_address']) }} as verified_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_source') }} as table_alias
-- owner at charges/source/owner
where 1 = 1
and owner is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

