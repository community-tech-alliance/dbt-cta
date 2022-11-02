{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('ticket_fields') }}
select
    _airbyte_ticket_fields_hashid,
    {{ json_extract_scalar('dependent_fields', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('dependent_fields', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('dependent_fields', ['label'], ['label']) }} as label,
    {{ json_extract_scalar('dependent_fields', ['level'], ['level']) }} as level,
    {{ json_extract_scalar('dependent_fields', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('dependent_fields', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('dependent_fields', ['ticket_field_id'], ['ticket_field_id']) }} as ticket_field_id,
    {{ json_extract_scalar('dependent_fields', ['label_for_customers'], ['label_for_customers']) }} as label_for_customers,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ticket_fields') }} as table_alias
-- dependent_fields at ticket_fields/dependent_fields
where 1 = 1
and dependent_fields is not null

