{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('catalist_uploads_registration_forms_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'registration_form_id',
        'catalist_upload_id',
    ]) }} as _airbyte_catalist_uploads_registration_forms_hashid,
    tmp.*
from {{ ref('catalist_uploads_registration_forms_ab2') }} tmp
-- catalist_uploads_registration_forms
where 1 = 1

