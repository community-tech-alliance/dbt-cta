{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'deliveries') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    notes,
    status,
    office_id,
    created_at,
    updated_at,
    batch_number,
    canvasser_id,
    turn_in_date,
    delivery_method,
    clerk_receipt_data,
    created_by_user_id,
    form_filter_turf_id,
    runner_receipt_data,
    turn_in_location_id,
    form_filter_counties,
    form_filters_no_county,
    form_filter_qc_statuses,
    form_filter_registration_date_end,
    form_filter_registration_date_start,
   {{ dbt_utils.surrogate_key([
     'id',
    'notes',
    'status',
    'office_id',
    'batch_number',
    'canvasser_id',
    'turn_in_date',
    'delivery_method',
    'clerk_receipt_data',
    'created_by_user_id',
    'form_filter_turf_id',
    'runner_receipt_data',
    'turn_in_location_id',
    'form_filter_counties',
    'form_filters_no_county',
    'form_filter_qc_statuses',
    'form_filter_registration_date_end',
    'form_filter_registration_date_start'
    ]) }} as _airbyte_deliveries_hashid
from {{ source('cta', 'deliveries') }}
