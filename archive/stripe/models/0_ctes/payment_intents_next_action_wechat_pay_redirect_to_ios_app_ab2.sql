{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_next_action_wechat_pay_redirect_to_ios_app_ab1') }}
select
    _airbyte_next_action_hashid,
    cast(native_url as {{ dbt_utils.type_string() }}) as native_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_next_action_wechat_pay_redirect_to_ios_app_ab1') }}
-- wechat_pay_redirect_to_ios_app at payment_intents_base/next_action/wechat_pay_redirect_to_ios_app
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

