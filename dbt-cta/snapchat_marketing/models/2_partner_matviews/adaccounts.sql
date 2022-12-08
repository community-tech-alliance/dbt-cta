{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_adaccounts_hashid'
) }}

SELECT
   _airbyte_adaccounts_hashid
  ,MAX(id) as id
  ,MAX(name) as name
  ,MAX(type) as type
  ,MAX(status) as status
  ,MAX(currency) as currency
  ,MAX(timezone) as timezone
  ,MAX(created_at) as created_at
  ,MAX(updated_at) as updated_at
  ,MAX(regulations) as regulations
  ,MAX(billing_type) as billing_type
  ,MAX(organization_id) as organization_id
  ,MAX(billing_center_id) as billing_center_id
  ,MAX(ARRAY_TO_STRING(funding_source_ids,',')) as funding_source_ids
  ,MAX(client_paying_invoices) as client_paying_invoices
  ,MAX(advertiser_organization_id) as advertiser_organization_id
  ,MAX(agency_representing_client) as agency_representing_client
  ,MAX(_airbyte_ab_id) as _airbyte_ab_id
  ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
  ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'adaccounts_base') }}
GROUP BY _airbyte_adaccounts_hashid
