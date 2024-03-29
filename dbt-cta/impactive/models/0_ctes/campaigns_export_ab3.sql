{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_export_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'updated_at',
        'name',
        'created_at',
        'id',
        'slug',
        'exported_at',
    ]) }} as _airbyte_campaigns_export_hashid,
    tmp.*
from {{ ref('campaigns_export_ab2') }} tmp
-- campaigns_export
where 1 = 1

