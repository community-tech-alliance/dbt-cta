{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('modifier_list_modifier_list_data_modifiers_modifier_data_price_money_ab3') }}
select
    _airbyte_modifier_data_hashid,
    amount,
    currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_price_money_hashid
from {{ ref('modifier_list_modifier_list_data_modifiers_modifier_data_price_money_ab3') }}
-- price_money at modifier_list/modifier_list_data/modifiers/modifier_data/price_money from {{ ref('modifier_list_modifier_list_data_modifiers_modifier_data') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

