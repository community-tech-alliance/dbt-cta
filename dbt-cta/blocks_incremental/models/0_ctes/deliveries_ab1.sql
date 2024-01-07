
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
   {{ dbt_utils.surrogate_key([
     'notes',
    'batch_number',
    'form_filter_registration_date_start',
    'canvasser_id',
    'form_filter_turf_id',
    'form_filter_counties',
    'clerk_receipt_data',
    'created_by_user_id',
    'office_id',
    'turn_in_location_id',
    'delivery_method',
    'runner_receipt_data',
    'form_filter_registration_date_end',
    'id',
    'turn_in_date',
    'form_filters_no_county',
    'form_filter_qc_statuses',
    'status'
    ]) }} as _airbyte_deliveries_hashid
from {{ source('cta', 'deliveries') }}