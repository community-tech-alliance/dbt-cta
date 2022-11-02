{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sla_policies') }}
select
    _airbyte_sla_policies_hashid,
    {{ json_extract_string_array('applicable_to', ['sources'], ['sources']) }} as sources,
    {{ json_extract_string_array('applicable_to', ['group_ids'], ['group_ids']) }} as group_ids,
    {{ json_extract_string_array('applicable_to', ['company_ids'], ['company_ids']) }} as company_ids,
    {{ json_extract_string_array('applicable_to', ['product_ids'], ['product_ids']) }} as product_ids,
    {{ json_extract_string_array('applicable_to', ['ticket_types'], ['ticket_types']) }} as ticket_types,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies') }} as table_alias
-- applicable_to at sla_policies/applicable_to
where 1 = 1
and applicable_to is not null

