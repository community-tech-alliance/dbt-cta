{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('business_hours_business_hours_ab3') }}
select
    _airbyte_business_hours_hashid,
    friday,
    monday,
    sunday,
    tuesday,
    saturday,
    thursday,
    wednesday,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_business_hours_2_hashid
from {{ ref('business_hours_business_hours_ab3') }}
-- business_hours at business_hours/business_hours from {{ ref('business_hours') }}
where 1 = 1

