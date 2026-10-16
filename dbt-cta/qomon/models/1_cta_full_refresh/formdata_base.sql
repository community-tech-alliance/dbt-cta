{{ config(
    materialized="table"
) }}
-- Final base SQL model
-- depends_on: {{ ref('formdata_ab2') }}
select *
from {{ ref('formdata_ab2') }}
