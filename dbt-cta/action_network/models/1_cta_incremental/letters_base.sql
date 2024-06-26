{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('letters_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_letters_hashid
from {{ ref('letters_ab4') }}
