{{ config(
    cluster_by = "_cta_loaded_at",
    partition_by = {"field": "_cta_loaded_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_redshift_people_celloptins_conversations_hashid"
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_raw_redshift_people_celloptins_conversations') }}

select
    cast(of_people_id as {{ dbt_utils.type_bigint() }}) as of_people_id,
    cast(conversation_id as {{ dbt_utils.type_bigint() }}) as conversation_id,
    cast(conversation_time as {{ dbt_utils.type_bigint() }}) as conversation_time,
    cast(conversation_type as {{ dbt_utils.type_string() }}) as conversation_type,
    cast(contact_type as {{ dbt_utils.type_string() }}) as contact_type,
    cast(canvasser as {{ dbt_utils.type_string() }}) as canvasser,
    cast(state_file_id as {{ dbt_utils.type_string() }}) as state_file_id,
    cast(other_voter_file_id as {{ dbt_utils.type_string() }}) as other_voter_file_id,
    cast(van_id as {{ dbt_utils.type_string() }}) as van_id,
    cast(my_campaign_id as {{ dbt_utils.type_string() }}) as my_campaign_id,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(middle_name as {{ dbt_utils.type_string() }}) as middle_name,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(suffix as {{ dbt_utils.type_string() }}) as suffix,
    cast(preferred_name as {{ dbt_utils.type_string() }}) as preferred_name,
    cast(sex as {{ dbt_utils.type_string() }}) as sex,
    cast(age as {{ dbt_utils.type_bigint() }}) as age,
    cast(phone1 as {{ dbt_utils.type_string() }}) as phone1,
    cast(email1 as {{ dbt_utils.type_string() }}) as email1,
    cast(email_opt_in1 as bool) as email_opt_in1,
    cast(address1 as {{ dbt_utils.type_string() }}) as address1,
    cast(address2 as {{ dbt_utils.type_string() }}) as address2,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(county as {{ dbt_utils.type_string() }}) as county,
    cast(zip_5 as {{ dbt_utils.type_string() }}) as zip_5,
    cast(contact_script_id as {{ dbt_utils.type_bigint() }}) as contact_script_id,
    cast(conversation_code_id as {{ dbt_utils.type_bigint() }}) as conversation_code_id,
    cast(question_id as {{ dbt_utils.type_bigint() }}) as question_id,
    cast(question_text as {{ dbt_utils.type_string() }}) as question_text,
    cast(response as {{ dbt_utils.type_string() }}) as response,
    cast(partition_schema_name as {{ dbt_utils.type_string() }}) as partition_schema_name,
    cast(partition_name as {{ dbt_utils.type_string() }}) as partition_name,

    -- new fields
    {{ dbt_utils.generate_surrogate_key([
        'of_people_id',
        'conversation_id',
        'conversation_time',
        'conversation_type',
        'contact_type',
        'canvasser',
        'state_file_id',
        'other_voter_file_id',
        'van_id',
        'my_campaign_id',
        'first_name',
        'middle_name',
        'last_name',
        'suffix',
        'preferred_name',
        'sex',
        'age',
        'phone1',
        'email1',
        'email_opt_in1',
        'address1',
        'address2',
        'city',
        'state',
        'county',
        'zip_5',
        'contact_script_id',
        'conversation_code_id',
        'question_id',
        'question_text',
        'response',
        'partition_schema_name',
        'partition_name',
    ]) }} as _redshift_people_celloptins_conversations_hashid,
    {{ current_timestamp() }} as _cta_loaded_at
from {{ source('cta', '_raw_redshift_people_celloptins_conversations') }}
where 1 = 1
