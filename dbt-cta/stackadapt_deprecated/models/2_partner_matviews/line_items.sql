-- depends_on: {{ source('cta', 'line_items_base') }}
select
    _airbyte_line_items_hashid,
    MAX(id) as id,
    MAX(name) as name,
    MAX(state) as state,
    MAX(budget) as budget,
    MAX(end_date) as end_date,
    MAX(daily_cap) as daily_cap,
    MAX(start_date) as start_date,
    MAX(budget_type) as budget_type,
    MAX(pace_evenly) as pace_evenly,
    MAX(revenue_type) as revenue_type,
    MAX(advertiser_id) as advertiser_id,
    MAX(revenue_value) as revenue_value,
    MAX(ARRAY_TO_STRING(all_campaign_ids,',')) as all_campaign_ids,
    MAX(black_list_options) as black_list_options,
    MAX(purchase_order_number) as purchase_order_number,
    MAX(_airbyte_ab_id) as _airbyte_ab_id,
    MAX(_airbyte_emitted_at) as _airbyte_emitted_at,
    MAX(_airbyte_normalized_at) as _airbyte_normalized_at    
from {{ source('cta', 'line_items_base') }}
where 1=1
group by _airbyte_line_items_hashid