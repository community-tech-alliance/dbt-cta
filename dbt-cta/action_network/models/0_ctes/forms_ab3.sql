{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('forms_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uuid',
        'stats',
        'title',
        'hidden',
        'status',
        'user_id',
        'group_id',
        'language',
        'tag_list',
        'permalink',
        'share_url',
        'show_goal',
        'created_at',
        'updated_at',
        'answer_goal',
        'browser_url',
        'target_name',
        'answer_count',
        'form_heading',
        'instructions',
        'redirect_url',
        'target_title',
        'csv_file_name',
        'csv_file_size',
        'custom_fields',
        'first_publish',
        'salesforce_id',
        'csv_updated_at',
        'display_creator',
        'first_permalink',
        'photo_file_name',
        'photo_file_size',
        'csv_content_type',
        'description_info',
        'description_text',
        'zip_code_present',
        'image_attribution',
        'last_name_present',
        'thank_you_subhead',
        'zip_code_required',
        'first_name_present',
        'last_name_required',
        'originating_system',
        'photo_content_type',
        'thank_you_headline',
        'first_name_required',
        'form_builder_output',
        'submit_button_title',
        'target_organization',
        'administrative_title',
        'suppress_autoresponse',
        'display_sharing_options',
        'form_builder_output_json',
    ]) }} as _airbyte_forms_hashid,
    tmp.*
from {{ ref('forms_ab2') }} as tmp
-- forms
where 1 = 1
