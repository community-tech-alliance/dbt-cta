{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customizations_export_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'custom_field_slug',
        'custom_field_name',
        'reportable_id',
        'voterbase_id',
        'customizable_id',
        'customizable_type',
        'reported_by_email',
        'custom_field_id',
        'created_at',
        'exported_at',
        'reportable_type',
        'van_id',
        'updated_at',
        'phone',
        'user_id',
        'id',
        'fullname',
        'reported_by_fullname',
        'value',
        'email',
        'campaign_id',
    ]) }} as _airbyte_customizations_export_hashid,
    tmp.*
from {{ ref('customizations_export_ab2') }} tmp
-- customizations_export
where 1 = 1

