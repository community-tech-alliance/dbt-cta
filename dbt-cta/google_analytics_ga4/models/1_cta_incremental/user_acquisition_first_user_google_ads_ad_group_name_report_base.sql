{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_user_acquisition_first_user_google_ads_ad_group_name_report_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('user_acquisition_first_user_google_ads_ad_group_name_report_ab1') }}
select * except (_airbyte_raw_id)
from {{ ref('user_acquisition_first_user_google_ads_ad_group_name_report_ab1') }}