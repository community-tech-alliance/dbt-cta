{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_settings_ab1') }}
select
    _airbyte_campaigns_hashid,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(to_name as {{ dbt_utils.type_string() }}) as to_name,
    cast(reply_to as {{ dbt_utils.type_string() }}) as reply_to,
    {{ cast_to_boolean('timewarp') }} as timewarp,
    cast(folder_id as {{ dbt_utils.type_string() }}) as folder_id,
    cast(from_name as {{ dbt_utils.type_string() }}) as from_name,
    {{ cast_to_boolean('auto_tweet') }} as auto_tweet,
    {{ cast_to_boolean('inline_css') }} as inline_css,
    {{ cast_to_boolean('auto_footer') }} as auto_footer,
    {{ cast_to_boolean('fb_comments') }} as fb_comments,
    cast(template_id as {{ dbt_utils.type_bigint() }}) as template_id,
    {{ cast_to_boolean('authenticate') }} as authenticate,
    auto_fb_post,
    cast(preview_text as {{ dbt_utils.type_string() }}) as preview_text,
    cast(subject_line as {{ dbt_utils.type_string() }}) as subject_line,
    {{ cast_to_boolean('drag_and_drop') }} as drag_and_drop,
    {{ cast_to_boolean('use_conversation') }} as use_conversation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_settings_ab1') }}
-- settings at campaigns/settings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

