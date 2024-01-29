{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_templates_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'template_content',
        'name',
        'extras',
        'created_at',
        'id',
        'created_by_user_id',
    ]) }} as _airbyte_email_templates_hashid,
    tmp.*
from {{ ref('email_templates_ab2') }} as tmp
-- email_templates
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

