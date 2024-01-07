
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'phone_banking_phone_banks') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   end_date,
   daily_end_time,
   min_call_delay_in_hours,
   list_id,
   extras,
   created_at,
   description,
   script_id,
   created_by_user_id,
   archived,
   updated_at,
   turf_id,
   name,
   closed,
   id,
   current_round,
   call_type,
   daily_start_time,
   number_of_rounds,
   start_date,
   {{ dbt_utils.surrogate_key([
     'end_date',
    'min_call_delay_in_hours',
    'list_id',
    'extras',
    'description',
    'script_id',
    'created_by_user_id',
    'archived',
    'turf_id',
    'name',
    'closed',
    'id',
    'current_round',
    'call_type',
    'number_of_rounds',
    'start_date'
    ]) }} as _airbyte_phone_banking_phone_banks_hashid
from {{ source('cta', 'phone_banking_phone_banks') }}