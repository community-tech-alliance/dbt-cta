{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('letters_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uuid',
        'stats',
        'title',
        'hidden',
        'status',
        'target',
        'user_id',
        'group_id',
        'language',
        'tag_list',
        'permalink',
        'share_url',
        'show_goal',
        'test_mode',
        'created_at',
        'updated_at',
        'browser_url',
        'description',
        'goal_slider',
        'city_present',
        'instructions',
        'redirect_url',
        'city_required',
        'csv_file_name',
        'csv_file_size',
        'custom_fields',
        'delivery_goal',
        'first_publish',
        'salesforce_id',
        'csv_updated_at',
        'delivery_count',
        'street_present',
        'display_creator',
        'first_permalink',
        'photo_file_name',
        'photo_file_size',
        'street_required',
        'csv_content_type',
        'image_attribution',
        'thank_you_subhead',
        'no_target_redirect',
        'originating_system',
        'photo_content_type',
        'thank_you_headline',
        'form_builder_output',
        'administrative_title',
        'letter_template_count',
        'suppress_autoresponse',
        'display_sharing_options',
        'form_builder_output_json',
    ]) }} as _airbyte_letters_hashid,
    tmp.*
from {{ ref('letters_ab2') }} tmp
-- letters
where 1 = 1

