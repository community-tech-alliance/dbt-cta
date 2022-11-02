{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('email_mailboxes_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(port as {{ dbt_utils.type_bigint() }}) as port,
    {{ cast_to_boolean('use_ssl') }} as use_ssl,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(incoming as {{ dbt_utils.type_string() }}) as incoming,
    cast(password as {{ dbt_utils.type_string() }}) as password,
    cast(username as {{ dbt_utils.type_string() }}) as username,
    cast(product_id as {{ dbt_utils.type_bigint() }}) as product_id,
    cast(access_type as {{ dbt_utils.type_string() }}) as access_type,
    cast(mail_server as {{ dbt_utils.type_string() }}) as mail_server,
    cast(mailbox_type as {{ dbt_utils.type_string() }}) as mailbox_type,
    cast(support_email as {{ dbt_utils.type_string() }}) as support_email,
    cast(authentication as {{ dbt_utils.type_string() }}) as authentication,
    cast(custom_mailbox as {{ dbt_utils.type_string() }}) as custom_mailbox,
    {{ cast_to_boolean('delete_from_server') }} as delete_from_server,
    {{ cast_to_boolean('default_reply_email') }} as default_reply_email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('email_mailboxes_ab1') }}
-- email_mailboxes
where 1 = 1

