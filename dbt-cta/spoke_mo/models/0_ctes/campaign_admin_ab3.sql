{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaign_admin_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'ingest_method',
        'ingest_data_reference',
        'deleted_optouts_count',
        'updated_at',
        boolean_to_string('ingest_success'),
        'created_at',
        'id',
        'ingest_result',
        'duplicate_contacts_count',
        'contacts_count',
        'campaign_id',
    ]) }} as _airbyte_campaign_admin_hashid,
    tmp.*
from {{ ref('campaign_admin_ab2') }} tmp
-- campaign_admin
where 1 = 1


