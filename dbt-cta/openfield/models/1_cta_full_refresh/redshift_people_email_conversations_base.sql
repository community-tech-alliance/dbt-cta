{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)"
] %}
{{ config(
    cluster_by = "_cta_loaded_at",
    partition_by = {"field": "_cta_loaded_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_redshift_people_email_conversations_hashid"
) }}
-- Final base SQL model
-- depends_on: {{ ref('redshift_people_email_conversations_cte2') }}
select
    of_people_id,
    conversation_id,
    conversation_time,
    conversation_type,
    contact_type,
    canvasser,
    state_file_id,
    other_voter_file_id,
    van_id,
    my_campaign_id,
    first_name,
    middle_name,
    last_name,
    suffix,
    preferred_name,
    sex,
    age,
    phone1,
    email1,
    email_opt_in1,
    address1,
    address2,
    city,
    state,
    county,
    zip_5,
    contact_script_id,
    conversation_code_id,
    question_id,
    question_text,
    response,
    email_opt_in,
    _redshift_people_email_conversations_hashid,
    _cta_loaded_at
from {{ ref('redshift_people_email_conversations_cte2') }}

{% if is_incremental() %}
where timestamp_trunc(_cta_loaded_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
