{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('catalist_uploads_registration_forms_ab1') }}
select
    cast(registration_form_id as {{ dbt_utils.type_bigint() }}) as registration_form_id,
    cast(catalist_upload_id as {{ dbt_utils.type_bigint() }}) as catalist_upload_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('catalist_uploads_registration_forms_ab1') }}
-- catalist_uploads_registration_forms
where 1 = 1
