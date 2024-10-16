{{ config(
    unique_key = "ap_ru_data_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('ap_ru_data_ab2') }}
select *
from {{ ref('ap_ru_data_ab2') }}
