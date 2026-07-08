{{ config(
    materialized="table"
) }}

-- Final base SQL model
-- depends_on: {{ ref('scans_qc_overview_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('scans_qc_overview_ab2') }}
