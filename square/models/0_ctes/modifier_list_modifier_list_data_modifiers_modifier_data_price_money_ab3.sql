{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('modifier_list_modifier_list_data_modifiers_modifier_data_price_money_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_modifier_data_hashid',
        'amount',
        'currency',
    ]) }} as _airbyte_price_money_hashid,
    tmp.*
from {{ ref('modifier_list_modifier_list_data_modifiers_modifier_data_price_money_ab2') }} tmp
-- price_money at modifier_list/modifier_list_data/modifiers/modifier_data/price_money
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

