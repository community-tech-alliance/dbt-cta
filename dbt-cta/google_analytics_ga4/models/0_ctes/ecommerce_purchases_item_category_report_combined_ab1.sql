
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'ecommerce_purchases_item_category_report_combined') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   itemCategory4,
   itemCategory3,
   itemCategory2,
   itemCategory,
   itemCategory5,
   cartToViewRate,
   property_id,
   purchaseToViewRate,
   itemRevenue,
   itemsAddedToCart,
   itemsPurchased,
   itemsViewed,
   {{ dbt_utils.surrogate_key([
     '_airbyte_raw_id',
    '_airbyte_extracted_at',
    'date',
    'itemCategory4',
    'itemCategory3',
    'itemCategory2',
    'itemCategory',
    'itemCategory5',
    'property_id',
    'itemsAddedToCart',
    'itemsPurchased',
    'itemsViewed'
    ]) }} as _airbyte_ecommerce_purchases_item_category_report_combined_hashid
from {{ source('cta', 'ecommerce_purchases_item_category_report_combined') }}