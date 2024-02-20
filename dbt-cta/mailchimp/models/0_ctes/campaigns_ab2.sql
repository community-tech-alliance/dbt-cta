{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
) }}

-- depends_on: {{ ref('campaigns_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    type,
    status,
    cast(web_id as {{ dbt_utils.type_bigint() }}) as web_id,
    cast(rss_opts as {{ type_json() }}) as rss_opts,
    cast(settings as {{ type_json() }}) as settings,
    cast(tracking as {{ type_json() }}) as tracking,
    cast(send_time as {{ dbt_utils.type_string() }}) as send_time,
    cast(recipients as {{ type_json() }}) as recipients,
    {{ cast_to_boolean('resendable') }} as resendable,
    cast(archive_url as {{ dbt_utils.type_string() }}) as archive_url,
    cast(create_time as {{ dbt_utils.type_string() }}) as create_time,
    cast(emails_sent as {{ dbt_utils.type_bigint() }}) as emails_sent,
    cast(social_card as {{ type_json() }}) as social_card,
    cast(content_type as {{ dbt_utils.type_string() }}) as content_type,
    cast(ab_split_opts as {{ type_json() }}) as ab_split_opts,
    cast(report_summary as {{ type_json() }}) as report_summary,
    cast(delivery_status as {{ type_json() }}) as delivery_status,
    cast(long_archive_url as {{ dbt_utils.type_string() }}) as long_archive_url,
    cast(variate_settings as {{ type_json() }}) as variate_settings,
    cast(parent_campaign_id as {{ dbt_utils.type_string() }}) as parent_campaign_id,
    {{ cast_to_boolean('needs_block_refresh') }} as needs_block_refresh,
    _airbyte_raw_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_ab1') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

