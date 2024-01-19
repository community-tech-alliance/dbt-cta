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
-- depends_on: {{ ref('fundraisings_ab3') }}
select
    id,
    uuid,
    stats,
    title,
    hidden,
    status,
    amounts,
    user_id,
    group_id,
    language,
    tag_list,
    permalink,
    recurring,
    share_url,
    created_at,
    updated_at,
    browser_url,
    slider_type,
    target_name,
    dollars_goal,
    instructions,
    redirect_url,
    target_title,
    csv_file_name,
    csv_file_size,
    custom_fields,
    default_email,
    donation_goal,
    first_publish,
    salesforce_id,
    csv_updated_at,
    donation_count,
    display_creator,
    first_permalink,
    photo_file_name,
    photo_file_size,
    csv_content_type,
    description_info,
    description_text,
    recurring_upsell,
    image_attribution,
    recurring_options,
    thank_you_subhead,
    originating_system,
    photo_content_type,
    thank_you_headline,
    form_builder_output,
    target_organization,
    administrative_title,
    suppress_autoresponse,
    display_sharing_options,
    donations_without_email,
    form_builder_output_json,
    recurring_upsell_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_fundraisings_hashid
from {{ ref('fundraisings_ab3') }}
-- fundraisings from {{ source('cta', '_airbyte_raw_fundraisings') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
