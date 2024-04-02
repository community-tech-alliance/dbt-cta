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
-- depends_on: {{ ref('forms_ab4') }}
select
    id,
    uuid,
    stats,
    title,
    hidden,
    status,
    user_id,
    group_id,
    language,
    tag_list,
    permalink,
    share_url,
    show_goal,
    created_at,
    updated_at,
    answer_goal,
    browser_url,
    target_name,
    answer_count,
    form_heading,
    instructions,
    redirect_url,
    target_title,
    csv_file_name,
    csv_file_size,
    custom_fields,
    first_publish,
    salesforce_id,
    csv_updated_at,
    display_creator,
    first_permalink,
    photo_file_name,
    photo_file_size,
    csv_content_type,
    description_info,
    description_text,
    zip_code_present,
    image_attribution,
    last_name_present,
    thank_you_subhead,
    zip_code_required,
    first_name_present,
    last_name_required,
    originating_system,
    photo_content_type,
    thank_you_headline,
    first_name_required,
    form_builder_output,
    submit_button_title,
    target_organization,
    administrative_title,
    suppress_autoresponse,
    display_sharing_options,
    form_builder_output_json,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_forms_hashid
from {{ ref('forms_ab4') }}
-- forms from {{ source('cta', '_airbyte_raw_forms') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
