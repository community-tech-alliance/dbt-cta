{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_report_summary_ecommerce_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_report_summary_hashid',
        'total_spent',
        'total_orders',
        'total_revenue',
    ]) }} as _airbyte_ecommerce_hashid,
    tmp.*
from {{ ref('campaigns_report_summary_ecommerce_ab2') }} tmp
-- ecommerce at campaigns/report_summary/ecommerce
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

