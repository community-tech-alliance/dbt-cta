{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_report_summary_ecommerce_ab1') }}
select
    _airbyte_report_summary_hashid,
    cast(total_spent as {{ dbt_utils.type_float() }}) as total_spent,
    cast(total_orders as {{ dbt_utils.type_bigint() }}) as total_orders,
    cast(total_revenue as {{ dbt_utils.type_float() }}) as total_revenue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_report_summary_ecommerce_ab1') }}
-- ecommerce at campaigns/report_summary/ecommerce
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

