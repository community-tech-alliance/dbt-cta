{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('phone_banking_phone_banks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'end_date',
        'daily_end_time',
        'min_call_delay_in_hours',
        'list_id',
        'extras',
        'created_at',
        'description',
        'script_id',
        'created_by_user_id',
        boolean_to_string('archived'),
        'updated_at',
        'turf_id',
        'name',
        boolean_to_string('closed'),
        'id',
        'current_round',
        'call_type',
        'daily_start_time',
        'number_of_rounds',
        'start_date',
    ]) }} as _airbyte_phone_banking_phone_banks_hashid,
    tmp.*
from {{ ref('phone_banking_phone_banks_ab2') }} tmp
-- phone_banking_phone_banks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

