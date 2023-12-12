{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('deliveries_ab3') }}
select
    notes,
    batch_number,
    form_filter_registration_date_start,
    canvasser_id,
    created_at,
    form_filter_turf_id,
    form_filter_counties,
    clerk_receipt_data,
    created_by_user_id,
    office_id,
    updated_at,
    turn_in_location_id,
    delivery_method,
    runner_receipt_data,
    form_filter_registration_date_end,
    id,
    turn_in_date,
    form_filters_no_county,
    form_filter_qc_statuses,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_deliveries_hashid
from {{ ref('deliveries_ab3') }}
-- deliveries from {{ source('cta', '_airbyte_raw_deliveries') }}

