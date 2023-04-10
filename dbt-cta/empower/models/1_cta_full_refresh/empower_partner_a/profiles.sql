{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "empower_partner_a",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='profiles_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('profiles_ab3') }}
select
    zip,
    lastUsedEmpowerMts,
    eid,
    lastName,
    canvassedByCtaId,
    role,
    notes,
    address,
    myCampaignVanId,
    city,
    address2,
    createdMts,
    parentEid,
    activeCtaIds,
    firstName,
    currentCtaId,
    vanId,
    updatedMts,
    phone,
    regionId,
    state,
    relationship,
    email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_profiles_hashid
from {{ ref('profiles_ab3') }}
-- profiles from {{ source('empower_partner_a', '_airbyte_raw_profiles') }}
where 1 = 1
