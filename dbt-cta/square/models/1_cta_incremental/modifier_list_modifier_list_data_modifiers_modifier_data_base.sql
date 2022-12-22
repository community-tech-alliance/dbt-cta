{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('modifier_list_modifier_list_data_modifiers_modifier_data_ab3') }}
select
    _airbyte_modifiers_hashid,
    name,
    ordinal,
    price_money,
    on_by_default,
    modifier_list_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_modifier_data_hashid
from {{ ref('modifier_list_modifier_list_data_modifiers_modifier_data_ab3') }}
-- modifier_data at modifier_list/modifier_list_data/modifiers/modifier_data from {{ ref('modifier_list_modifier_list_data_modifiers') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

