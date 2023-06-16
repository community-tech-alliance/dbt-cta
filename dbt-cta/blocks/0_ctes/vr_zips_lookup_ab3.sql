{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('vr_zips_lookup_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'voter_age',
        'voter_gender',
        'turnout_score_avg',
        'count',
        'state',
        'zip5',
        'support_avg',
        'party_score_avg',
    ]) }} as _airbyte_vr_zips_lookup_hashid,
    tmp.*
from {{ ref('vr_zips_lookup_ab2') }} tmp
-- vr_zips_lookup
where 1 = 1

