{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('forms_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(stats as {{ dbt_utils.type_string() }}) as stats,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(language as {{ dbt_utils.type_string() }}) as language,
    cast(tag_list as {{ dbt_utils.type_string() }}) as tag_list,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(share_url as {{ dbt_utils.type_string() }}) as share_url,
    cast(show_goal as {{ dbt_utils.type_bigint() }}) as show_goal,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(answer_goal as {{ dbt_utils.type_bigint() }}) as answer_goal,
    cast(browser_url as {{ dbt_utils.type_string() }}) as browser_url,
    cast(target_name as {{ dbt_utils.type_string() }}) as target_name,
    cast(answer_count as {{ dbt_utils.type_bigint() }}) as answer_count,
    cast(form_heading as {{ dbt_utils.type_string() }}) as form_heading,
    cast(instructions as {{ dbt_utils.type_string() }}) as instructions,
    cast(redirect_url as {{ dbt_utils.type_string() }}) as redirect_url,
    cast(target_title as {{ dbt_utils.type_string() }}) as target_title,
    cast(csv_file_name as {{ dbt_utils.type_string() }}) as csv_file_name,
    cast(csv_file_size as {{ dbt_utils.type_bigint() }}) as csv_file_size,
    cast(custom_fields as {{ dbt_utils.type_string() }}) as custom_fields,
    cast(first_publish as {{ dbt_utils.type_bigint() }}) as first_publish,
    cast(salesforce_id as {{ dbt_utils.type_string() }}) as salesforce_id,
    cast(csv_updated_at as {{ dbt_utils.type_string() }}) as csv_updated_at,
    cast(display_creator as {{ dbt_utils.type_bigint() }}) as display_creator,
    cast(first_permalink as {{ dbt_utils.type_string() }}) as first_permalink,
    cast(photo_file_name as {{ dbt_utils.type_string() }}) as photo_file_name,
    cast(photo_file_size as {{ dbt_utils.type_bigint() }}) as photo_file_size,
    cast(csv_content_type as {{ dbt_utils.type_string() }}) as csv_content_type,
    cast(description_info as {{ dbt_utils.type_string() }}) as description_info,
    cast(description_text as {{ dbt_utils.type_string() }}) as description_text,
    cast(zip_code_present as {{ dbt_utils.type_bigint() }}) as zip_code_present,
    cast(image_attribution as {{ dbt_utils.type_string() }}) as image_attribution,
    cast(last_name_present as {{ dbt_utils.type_bigint() }}) as last_name_present,
    cast(thank_you_subhead as {{ dbt_utils.type_string() }}) as thank_you_subhead,
    cast(zip_code_required as {{ dbt_utils.type_bigint() }}) as zip_code_required,
    cast(first_name_present as {{ dbt_utils.type_bigint() }}) as first_name_present,
    cast(last_name_required as {{ dbt_utils.type_bigint() }}) as last_name_required,
    cast(originating_system as {{ dbt_utils.type_string() }}) as originating_system,
    cast(photo_content_type as {{ dbt_utils.type_string() }}) as photo_content_type,
    cast(thank_you_headline as {{ dbt_utils.type_string() }}) as thank_you_headline,
    cast(first_name_required as {{ dbt_utils.type_bigint() }}) as first_name_required,
    cast(form_builder_output as {{ dbt_utils.type_string() }}) as form_builder_output,
    cast(submit_button_title as {{ dbt_utils.type_string() }}) as submit_button_title,
    cast(target_organization as {{ dbt_utils.type_string() }}) as target_organization,
    cast(administrative_title as {{ dbt_utils.type_string() }}) as administrative_title,
    cast(suppress_autoresponse as {{ dbt_utils.type_bigint() }}) as suppress_autoresponse,
    cast(display_sharing_options as {{ dbt_utils.type_bigint() }}) as display_sharing_options,
    cast(form_builder_output_json as {{ dbt_utils.type_string() }}) as form_builder_output_json,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('forms_ab1') }}
-- forms
where 1 = 1
