
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
   id,
   name,
   closed,
   extras,
   list_id,
   turf_id,
   archived,
   end_date,
   call_type,
   script_id,
   created_at,
   start_date,
   updated_at,
   description,
   current_round,
   daily_end_time,
   daily_start_time,
   number_of_rounds,
   created_by_user_id,
   min_call_delay_in_hours,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'closed',
    'extras',
    'list_id',
    'turf_id',
    'archived',
    'end_date',
    'call_type',
    'script_id',
    'start_date',
    'description',
    'current_round',
    'number_of_rounds',
    'created_by_user_id',
    'min_call_delay_in_hours'
    ]) }} as _airbyte_phone_banking_phone_banks_hashid
from {{ source('cta', 'phone_banking_phone_banks') }}