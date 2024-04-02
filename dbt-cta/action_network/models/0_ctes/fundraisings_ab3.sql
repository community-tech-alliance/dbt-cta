{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('fundraisings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uuid',
        'stats',
        'title',
        'hidden',
        'status',
        'amounts',
        'user_id',
        'group_id',
        'language',
        'tag_list',
        'permalink',
        'recurring',
        'share_url',
        'created_at',
        'updated_at',
        'browser_url',
        'slider_type',
        'target_name',
        'dollars_goal',
        'instructions',
        'redirect_url',
        'target_title',
        'csv_file_name',
        'csv_file_size',
        'custom_fields',
        'default_email',
        'donation_goal',
        'first_publish',
        'salesforce_id',
        'csv_updated_at',
        'donation_count',
        'display_creator',
        'first_permalink',
        'photo_file_name',
        'photo_file_size',
        'csv_content_type',
        'description_info',
        'description_text',
        'recurring_upsell',
        'image_attribution',
        'recurring_options',
        'thank_you_subhead',
        'originating_system',
        'photo_content_type',
        'thank_you_headline',
        'form_builder_output',
        'target_organization',
        'administrative_title',
        'suppress_autoresponse',
        'display_sharing_options',
        'donations_without_email',
        'form_builder_output_json',
        'recurring_upsell_description',
    ]) }} as _airbyte_fundraisings_hashid,
    tmp.*
from {{ ref('fundraisings_ab2') }} as tmp
-- fundraisings
where 1 = 1
