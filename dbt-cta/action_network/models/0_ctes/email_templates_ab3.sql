{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_templates_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'uuid',
        'notes',
        'footer',
        'header',
        'user_id',
        'group_id',
        'created_at',
        'syndicated',
        'updated_at',
        'from_suffix',
        'unsubscribe',
        'logo_file_name',
        'logo_file_size',
        'logo_dimensions',
        'logo_content_type',
    ]) }} as _airbyte_email_templates_hashid,
    tmp.*
from {{ ref('email_templates_ab2') }} as tmp
-- email_templates
where 1 = 1
