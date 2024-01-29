{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('delivery_targets_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'uuid',
        'bioid',
        'email',
        'status',
        'message',
        'subject',
        'form_data',
        'created_at',
        'updated_at',
        'captcha_uid',
        'captcha_url',
        'delivery_id',
        'target_name',
        'target_party',
        'target_state',
        'delivery_method',
        'target_district',
        'target_position',
        'captcha_required',
        'letter_template_id',
    ]) }} as _airbyte_delivery_targets_hashid,
    tmp.*
from {{ ref('delivery_targets_ab2') }} as tmp
-- delivery_targets
where 1 = 1
