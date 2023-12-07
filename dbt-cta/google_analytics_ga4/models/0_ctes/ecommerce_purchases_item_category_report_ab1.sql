
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'ecommerce_purchases_item_category_report') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   purchaseToViewRate,
   itemRevenue,
   itemCategory,
   itemsAddedToCart,
   itemsPurchased,
   cartToViewRate,
   itemsViewed,
   property_id,
   {{ dbt_utils.surrogate_key([
     '_airbyte_raw_id',
    '_airbyte_extracted_at',
    'date',
    'itemCategory',
    'itemsAddedToCart',
    'itemsPurchased',
    'itemsViewed',
    'property_id'
    ]) }} as _airbyte_ecommerce_purchases_item_category_report_hashid
from {{ source('cta', 'ecommerce_purchases_item_category_report') }}