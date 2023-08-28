{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- Final base SQL model
-- depends_on: {{ ref('account_campaigns_stats_ab3') }}
select
    ctr,
    cvr,
    imp,
    ltr,
    atos,
    conv,
    cost,
    safe_cast(date as date) as date,
    ecpa,
    ecpc,
    ecpe,
    ecpm,
    ecpv,
    rcpc,
    rcpe,
    rcpm,
    roas,
    click,
    ecpcl,
    rcpcl,
    profit,
    s_conv,
    channel,
    conv_ip,
    revenue,
    vcomp_0,
    campaign,
    safe_cast(end_date as timestamp) as end_date,
    vcomp_25,
    vcomp_50,
    vcomp_75,
    vcomp_95,
    line_item,
    page_time,
    atos_units,
    conv_click,
    page_start,
    safe_cast(start_date as timestamp) as start_date,
    unique_imp as reach,
    vcomp_rate,
    campaign_id,
    conv_cookie,
    tp_cpc_cost,
    tp_cpm_cost,
    unique_conv,
    line_item_id,
    view_percent,
    campaign_type,
    page_time_15s,
    sub_advertiser,
    page_time_units,
    conv_imp_derived,
    conv_imp_time_avg,
    sub_advertiser_id,
    conv_click_time_avg,
    campaign_custom_fields,
    unique_imp_inverse_rate as frequency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_account_campaigns_stats_hashid
from {{ ref('account_campaigns_stats_ab3') }}
-- account_campaigns_stats from {{ source('cta', '_airbyte_raw_account_campaigns_stats') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

