{{ config(
    cluster_by = "_cta_loaded_at",
    partition_by = {"field": "_cta_loaded_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_knock_conversation_code_hashid"
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_raw_knock_conversation_code') }}

select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    cast(created_at as {{ dbt_utils.type_bigint() }}) as created_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(org as {{ dbt_utils.type_string() }}) as org,
    cast(expires as {{ dbt_utils.type_bigint() }}) as expires,
    cast(conversation_type as {{ dbt_utils.type_string() }}) as conversation_type,
    cast(start_time as {{ dbt_utils.type_string() }}) as start_time,
    cast(end_time as {{ dbt_utils.type_string() }}) as end_time,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(attempt_goal as {{ dbt_utils.type_bigint() }}) as attempt_goal,
    cast(reg_goal as {{ dbt_utils.type_bigint() }}) as reg_goal,
    cast(vbm_goal as {{ dbt_utils.type_bigint() }}) as vbm_goal,
    cast(code_exhausted_email_sent as bool) as code_exhausted_email_sent,
    cast(created_by_id as {{ dbt_utils.type_bigint() }}) as created_by_id,
    cast(script_id as {{ dbt_utils.type_bigint() }}) as script_id,
    cast(targets_id as {{ dbt_utils.type_bigint() }}) as targets_id,
    cast(max_turf_size as {{ dbt_utils.type_bigint() }}) as max_turf_size,
    cast(min_turf_size as {{ dbt_utils.type_bigint() }}) as min_turf_size,
    cast(action_text as {{ dbt_utils.type_string() }}) as action_text,
    cast(action_url as {{ dbt_utils.type_string() }}) as action_url,
    cast(universal_source_code as {{ dbt_utils.type_string() }}) as universal_source_code,
    cast(starting_location_id as {{ dbt_utils.type_bigint() }}) as starting_location_id,
    cast(skip_people_search as bool) as skip_people_search,
    cast(partition_schema_name as {{ dbt_utils.type_string() }}) as partition_schema_name,
    cast(partition_name as {{ dbt_utils.type_string() }}) as partition_name,

    -- new fields
    {{ dbt_utils.surrogate_key([
        'id',
        'code',
        'created_at',
        'description',
        'org',
        'expires',
        'conversation_type',
        'start_time',
        'end_time',
        'status',
        'attempt_goal',
        'reg_goal',
        'vbm_goal',
        'code_exhausted_email_sent',
        'created_by_id',
        'script_id',
        'targets_id',
        'max_turf_size',
        'min_turf_size',
        'action_text',
        'action_url',
        'universal_source_code',
        'starting_location_id',
        'skip_people_search',
        'partition_schema_name',
        'partition_name'
    ]) }} as _knock_conversation_code_hashid,
    {{ current_timestamp() }} as _cta_loaded_at
from {{ source('cta', '_raw_knock_conversation_code') }}
where 1 = 1
