{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('forms_export_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'last_name',
        'created_at',
        'contact_id',
        'contact_referral_id',
        'zip_code',
        'exported_at',
        'updated_at',
        'phone',
        'team_referral_id',
        'activity_id',
        'id',
        boolean_to_string('opt_in'),
        'first_name',
        'email',
        'campaign_id',
        'activity_title',
    ]) }} as _airbyte_forms_export_hashid,
    tmp.*
from {{ ref('forms_export_ab2') }} tmp
-- forms_export
where 1 = 1

