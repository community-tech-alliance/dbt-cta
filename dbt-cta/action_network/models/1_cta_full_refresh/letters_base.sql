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
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('letters_ab3') }}
select
    id,
    uuid,
    stats,
    title,
    hidden,
    status,
    target,
    user_id,
    group_id,
    language,
    tag_list,
    permalink,
    share_url,
    show_goal,
    test_mode,
    created_at,
    updated_at,
    browser_url,
    description,
    goal_slider,
    city_present,
    instructions,
    redirect_url,
    city_required,
    csv_file_name,
    csv_file_size,
    custom_fields,
    delivery_goal,
    first_publish,
    salesforce_id,
    csv_updated_at,
    delivery_count,
    street_present,
    display_creator,
    first_permalink,
    photo_file_name,
    photo_file_size,
    street_required,
    csv_content_type,
    image_attribution,
    thank_you_subhead,
    no_target_redirect,
    originating_system,
    photo_content_type,
    thank_you_headline,
    form_builder_output,
    administrative_title,
    letter_template_count,
    suppress_autoresponse,
    display_sharing_options,
    form_builder_output_json,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_letters_hashid
from {{ ref('letters_ab3') }}
-- letters from {{ source('cta', '_airbyte_raw_letters') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
