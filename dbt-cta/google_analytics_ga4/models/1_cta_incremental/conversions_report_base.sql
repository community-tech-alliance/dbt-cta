{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_conversions_report_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('conversions_report_ab1') }}
select * except (_airbyte_raw_id)
from {{ ref('conversions_report_ab1') }}