{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('letter_templates_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'tips',
        'message',
        'subject',
        'targets',
        'can_edit',
        'editable',
        'variants',
        'letter_id',
        'created_at',
        'updated_at',
        'image_attribution',
    ]) }} as _airbyte_letter_templates_hashid,
    tmp.*
from {{ ref('letter_templates_ab2') }} tmp
-- letter_templates
where 1 = 1

