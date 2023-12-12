{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_pages_title_and_screen_class_report_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('pages_title_and_screen_class_report_ab1') }}
select * except (_airbyte_raw_id)
from {{ ref('pages_title_and_screen_class_report_ab1') }}