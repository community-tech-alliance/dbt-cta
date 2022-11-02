{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('canned_responses_attachments_ab1') }}
select
    _airbyte_canned_responses_hashid,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(size as {{ dbt_utils.type_bigint() }}) as size,
    cast(thumb_url as {{ dbt_utils.type_string() }}) as thumb_url,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(content_type as {{ dbt_utils.type_string() }}) as content_type,
    cast(attachment_url as {{ dbt_utils.type_string() }}) as attachment_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('canned_responses_attachments_ab1') }}
-- attachments at canned_responses/attachments
where 1 = 1

