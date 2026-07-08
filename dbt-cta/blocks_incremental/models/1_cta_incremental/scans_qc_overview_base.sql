{{ config(
    materialized="table"
) }}

-- Final base SQL model
-- depends_on: {{ ref('scans_qc_overview_ab1') }}
select * except (_airbyte_raw_id)
from {{ ref('scans_qc_overview_ab1') }}
