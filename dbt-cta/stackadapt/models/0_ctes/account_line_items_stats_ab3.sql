{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('account_line_items_stats_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'ctr',
        'cvr',
        'imp',
        'ltr',
        'atos',
        'conv',
        'cost',
        'date',
        'ecpa',
        'ecpc',
        'ecpe',
        'ecpm',
        'ecpv',
        'rcpc',
        'rcpe',
        'rcpm',
        'roas',
        'click',
        'ecpcl',
        'rcpcl',
        'profit',
        's_conv',
        'conv_ip',
        'revenue',
        'vcomp_0',
        'conv_rev',
        'vcomp_25',
        'vcomp_50',
        'vcomp_75',
        'vcomp_95',
        'line_item',
        'page_time',
        'uniq_conv',
        'uniq_ecpa',
        'atos_units',
        'conv_click',
        'page_start',
        'unique_imp',
        'vcomp_rate',
        'engage_rate',
        'tp_cpc_cost',
        'tp_cpm_cost',
        'unique_conv',
        'view_percent',
        'page_time_15s',
        'sub_advertiser',
        'page_time_units',
        'conv_imp_derived',
        'conv_imp_time_avg',
        'conv_click_time_avg',
        'unique_imp_inverse_rate',
    ]) }} as _airbyte_account_line_items_stats_hashid,
    tmp.*
from {{ ref('account_line_items_stats_ab2') }} as tmp
-- account_line_items_stats
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

